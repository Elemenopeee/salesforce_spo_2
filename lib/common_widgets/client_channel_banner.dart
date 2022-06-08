import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/models/client_metric.dart';
import 'package:salesforce_spo/utils/constant_functions.dart';
import 'package:salesforce_spo/utils/constants.dart';

import '../design_system/design_system.dart';

class ClientChannelBanner extends StatelessWidget {
  final List<ClientMetric> details;

  const ClientChannelBanner({Key? key, required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      padding: const EdgeInsets.all(PaddingSystem.padding16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeSystem.size16),
        color: const Color(0xFFFF9B90),
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CHANNEL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: SizeSystem.size12,
                  fontFamily: kRubik,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(
                height: 120,
                width: 100,
                child: details.isNotEmpty ? PieChart(
                  PieChartData(
                    sections: showingChannels(
                        details[0].value, details[1].value,
                        colors: [
                          Colors.red,
                          Colors.white,
                        ]),
                    centerSpaceColor: const Color(0xFFFF9B90),
                    centerSpaceRadius: 24,
                  ),
                ) : Center(
                  child: SvgPicture.asset(
                    IconSystem.channelNotFound,
                    height: 120,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            width: SizeSystem.size20,
          ),
          Expanded(
            child: details.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            formattedNumber(details[0].value),
                            maxLines: 2,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeSystem.size24,
                              fontFamily: kRubik,
                            ),
                          ),
                          Text(
                            details[0].key,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: SizeSystem.size12,
                              fontFamily: kRubik,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formattedNumber(details[1].value),
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeSystem.size14,
                              fontFamily: kRubik,
                            ),
                          ),
                          Text(
                            details[1].key,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: SizeSystem.size12,
                              fontFamily: kRubik,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const Text(
                    'No data generated yet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeSystem.size12,
                      fontFamily: kRubik,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> showingChannels(double channel1, double channel2,
    {List<Color>? colors}) {
  return List.generate(2, (i) {
    const fontSize = 0.0;
    const radius = 28.0;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: colors?[0] ?? const Color(0xFF7FE3F0),
          value: channel1,
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: fontSize,
          ),
        );
      case 1:
        return PieChartSectionData(
          color: colors?[1] ?? const Color(0xFFFF7C6D),
          value: channel2,
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
