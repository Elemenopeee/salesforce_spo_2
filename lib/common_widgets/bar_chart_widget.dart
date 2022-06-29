import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:salesforce_spo/design_system/primitives/color_system.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({
    Key? key,
    this.barColor,
    required this.values,
  }) : super(key: key);
  final Color? barColor;
  final List<double> values;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.99,
      child: BarChart(
        BarChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            show: false,
          ),
          borderData: FlBorderData(
            show: false,
            border: const Border(
              top: BorderSide.none,
              right: BorderSide.none,
              left: BorderSide.none,
              bottom: BorderSide(
                width: 1,
                color: ColorSystem.black,
              ),
            ),
          ),
          groupsSpace: 05,
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: List.generate(
                  values.length,
                  (index) => BarChartRodData(
                        fromY: 0,
                        width: 3,
                        color: barColor,
                        toY: values[index] == 0 ? 1 : values[index],
                      )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
