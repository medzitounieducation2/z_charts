import 'package:flutter/material.dart';
import 'package:z_charts/package/charts/z_dynamic_chart.dart';
import 'package:z_charts/package/factories/z_params_service_factory.dart';
import 'package:z_charts/package/models/z_chart_params.dart';
import 'package:z_charts/package/services/z_data_service.dart';

class ZMiniDynamicChartView extends StatefulWidget {
  final String pageId;
  final String unit;
  final String label;
  final ZDataService dataService;

  const ZMiniDynamicChartView({super.key, required this.pageId, required this.unit, required this.label, required this.dataService});

  @override
  State<ZMiniDynamicChartView> createState() => ZMiniDynamicChartViewState();
}

class ZMiniDynamicChartViewState extends State<ZMiniDynamicChartView> {
  ZDynamicChart? dynamicChart;
  ZChartParams? chartParams;
  var dynamicChartKey = GlobalKey<ZDynamicChartState>();

  @override
  void initState() {
    super.initState();
    loadChartParams();
  }

  loadChartParams() {
    var service = ZParamsServiceFactory.paramsService(context);
    service.getByPageId(widget.pageId)
    .then((savedParams) {
      if(savedParams == null) {
        var params = ZChartParams(
          id: 1,
          periodType: 'this_month',
          pageId: widget.pageId,
          timeUnit: 'day',
          chartType: 'line',
          fromDate: DateTime.now(),
          toDate: DateTime.now(),
        );
        service.addEntity(params)
        .then((newSaved) {
          setState(() {
            chartParams = savedParams;
            dynamicChart = ZDynamicChart(
              key: dynamicChartKey,
              chartParams: newSaved,
              dataService: widget.dataService,
              unit: widget.unit,
            );
          });
        });
      } else {
        setState(() {
          chartParams = savedParams;
          dynamicChart = ZDynamicChart(
            key: dynamicChartKey,
            chartParams: savedParams,
            dataService: widget.dataService,
            unit: widget.unit,
          );
        });
      }
    });
  }
  refreshChart() {
    dynamicChartKey.currentState?.refreshChart();
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
                  top: -10,
                  right: -12,
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
