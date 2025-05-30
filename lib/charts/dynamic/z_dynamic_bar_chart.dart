import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:z_charts/models/z_chart_data_config.dart';
import 'package:z_charts/utils/z_better_ints.dart';

class ZDynamicBarChart extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final ZChartDataConfig chartConfig;
  final String unit;

  const ZDynamicBarChart({
    super.key,
    required this.data,
    required this.chartConfig,
    required this.unit,
  });

  @override
  State<ZDynamicBarChart> createState() => _ZDynamicBarChartState();
}

class _ZDynamicBarChartState extends State<ZDynamicBarChart> {
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
      child: BarChart(mainData()),
    );
  }

  mainData() {
    double averageValue = widget.data.map((e) => e['value']).reduce((a, b) => a + b) / widget.data.length;
    return BarChartData(
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
      alignment: BarChartAlignment.spaceAround,
      maxY: widget.chartConfig.maxValue,
      barGroups: List.generate(widget.data.length, (i) {
        return makeGroupData(i, widget.data[i]['value']);
      }),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
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
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(show: false),
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipPadding: EdgeInsets.all(3.0),
          getTooltipColor: (_) => Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (
              BarChartGroupData group,
              int groupIndex,
              BarChartRodData rod,
              int rodIndex,
              ) {
            var day = DateFormat(
              'EEE dd/MM',
            ).format(widget.data[group.x]['timestamp']);
            final textStyle = TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            );
            return BarTooltipItem(
              '$day\n',
              textStyle,
              children: <TextSpan>[
                TextSpan(
                  text: '${rod.toY} ${widget.unit}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var jump = 1;
    if (widget.data.length > 10) {
      jump = 3;
    }
    if (value.toInt() % jump != 0) {
      return const SizedBox.shrink();
    }
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 10);
    Widget text = Text('');
    if (value.toInt() < widget.data.length) {
      // dayOfTheWeekShort
      var str = DateFormat(
        'EE dd/MM',
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

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Colors.blue,
          width: 16,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
