import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:z_charts/models/z_chart_data_config.dart';
import 'package:z_charts/utils/z_better_ints.dart';

class ZDynamicLineChart extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final ZChartDataConfig chartConfig;
  final String unit;

  const ZDynamicLineChart({
    super.key,
    required this.data,
    required this.chartConfig,
    required this.unit,
  });

  @override
  State<ZDynamicLineChart> createState() => _ZDynamicLineChartState();
}

class _ZDynamicLineChartState extends State<ZDynamicLineChart> {
  final List<Color> gradientColors = [Colors.cyanAccent, Colors.blueAccent];

  Map<int, String>? verticalAxesMap;

  @override
  Widget build(BuildContext context) {
    verticalAxesMap = betterInts(
      widget.chartConfig.minValue,
      widget.chartConfig.maxValue,
      widget.unit,
    );
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

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 10);

    String? text = verticalAxesMap![value.toInt()];

    if (text == null || value.toInt() >= (widget.chartConfig.maxValue * 1.03)) {
      return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
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
                fontSize: 12,
              );
              return LineTooltipItem(
                '$weekDay\n',
                textStyle,
                children: <TextSpan>[
                  TextSpan(
                    text: '${touchedSpot.y.toStringAsFixed(2)} ${widget.unit}',
                    style: const TextStyle(
                      color: Colors.white, //widget.touchedBarColor,
                      fontSize: 12,
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
        horizontalInterval: widget.chartConfig.horizontalInterval ?? 1,
        verticalInterval: 1,
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
            reservedSize: 30,
            interval: widget.data.length / 7,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
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
          barWidth: 5,
          // dataList.length + 1
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
