import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:salesforce_spo/design_system/primitives/color_system.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({
    Key? key,
    this.barColor,
  }) : super(key: key);
  final Color? barColor;

  // final List<Sector> sectors;
  //
  // BarChartWidget(this.sectors);

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
              barRods: [
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 30,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 17,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 12,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 19,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 7,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 30,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 17,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 12,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 19,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 7,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 30,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 17,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 12,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 19,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 7,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 30,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 17,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 12,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 19,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 7,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 17,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 12,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 19,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 7,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 17,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 12,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 19,
                ),
                BarChartRodData(
                  fromY: 0,
                  width: 3,
                  color: barColor,
                  toY: 7,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
