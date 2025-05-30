import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Zc3LinesChart extends StatefulWidget {
  const Zc3LinesChart({super.key});

  @override
  State<Zc3LinesChart> createState() => _Zc3LinesChartState();
}

class _Zc3LinesChartState extends State<Zc3LinesChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("3 Line Charts Combined")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
            ),
            borderData: FlBorderData(show: true),
            gridData: FlGridData(show: true),
            lineBarsData: [
              // Line 1
              LineChartBarData(
                spots: [
                  FlSpot(0, 1),
                  FlSpot(1, 3),
                  FlSpot(2, 2),
                  FlSpot(3, 5),
                  FlSpot(4, 4),
                ],
                isCurved: true,
                color: Colors.red,
                barWidth: 3,
                dotData: FlDotData(show: false),
              ),
              // Line 2
              LineChartBarData(
                spots: [
                  FlSpot(0, 2),
                  FlSpot(1, 2.5),
                  FlSpot(2, 1),
                  FlSpot(3, 3),
                  FlSpot(4, 2.2),
                ],
                isCurved: true,
                color: Colors.green,
                barWidth: 3,
                dotData: FlDotData(show: false),
              ),
              // Line 3
              LineChartBarData(
                spots: [
                  FlSpot(0, 3),
                  FlSpot(1, 2),
                  FlSpot(2, 4),
                  FlSpot(3, 3.5),
                  FlSpot(4, 4.5),
                ],
                isCurved: true,
                color: Colors.blue,
                barWidth: 3,
                dotData: FlDotData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
