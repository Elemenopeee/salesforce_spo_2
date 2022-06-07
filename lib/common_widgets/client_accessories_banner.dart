import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:salesforce_spo/models/client_metric.dart';
import 'package:salesforce_spo/utils/constant_functions.dart';
import 'package:salesforce_spo/utils/constants.dart';

import '../design_system/design_system.dart';
import 'client_carousel.dart';

class ClientAccessoriesBanner extends StatelessWidget {
  final List<ClientMetric> accessories;

  const ClientAccessoriesBanner({Key? key, required this.accessories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(PaddingSystem.padding16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeSystem.size16),
        color: const Color(0xFF4C5980),
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ACCESSORIES',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeSystem.size12,
                  fontFamily: kRubik,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              accessories.isNotEmpty
                  ? SizedBox(
                      height: 120,
                      width: 100,
                      child: PieChart(
                        PieChartData(
                          sections: showingAccessories(accessories),
                          centerSpaceColor: const Color(0xFF4C5980),
                          centerSpaceRadius: 24,
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
          const SizedBox(
            width: SizeSystem.size12,
          ),
          Expanded(
            child: accessories.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formattedNumber(accessories[0].value),
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeSystem.size24,
                                    fontFamily: kRubik,
                                  ),
                                ),
                                Text(
                                  accessories[0].key,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: SizeSystem.size12,
                                    fontFamily: kRubik,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: SizeSystem.size10,
                          ),
                          if(accessories.length > 1)
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formattedNumber(accessories[1].value),
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeSystem.size14,
                                    fontFamily: kRubik,
                                  ),
                                ),
                                Text(
                                  accessories[1].key,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: SizeSystem.size12,
                                    fontFamily: kRubik,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if(accessories.length > 2)
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formattedNumber(accessories[2].value),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeSystem.size14,
                                    fontFamily: kRubik,
                                  ),
                                ),
                                Text(
                                  accessories[2].key,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: SizeSystem.size12,
                                    fontFamily: kRubik,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: SizeSystem.size10,
                          ),
                          if(accessories.length > 3)
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formattedNumber(accessories[3].value),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeSystem.size14,
                                    fontFamily: kRubik,
                                  ),
                                ),
                                Text(
                                  accessories[3].key,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: SizeSystem.size12,
                                    fontFamily: kRubik,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> showingAccessories(List<ClientMetric> metrics,
    {List<Color>? colors}) {
  if (metrics.length > 4) {
    while (metrics.length > 4) {
      metrics.removeLast();
    }
  }

  return List.generate(metrics.length, (i) {
    const fontSize = 0.0;
    const radius = 28.0;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: colors?[0] ?? const Color(0xFF7FE3F0),
          value: metrics[0].value,
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: fontSize,
          ),
        );
      case 1:
        return PieChartSectionData(
          color: colors?[1] ?? const Color(0xFFFF7C6D),
          value: metrics[1].value,
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: fontSize,
          ),
        );
      case 2:
        return PieChartSectionData(
          color: colors?[1] ?? const Color(0xFF1F87FE),
          value: metrics[2].value,
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: fontSize,
          ),
        );
      case 3:
        return PieChartSectionData(
          color: colors?[1] ?? const Color(0xFF7260E6),
          value: metrics[3].value,
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: fontSize,
          ),
        );
      default:
        throw Error();
    }
  });
}
