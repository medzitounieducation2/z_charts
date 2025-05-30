import 'package:flutter/material.dart';
import 'package:z_charts/charts/zc2_line_bar_chart.dart';
import 'package:z_charts/menu/menu.dart';

class Zc2LineBarPage extends StatefulWidget {
  const Zc2LineBarPage({super.key});

  @override
  State<Zc2LineBarPage> createState() => _Zc2LineBarPageState();
}

class _Zc2LineBarPageState extends State<Zc2LineBarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Line & Bar"),
      ),
      drawer: AppMenu(),
      body: Center(
          child: Zc2LineBarChart()
      ),
    );
  }
}