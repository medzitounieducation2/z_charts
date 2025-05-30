import 'package:flutter/material.dart';
import 'package:z_charts/charts/dynamic/z_dynamic_chart.dart';
import 'package:z_charts/models/z_chart_params.dart';
import 'package:z_charts/services/z_charts_service.dart';
import 'package:z_charts/services/z_data_service.dart';

class ZMiniDynamicChartView extends StatefulWidget {
  final String pageId;
  final String unit;
  final String label;
  final ZDataService dataService;
  final ZChartsService chartsService;

  const ZMiniDynamicChartView({super.key, required this.pageId, required this.unit, required this.label, required this.dataService, required this.chartsService});

  @override
  State<ZMiniDynamicChartView> createState() => _ZMiniDynamicChartViewState();
}

class _ZMiniDynamicChartViewState extends State<ZMiniDynamicChartView> {
  ZDynamicChart? dynamicChart;
  ZChartParams? chartParams;

  @override
  void initState() {
    super.initState();
    chartParams = ZChartParams(
      id: 1,
      periodType: 'this_year',
      pageId: widget.pageId,
      timeUnit: 'week',
      chartType: 'line',
      fromDate: DateTime.now(),
      toDate: DateTime.now(),
    );

    dynamicChart = ZDynamicChart(
      chartParams: chartParams!,
      dataService: widget.dataService,
      chartsService: widget.chartsService,
      unit: widget.unit,
    );

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Stack(
              children: [
                // Placeholder for your chart
                Container(
                  height: 250,
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  child: dynamicChart ?? SizedBox(),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.settings), //Icons.open_in_full
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
