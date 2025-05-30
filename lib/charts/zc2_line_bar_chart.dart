import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Zc2LineBarChart extends StatefulWidget {
  const Zc2LineBarChart({super.key});

  @override
  State<Zc2LineBarChart> createState() => _CombinedLineBarChartPageState();
}

class _CombinedLineBarChartPageState extends State<Zc2LineBarChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Combined Line and Bar Chart")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AspectRatio(
          aspectRatio: 1.5,
          child: Stack(
            children: [
              BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 4, color: Colors.blue)]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 2, color: Colors.blue)]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 7, color: Colors.blue)]),
                    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 6, color: Colors.blue)]),
                    BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 5, color: Colors.blue)]),
                  ],
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  barTouchData: BarTouchData(enabled: false),
                ),
              ),
              LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 1),
                        FlSpot(1, 3),
                        FlSpot(2, 5),
                        FlSpot(3, 3),
                        FlSpot(4, 4),
                      ],
                      isCurved: true,
                      color: Colors.red,
                      dotData: FlDotData(show: true),
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                  titlesData: FlTitlesData(show: false),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  lineTouchData: LineTouchData(enabled: false),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
