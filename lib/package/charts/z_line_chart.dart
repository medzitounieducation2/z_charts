import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:z_charts/package/models/z_data_config.dart';

class ZLineChart extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final ZDataConfig chartConfig;
  final String unit;

  const ZLineChart({
    super.key,
    required this.data,
    required this.chartConfig,
    required this.unit,
  });

  @override
  State<ZLineChart> createState() => _ZLineChartState();
}

class _ZLineChartState extends State<ZLineChart> {
  final List<Color> gradientColors = [Colors.cyanAccent, Colors.blueAccent];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18, left: 12, top: 24, bottom: 12),
      child: LineChart(mainData()),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 10);
    Widget text = Text('');
    if (value.toInt() < widget.data.length) {
      var str = DateFormat(
        'dd/MM',
      ).format(widget.data[value.toInt()]['timestamp']);
      text = Text(str, style: style);
    }
    return SideTitleWidget(meta: meta, child: text);
  }

  LineChartData mainData() {
    double averageValue = widget.data.map((e) => e['value']).reduce((a, b) => a + b) / widget.data.length;
    return LineChartData(
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
            y: averageValue, // the y value of your average
            color: Colors.red,
            strokeWidth: 2,
            dashArray: [5, 5], // optional: make it dashed
            label: HorizontalLineLabel(
              show: true,
              alignment: Alignment.topCenter,
              labelResolver: (line) => 'Avg: ${line.y.toStringAsFixed(1)}',
              style: const TextStyle(color: Colors.red, fontSize: 14),
            ),
          ),
        ],
      ),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipPadding: EdgeInsets.all(3.0),
          getTooltipColor: (_) => Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItems: (touchedSpots) {
            return List.generate(touchedSpots.length, (i) {
              LineBarSpot touchedSpot = touchedSpots[i];
              String weekDay = 'Unknown';
              if (widget.data.isNotEmpty) {
                // dayOfTheWeekFull
                weekDay = DateFormat(
                  'EEE dd/MM',
                ).format(widget.data[i]['timestamp']);
              }
              final textStyle = TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              );
              return LineTooltipItem(
                '$weekDay\n',
                textStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: '${touchedSpot.y.toStringAsFixed(2)} ${widget.unit}',
                    style: const TextStyle(
                      color: Colors.white, //widget.touchedBarColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            });
          },
        ),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return const FlLine(color: Colors.grey, strokeWidth: 1);
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(color: Colors.grey, strokeWidth: 1);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            /*reservedSize: 30,*/
            /*interval: widget.data.length / 7,*/
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              String formatted = value >= 1000
                  ? '${(value / 1000).toStringAsFixed(1)}K'
                  : value.toStringAsFixed(0);
              return Text(formatted, style: TextStyle(fontSize: 10));
            },
            reservedSize: 35,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: widget.chartConfig.minX,
      maxX: widget.chartConfig.maxX,
      minY: widget.chartConfig.minValue * 0.95,
      maxY: widget.chartConfig.maxValue * 1.05,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(widget.data.length, (i) {
            return FlSpot(i.toDouble(), widget.data[i]['value']);
          }),
          isCurved: true,
          gradient: LinearGradient(colors: gradientColors),
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors:
                  gradientColors
                      .map((color) => color.withValues(alpha: 0.3))
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
