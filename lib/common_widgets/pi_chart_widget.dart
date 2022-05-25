import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../presentation/screens/chart/sector.dart';

class PieChartWidget extends StatelessWidget {
  final List<Sector> sectors;

  PieChartWidget(this.sectors);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 0.99,
        child: PieChart(PieChartData(
          sections: _chartSections(sectors),
          centerSpaceRadius: 15.0,
        )));
  }

  List<PieChartSectionData> _chartSections(List<Sector> sectors) {
    final List<PieChartSectionData> list = [];
    for (var sector in sectors) {
      const double radius = 20.0;
      final data = PieChartSectionData(
        color: sector.color,
        value: sector.value,
        radius: radius,
        title: '',
      );
      list.add(data);
    }
    return list;
  }
}
