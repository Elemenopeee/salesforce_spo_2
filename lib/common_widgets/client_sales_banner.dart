import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/utils/constant_functions.dart';

import '../models/customer.dart';
import '../utils/constants.dart';

class ClientSales extends StatelessWidget {

  final Customer? customer;

  const ClientSales({Key? key, this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.all(PaddingSystem.padding16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeSystem.size16),
        color: const Color(0xFF8C80F8),
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SALES',
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
                child: customer == null ? Center(
                  child: SvgPicture.asset(
                    IconSystem.accessoriesNotFound,
                    height: 120,
                  ),
                ) : PieChart(
                  PieChartData(
                    sections: showingSections(
                      customer!.lifeTimeNetSalesAmount ?? 0,
                      customer!.twelveMonthSales ?? 0,
                    ),
                    centerSpaceColor: const Color(0xFF8C80F8),
                    centerSpaceRadius: 24,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            width: SizeSystem.size12,
          ),
          Expanded(
            child: customer == null ? const Text(
              'No data generated yet',
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeSystem.size12,
                fontFamily: kRubik,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ) : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${formattedNumber(customer!.lifeTimeNetSalesAmount ?? 0)}',
                      maxLines: 2,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeSystem.size24,
                        fontFamily: kRubik,
                      ),
                    ),
                    Text(
                      'LTV',
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: SizeSystem.size12,
                        fontFamily: kRubik,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '\$${formattedNumber(customer!.twelveMonthSales ?? 0)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeSystem.size14,
                              fontFamily: kRubik,
                            ),
                          ),
                          Text(
                            '0-12 Months',
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: SizeSystem.size12,
                              fontFamily: kRubik,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '--',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeSystem.size14,
                              fontFamily: kRubik,
                            ),
                          ),
                          Text(
                            '12-24 Months',
                            maxLines: 2,
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


List<PieChartSectionData> showingSections(double today, double total,
    {List<Color>? colors}) {
  return List.generate(2, (i) {
    const fontSize = 0.0;
    const radius = 28.0;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: colors?[0] ?? const Color(0xFF7FE3F0),
          value: today,
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: fontSize,
          ),
        );
      case 1:
        return PieChartSectionData(
          color: colors?[1] ?? const Color(0xFFFF7C6D),
          value: total,
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