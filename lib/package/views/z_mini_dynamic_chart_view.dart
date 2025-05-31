import 'package:flutter/material.dart';
import 'package:z_charts/package/charts/z_dynamic_chart.dart';
import 'package:z_charts/package/factories/z_params_service_factory.dart';
import 'package:z_charts/package/models/z_chart_params.dart';
import 'package:z_charts/package/services/z_data_service.dart';
import 'package:z_charts/package/views/z_full_dynamic_chart_view.dart';

class ZMiniDynamicChartView extends StatefulWidget {
  final dynamic pageId;
  final String unit;
  final String label;
  final ZDataService dataService;

  const ZMiniDynamicChartView({
    super.key,
    required this.pageId,
    required this.unit,
    required this.label,
    required this.dataService,
  });

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
    _loadChartParams();
  }

  _loadChartParams() {
    var service = ZParamsServiceFactory.paramsService(context);
    service.getByPageId(widget.pageId).then((savedParams) {
      if (savedParams == null) {
        var params = ZChartParams(
          id: 1,
          periodType: 'this_month',
          pageId: widget.pageId,
          timeUnit: 'day',
          chartType: 'line',
          fromDate: DateTime.now(),
          toDate: DateTime.now(),
        );
        service.addEntity(params).then((newSaved) {
          setState(() {
            chartParams = savedParams;
          });
        });
      } else {
        setState(() {
          chartParams = savedParams;
        });
      }
    });
  }

  refreshChart() {
    dynamicChartKey.currentState?.refreshChart();
  }

  _navigateToFullDynamicChartPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ZFullDynamicChartView(
              pageId: widget.pageId,
              dataService: widget.dataService,
              label: widget.label,
              unit: widget.unit,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                chartParams == null
                    ? Container()
                    : Container(
                      height: 250,
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: ZDynamicChart(
                        key: dynamicChartKey,
                        chartParams: chartParams!,
                        dataService: widget.dataService,
                        unit: widget.unit,
                      ),
                    ),
                Positioned(
                  top: -10,
                  right: -12,
                  child: IconButton(
                    icon: const Icon(Icons.settings), //Icons.open_in_full
                    onPressed: _navigateToFullDynamicChartPage,
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
