import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DailyEmotionsCharts extends StatefulWidget {
  const DailyEmotionsCharts({super.key});

  @override
  State<DailyEmotionsCharts> createState() => _DailyEmotionsChartsState();
}

class _DailyEmotionsChartsState extends State<DailyEmotionsCharts> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 2,
        minY: 0,
        maxY: 3,
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            spots: [
              FlSpot(0, 1), // Primeiro valor
              FlSpot(1, 2), // Segundo valor
              FlSpot(2, 3), // Terceiro valor
            ],
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: true),
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return const Text('0');
                  case 1:
                    return const Text('1');
                  case 2:
                    return const Text('2');
                  default:
                    return const Text('');
                }
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 1:
                    return const Text('1');
                  case 2:
                    return const Text('2');
                  case 3:
                    return const Text('3');
                  default:
                    return const Text('');
                }
              },
            ),
          ),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.black, width: 1),
        ),
      ),
    );
  }
}
