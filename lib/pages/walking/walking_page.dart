import 'dart:math';

import 'package:flutter/material.dart';
import 'package:z_charts/charts/views/z_mini_dynamic_chart_view.dart';
import 'package:z_charts/menu/menu.dart';
import 'package:z_charts/pages/walking/walking.dart';
import 'package:z_charts/pages/walking/walking_charts_service.dart';
import 'package:z_charts/pages/walking/walking_service.dart';

class WalkingPage extends StatefulWidget {
  const WalkingPage({super.key});

  @override
  State<WalkingPage> createState() => _WalkingPageState();
}

class _WalkingPageState extends State<WalkingPage> {
  List<Walking> items = [];
  WalkingService walkingService = WalkingService();
  WalkingChartsService walkingChartsService = WalkingChartsService();
  var miniChartKey = GlobalKey<ZMiniDynamicChartViewState>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    walkingService.getEntities().then((loaded) {
      setState(() {
        items = loaded;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Walking"),
      ),
      drawer: AppMenu(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ZMiniDynamicChartView(
              key: miniChartKey,
              pageId: 'walking',
              unit: 'step',
              label: 'Walking chart',
              dataService: walkingService,
              chartsService: walkingChartsService,
            ),
            Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey, // border color
                  width: 1.0, // border width
                ),
                borderRadius: BorderRadius.circular(12.0), // optional
              ),
              elevation: 2,
              child: ExpansionTile(
                title: Text(
                  'All walking ${items.length}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                initiallyExpanded: true,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return Card(
                        child: ListTile(
                          title: Text('${item.value}'),
                          subtitle: Text('${item.timestamp}'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final random = Random();
          final value = random.nextDouble() * 50 + 10;
          final randomDay = random.nextInt(50);
          final randomHour = random.nextInt(24);
          final date = DateTime.now().subtract(Duration(days: randomDay, hours: randomHour));
          var walking = Walking(unit: 'step', value: value, timestamp: date, id: null);
          walkingService.addEntity(walking).then((res) {
            loadData();
            miniChartKey.currentState?.refreshChart();
          });
        },
        tooltip: 'Add New Walking',
        child: const Icon(Icons.add),
      ),
    );
  }
}
