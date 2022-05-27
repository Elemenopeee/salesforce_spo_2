import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.99,
      child: BarChart(
        BarChartData(
            borderData: FlBorderData(
                border: const Border(
              top: BorderSide.none,
              right: BorderSide.none,
              left: BorderSide(width: 1),
              bottom: BorderSide(width: 1),
            )),
            groupsSpace: 05,
            barGroups: [
              BarChartGroupData(x: 10, barRods: [
                BarChartRodData(
                    fromY: 0, width: 10, color: Colors.red, toY: 10),
              ]),
              BarChartGroupData(x: 2, barRods: [
                BarChartRodData(fromY: 9, width: 05, color: Colors.red, toY: 3),
              ]),
              BarChartGroupData(x: 3, barRods: [
                BarChartRodData(fromY: 4, width: 05, color: Colors.red, toY: 3),
              ]),
              BarChartGroupData(x: 4, barRods: [
                BarChartRodData(fromY: 2, width: 05, color: Colors.red, toY: 3),
              ]),
              BarChartGroupData(x: 5, barRods: [
                BarChartRodData(
                    fromY: 13, width: 05, color: Colors.red, toY: 3),
              ]),
            ]),
      ),
    );
  }
}
