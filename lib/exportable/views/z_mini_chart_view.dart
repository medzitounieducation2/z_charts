import 'package:flutter/material.dart';
import 'package:z_charts/exportable/charts/z_chart.dart';
import 'package:z_charts/exportable/factories/z_params_service_factory.dart';
import 'package:z_charts/exportable/models/z_params.dart';
import 'package:z_charts/exportable/services/z_data_service.dart';
import 'package:z_charts/exportable/views/z_full_chart_view.dart';

class ZMiniChartView extends StatefulWidget {
  final dynamic pageId;
  final String unit;
  final String label;
  final ZDataService dataService;

  const ZMiniChartView({
    super.key,
    required this.pageId,
    required this.unit,
    required this.label,
    required this.dataService,
  });

  @override
  State<ZMiniChartView> createState() => ZMiniChartViewState();
}

class ZMiniChartViewState extends State<ZMiniChartView> {
  ZParams? _zParams;
  var chartKey = GlobalKey<ZChartState>();

  @override
  void initState() {
    super.initState();
    _loadZParams();
  }

  _loadZParams() {
    var service = ZParamsServiceFactory.paramsService(context);
    var builder = ZParamsServiceFactory.paramsBuilder(context);
    service.getByPageId(widget.pageId).then((savedParams) {
      if (savedParams == null) {
        var params = builder.getEmpty();
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

  refreshChart() {
    chartKey.currentState?.refreshChart();
  }

  _navigateToFullDynamicChartPage() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ZFullChartView(
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
                _zParams == null
                    ? Center(
                      child: Text('Error', style: TextStyle(color: Colors.red)),
                    )
                    : Container(
                      height: 250,
                      color: Colors.grey[200],
                      alignment: Alignment.center,
                      child: ZChart(
                        key: chartKey,
                        chartParams: _zParams!,
                        dataService: widget.dataService,
                        unit: widget.unit,
                      ),
                    ),
                Positioned(
                  top: -10,
                  right: -12,
                  child: IconButton(
                    icon: const Icon(Icons.fullscreen), //Icons.open_in_full
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
