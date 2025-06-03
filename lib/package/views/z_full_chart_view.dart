import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:z_charts/package/charts/z_chart.dart';
import 'package:z_charts/package/factories/z_params_service_factory.dart';
import 'package:z_charts/package/models/z_params.dart';
import 'package:z_charts/package/services/z_data_service.dart';
import 'package:z_charts/package/widgets/z_params_widget.dart';

class ZFullChartView extends StatefulWidget {
  final String pageId;
  final String unit;
  final String label;
  final ZDataService dataService;

  const ZFullChartView({
    super.key,
    required this.pageId,
    required this.unit,
    required this.label,
    required this.dataService,
  });

  @override
  State<ZFullChartView> createState() => _ZFullChartViewState();
}

class _ZFullChartViewState extends State<ZFullChartView> {
  ZParams? _zParams;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _loadZParams();
  }

  _loadZParams() {
    var service = ZParamsServiceFactory.paramsService(context);
    service.getByPageId(widget.pageId).then((savedParams) {
      if (savedParams == null) {
        var params = ZParams.empty();
        params.pageId = widget.pageId;
        service.addEntity(params).then((newSaved) {
          setState(() {
            _zParams = newSaved;
          });
        });
      } else {
        setState(() {
          _zParams = savedParams;
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
            _zParams == null
                ? Container()
                : ZParamsWidget(
                  chartParams: _zParams!,
                  settingOutput: (data) {
                    setState(() {
                      _zParams = data;
                    });
                  },
                ),
            _zParams == null
                ? Container()
                : SizedBox(
                  width: 600,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: ZChart(
                        chartParams: _zParams!,
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
