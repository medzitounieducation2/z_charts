import 'package:flutter/material.dart';
import 'package:z_charts/exportable/charts/z_bar_chart.dart';
import 'package:z_charts/exportable/charts/z_line_chart.dart';
import 'package:z_charts/exportable/enums/z_chart_type_enum.dart';
import 'package:z_charts/exportable/models/z_data_config.dart';
import 'package:z_charts/exportable/models/z_params.dart';
import 'package:z_charts/exportable/services/z_data_service.dart';
import 'package:z_charts/exportable/utils/z_period_dates_util.dart';
import 'package:z_charts/exportable/utils/z_data_utils.dart';

class ZChart extends StatefulWidget {
  final ZParams chartParams;
  final ZDataService dataService;
  final String unit;
  const ZChart({super.key, required this.chartParams, required this.dataService, required this.unit});

  @override
  State<ZChart> createState() => ZChartState();
}

class ZChartState extends State<ZChart> {
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
    var periodDates = zGetPeriodDatesUtil(widget.chartParams.periodType);
    if(periodDates != null) {
      fromDate = periodDates['fromDate']!;
      toDate = periodDates['toDate']!;
    }
    widget.dataService.fetchEntitiesBetween(fromDate, toDate).then((entities) {
      var data = widget.dataService.adaptData(entities);
      setState(() {
        dataList = data;
      });
    });
  }

  ZDataConfig buildChartConfig(List<Map<String, dynamic>> data) {
    List<double> values = data.map((item) => item['value'] as double).toList();
    // Find min and max
    double minValue = values.reduce((a, b) => a < b ? a : b);
    double maxValue = values.reduce((a, b) => a > b ? a : b);
    double minX = 0;
    double maxX = data.length.toDouble() - 1;
    double horizontalInterval = maxValue > 100 ? 10 : 1;
    return ZDataConfig(
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
    ZDataUtils dataUtils = ZDataUtils();
    var data = dataUtils.build(dataList!, widget.chartParams);
    ZDataConfig chartConfig = buildChartConfig(data);
    return widget.chartParams.chartType == ChartTypeEnum.LINE.name
        ? ZLineChart(data: data, chartConfig: chartConfig, unit: widget.unit,)
        : ZBarChart(data: data, chartConfig: chartConfig, unit: widget.unit);
  }
}
