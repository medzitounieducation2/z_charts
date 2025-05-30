import 'package:flutter/material.dart';
import 'package:z_charts/charts/dynamic/z_dynamic_bar_chart.dart';
import 'package:z_charts/charts/dynamic/z_dynamic_line_chart.dart';
import 'package:z_charts/models/z_chart_data_config.dart';
import 'package:z_charts/models/z_chart_params.dart';
import 'package:z_charts/services/z_charts_service.dart';
import 'package:z_charts/services/z_data_service.dart';
import 'package:z_charts/utils/z_chart_data_utils.dart';

class ZDynamicChart extends StatefulWidget {
  final ZChartParams chartParams;
  final ZDataService dataService;
  final ZChartsService chartsService;
  final String unit;
  const ZDynamicChart({super.key, required this.chartParams, required this.dataService, required this.chartsService, required this.unit});

  @override
  State<ZDynamicChart> createState() => ZDynamicChartState();
}

class ZDynamicChartState extends State<ZDynamicChart> {
  List<Map<String, dynamic>>? dataList;

  @override
  void initState() {
    super.initState();
    loadChartData();
  }

  refreshChart() {
    loadChartData();
  }

  void loadChartData() {
    var fromDate = widget.chartParams.fromDate;
    var toDate = widget.chartParams.toDate;
    if(widget.chartParams.periodType == 'this_year'){
      final now = DateTime.now();
      fromDate = DateTime(now.year, 1, 1);
      toDate = DateTime(now.year, 12 + 1, 31);
    } else if(widget.chartParams.periodType == 'this_month'){
      final now = DateTime.now();
      fromDate = DateTime(now.year, now.month, 1);
      toDate = DateTime(now.year, now.month + 1, 0);
    } else if(widget.chartParams.periodType == 'this_week') {
      final int currentWeekday = DateTime.now()
          .weekday; // Monday = 1, Sunday = 7
      fromDate = DateTime.now().subtract(
          Duration(
              days: currentWeekday -
                  1)); // Go back to Monday
      toDate = fromDate
          .add(const Duration(
          days:
          6)); // Sunday of the same week
    }
    widget.dataService.fetchEntitiesBetween(fromDate, toDate).then((entities) {
      var data = widget.chartsService.convertEntities(entities);
      setState(() {
        dataList = data;
      });
    });
  }

  ZChartDataConfig buildChartConfig(List<Map<String, dynamic>> data) {
    List<double> values = data.map((item) => item['value'] as double).toList();
    // Find min and max
    double minValue = values.reduce((a, b) => a < b ? a : b);
    double maxValue = values.reduce((a, b) => a > b ? a : b);
    double minX = 0;
    double maxX = data.length.toDouble() - 1;
    double horizontalInterval = maxValue > 100 ? 10 : 1;
    return ZChartDataConfig(
        minValue: minValue,
        maxValue: maxValue,
        minX: minX,
        maxX: maxX,
        horizontalInterval: horizontalInterval);
  }

  @override
  Widget build(BuildContext context) {
    if(dataList == null || dataList!.isEmpty) {
      return Center(child: Text('No chart data!'));
    }
    ZChartDataUtils dataUtils = ZChartDataUtils();
    var data = dataUtils.build(dataList!, widget.chartParams);
    ZChartDataConfig chartConfig = buildChartConfig(data);
    return widget.chartParams.chartType == 'line'
        ? ZDynamicLineChart(data: data, chartConfig: chartConfig, unit: widget.unit,)
        : ZDynamicBarChart(data: data, chartConfig: chartConfig, unit: widget.unit);
  }
}
