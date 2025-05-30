import 'package:flutter/material.dart';
import 'package:z_charts/charts/zc2_line_bar_chart.dart';
import 'package:z_charts/charts/zc3_lines_chart.dart';
import 'package:z_charts/menu/menu.dart';

class Zc3LinesPage extends StatefulWidget {
  const Zc3LinesPage({super.key});

  @override
  State<Zc3LinesPage> createState() => _Zc3LinesPageState();
}

class _Zc3LinesPageState extends State<Zc3LinesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("3 Lines"),
      ),
      drawer: AppMenu(),
      body: Center(
          child: Zc3LinesChart()
      ),
    );
  }
}