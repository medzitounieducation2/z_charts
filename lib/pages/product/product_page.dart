import 'dart:math';

import 'package:flutter/material.dart';
import 'package:z_charts/charts/views/z_mini_dynamic_chart_view.dart';
import 'package:z_charts/menu/menu.dart';
import 'package:z_charts/pages/product/product.dart';
import 'package:z_charts/pages/product/product_charts_service.dart';
import 'package:z_charts/pages/product/product_service.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Product> items = [];
  ProductService productService = ProductService();
  ProductChartsService productChartsService = ProductChartsService();
  var miniChartKey = GlobalKey<ZMiniDynamicChartViewState>();
  int count = 50;

  @override
  void initState() {
    super.initState();
    productService.buildItems(count);
    loadData();
  }

  loadData() {
    productService.getEntities().then((loaded) {
      setState(() {
        items = loaded;
      });
      miniChartKey.currentState?.refreshChart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Product"),
      ),
      drawer: AppMenu(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: count == 10 ? Colors.green : null,
                  ),
                  onPressed: () {
                    productService.buildItems(10);
                    loadData();
                    setState(() {
                      count = 10;
                    });
                  },
                  child: Text('10'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: count == 50 ? Colors.green : null,
                  ),
                  onPressed: () {
                    productService.buildItems(50);
                    loadData();
                    setState(() {
                      count = 50;
                    });
                  },
                  child: Text('50'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: count == 100 ? Colors.green : null,
                  ),
                  onPressed: () {
                    productService.buildItems(100);
                    loadData();
                    setState(() {
                      count = 100;
                    });
                  },
                  child: Text('100'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: count == 500 ? Colors.green : null,
                  ),
                  onPressed: () {
                    productService.buildItems(500);
                    loadData();
                    setState(() {
                      count = 500;
                    });
                  },
                  child: Text('500'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: count == 1000 ? Colors.green : null,
                  ),
                  onPressed: () {
                    productService.buildItems(1000);
                    loadData();
                    setState(() {
                      count = 1000;
                    });
                  },
                  child: Text('1000'),
                ),
              ],
            ),

            ZMiniDynamicChartView(
              key: miniChartKey,
              pageId: 'walking',
              unit: 'step',
              label: 'Product chart',
              dataService: productService,
              chartsService: productChartsService,
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
                  'All products ${items.length}',
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
          final date = DateTime.now().subtract(
            Duration(days: randomDay, hours: randomHour),
          );
          var walking = Product(
            unit: 'step',
            value: value,
            timestamp: date,
            id: null,
          );
          productService.addEntity(walking).then((res) {
            loadData();
          });
        },
        tooltip: 'Add New Product',
        child: const Icon(Icons.add),
      ),
    );
  }
}
