import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:z_charts/package/charts/z_dynamic_chart.dart';
import 'package:z_charts/package/factories/z_params_service_factory.dart';
import 'package:z_charts/package/models/z_chart_params.dart';
import 'package:z_charts/package/services/z_data_service.dart';
import 'package:z_charts/package/widgets/z_chart_setting_widget.dart';

class ZFullDynamicChartView extends StatefulWidget {
  final String pageId;
  final String unit;
  final String label;
  final ZDataService dataService;

  const ZFullDynamicChartView({
    super.key,
    required this.pageId,
    required this.unit,
    required this.label,
    required this.dataService,
  });

  @override
  State<ZFullDynamicChartView> createState() => _ZFullDynamicChartViewState();
}

class _ZFullDynamicChartViewState extends State<ZFullDynamicChartView> {
  ZChartParams? chartParams;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
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

  @override
  void dispose() {
    // Reset orientation when leaving the page
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.label),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Return to previous page
        ),
      ),
      body: SingleChildScrollView(
        // Allows scrolling if content overflows
        scrollDirection: Axis.horizontal, // Expands width horizontally
        child: Row(
          children: [
            chartParams == null
                ? Container()
                : ZChartParamsWidget(
                  chartParams: chartParams!,
                  settingOutput: (data) {
                    setState(() {
                      chartParams = data;
                    });
                  },
                ),
            chartParams == null
                ? Container()
                : SizedBox(
                  width: 600,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: ZDynamicChart(
                        chartParams: chartParams!,
                        dataService: widget.dataService,
                        unit: widget.unit,
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
