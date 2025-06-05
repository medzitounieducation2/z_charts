import 'dart:math';

import 'package:flutter/material.dart';
import 'package:z_charts/_examples/sample_app/menu/menu.dart';
import 'package:z_charts/_examples/sample_app/models/product.dart';
import 'package:z_charts/_examples/sample_app/services/product_service.dart';
import 'package:z_charts/exportable/views/z_mini_chart_view.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Product> items = [];
  ProductService productService = ProductService();
  var miniChartKey = GlobalKey<ZMiniChartViewState>();
  int count = 50;
  int mltp = 1;

  @override
  void initState() {
    super.initState();
    productService.buildItems(count, mltp);
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
            Row(children: [
              Text('MLTP: '),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mltp == 1 ? Colors.green : null,
                ),
                onPressed: () {
                  productService.buildItems(count, 1);
                  loadData();
                  setState(() {
                    mltp = 1;
                  });
                },
                child: Text('1'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mltp == 10 ? Colors.green : null,
                ),
                onPressed: () {
                  productService.buildItems(count, 10);
                  loadData();
                  setState(() {
                    mltp = 10;
                  });
                },
                child: Text('10'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mltp == 100 ? Colors.green : null,
                ),
                onPressed: () {
                  productService.buildItems(count, 100);
                  loadData();
                  setState(() {
                    mltp = 100;
                  });
                },
                child: Text('100'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: mltp == 1000 ? Colors.green : null,
                ),
                onPressed: () {
                  productService.buildItems(count, 1000);
                  loadData();
                  setState(() {
                    mltp = 1000;
                  });
                },
                child: Text('1000'),
              ),
            ],),
            Row(
              children: [
                Text('LEN: '),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: count == 10 ? Colors.green : null,
                  ),
                  onPressed: () {
                    productService.buildItems(10, mltp);
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
                    productService.buildItems(50, mltp);
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
                    productService.buildItems(100, mltp);
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
                    productService.buildItems(500, mltp);
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
                    productService.buildItems(1000, mltp);
                    loadData();
                    setState(() {
                      count = 1000;
                    });
                  },
                  child: Text('1000'),
                ),
              ],
            ),

            ZMiniChartView(
              key: miniChartKey,
              pageId: 'product',
              unit: 'step',
              label: 'Product chart',
              dataService: productService,
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
                          title: Text(item.value.toStringAsFixed(2)),
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
          var product = Product(
            unit: 'step',
            value: value,
            timestamp: date,
            key: null,
          );
          productService.addEntity(product).then((res) {
            loadData();
          });
        },
        tooltip: 'Add New Product',
        child: const Icon(Icons.add),
      ),
    );
  }
}
