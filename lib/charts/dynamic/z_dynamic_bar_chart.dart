import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:z_charts/models/z_chart_data_config.dart';

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

  @override
  Widget build(BuildContext context) {
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
      borderData: FlBorderData(show: false),
      /*gridData: const FlGridData(show: false),*/
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
              fontSize: 10,
            );
            return BarTooltipItem(
              '$day\n',
              textStyle,
              children: <TextSpan>[
                TextSpan(
                  text: '${rod.toY.toStringAsFixed(2)} ${widget.unit}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
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
    if (widget.data.length > 300) {
      jump = 30;
    } if (widget.data.length > 150) {
      jump = 20;
    } if (widget.data.length > 50) {
      jump = 10;
    } else if (widget.data.length > 10) {
      jump = 5;
    }
    if (value.toInt() % jump != 0) {
      return const SizedBox.shrink();
    }
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 10);
    Widget text = Text('');
    if (value.toInt() < widget.data.length) {
      // dayOfTheWeekShort
      var str = DateFormat(
        'dd/MM',
      ).format(widget.data[value.toInt()]['timestamp']);
      text = Text(str, style: style);
    }
    return SideTitleWidget(meta: meta, child: text);
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: Colors.blue,
          width: _getBarWidth(widget.data.length),
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  double _getBarWidth(int length) {
    if(length>70) {
      return 4;
    } if(length>30) {
      return 8;
    }
    return 16;
  }
}


