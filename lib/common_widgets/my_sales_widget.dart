import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/common_widgets/bar_chart_widget.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/utils/constants.dart';

import '../utils/constant_functions.dart';

class MySalesWidget extends StatefulWidget {
  const MySalesWidget({
    Key? key,
    required this.todaySale,
    required this.todayCommission,
    required this.perDayCommissions,
    required this.perDaySales,
  }) : super(key: key);

  final double todaySale;
  final double todayCommission;
  final List<double> perDaySales;
  final List<double> perDayCommissions;

  @override
  State<MySalesWidget> createState() => _MySalesState();
}

class _MySalesState extends State<MySalesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SizeSystem.size16,
        vertical: SizeSystem.size10,
      ),
      decoration: BoxDecoration(
        color: ColorSystem.purple.withOpacity(0.1),
        borderRadius: BorderRadius.circular(SizeSystem.size16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MY SALES',
            style: TextStyle(
              letterSpacing: 1.5,
              color: ColorSystem.black,
              fontWeight: FontWeight.w500,
              fontSize: SizeSystem.size14,
              fontFamily: kRubik,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: kRubik,
                  ),
                  children: [
                    const TextSpan(
                      text: '\$ ',
                      style: TextStyle(
                        fontSize: SizeSystem.size30,
                        fontWeight: FontWeight.w400,
                        color: ColorSystem.primary,
                        fontFamily: kRubik,
                      ),
                    ),
                    TextSpan(
                      text: formattedNumber(widget.todaySale).toLowerCase(),
                      style: const TextStyle(
                        fontSize: SizeSystem.size30,
                        fontWeight: FontWeight.w600,
                        color: ColorSystem.primary,
                        fontFamily: kRubik,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'Today',
                style: TextStyle(
                  fontSize: SizeSystem.size14,
                  color: ColorSystem.primary,
                  fontFamily: kRubik,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: SizedBox(
                height: 30,
                child: widget.todaySale == 0 && widget.todayCommission == 0
                    ? SvgPicture.asset(IconSystem.noSales)
                    : BarChartWidget(
                        values: widget.perDaySales,
                        barColor: ColorSystem.lavender3,
                      )),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'MY COMMISSION',
            style: TextStyle(
              letterSpacing: 1.5,
              color: ColorSystem.black,
              fontWeight: FontWeight.w500,
              fontSize: SizeSystem.size14,
              fontFamily: kRubik,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: kRubik,
                  ),
                  children: [
                    const TextSpan(
                      text: '\$ ',
                      style: TextStyle(
                        fontSize: SizeSystem.size30,
                        fontWeight: FontWeight.w400,
                        color: ColorSystem.primary,
                        fontFamily: kRubik,
                      ),
                    ),
                    TextSpan(
                      text:
                          formattedNumber(widget.todayCommission).toLowerCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeSystem.size30,
                        color: ColorSystem.primary,
                        fontFamily: kRubik,
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'Today',
                style: TextStyle(
                  fontSize: SizeSystem.size14,
                  color: ColorSystem.primary,
                  fontFamily: kRubik,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: SizedBox(
              height: 30,
              width: 150,
              child: widget.todaySale == 0 && widget.todayCommission == 0
                  ? SvgPicture.asset(IconSystem.noSales)
                  : BarChartWidget(
                      values: widget.perDayCommissions,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
