import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/common_widgets/bar_chart_widget.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/utils/constants.dart';

class MySalesWidget extends StatefulWidget {
  MySalesWidget(
      {Key? key,
      required this.totalSales,
      required this.totalCommission,
      this.futureSales,
      this.futureTodaysSale})
      : super(key: key);
  double totalSales;
  double totalCommission;
  Future<void>? futureSales;
  Future<void>? futureTodaysSale;
  @override
  State<MySalesWidget> createState() => _MySalesState();
}

class _MySalesState extends State<MySalesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeSystem.size16,
        vertical: SizeSystem.size10,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFAF8EFF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(SizeSystem.size16),
      ),
      child: FutureBuilder(
        future: Future.wait([
          // widget.futureSales,
          // widget.futureTodaysSale,
        ]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "MY SALES",
                style: TextStyle(
                  color: ColorSystem.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
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
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: kRubik,
                      ),
                      children: [
                        TextSpan(
                          text: '\$ ',
                          style: TextStyle(
                            fontSize: SizeSystem.size30,
                            fontWeight: FontWeight.w400,
                            color: ColorSystem.primary,
                            fontFamily: kRubik,
                          ),
                        ),
                        TextSpan(
                          text: '1.5',
                          style: TextStyle(
                            fontSize: SizeSystem.size30,
                            fontWeight: FontWeight.w600,
                            color: ColorSystem.primary,
                            fontFamily: kRubik,
                          ),
                        ),
                        TextSpan(
                          text: 'k',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: SizeSystem.size14,
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
                    child:
                        widget.totalSales == 0 && widget.totalCommission == 0
                            ? SvgPicture.asset(IconSystem.noSales)
                            : BarChartWidget(
                                barColor: Color(0xFF8C80F8),
                              )),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "MY COMMISSION",
                  style: TextStyle(
                    color: ColorSystem.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontFamily: kRubik,
                  ),
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
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: kRubik,
                      ),
                      children: [
                        TextSpan(
                          text: '\$ ',
                          style: TextStyle(
                            fontSize: SizeSystem.size30,
                            fontWeight: FontWeight.w400,
                            color: ColorSystem.primary,
                            fontFamily: kRubik,
                          ),
                        ),
                        TextSpan(
                          text: '102',
                          style: TextStyle(
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
                    child:
                        widget.totalSales == 0 && widget.totalCommission == 0
                            ? SvgPicture.asset(IconSystem.noSales)
                            : BarChartWidget()),
              ),
            ],
          );
        },
      ),
    );
  }
}
