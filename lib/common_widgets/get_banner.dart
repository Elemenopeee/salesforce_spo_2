import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/common_widgets/pi_chart_widget.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/icon_system.dart';
import '../design_system/primitives/landing_images.dart';
import '../design_system/primitives/padding_system.dart';
import '../design_system/primitives/size_system.dart';
import '../presentation/screens/chart/sector.dart';
import '../utils/constants.dart';
import 'bar_chart_widget.dart';

class GetBanner extends StatefulWidget {
  final Color? bannerOneColor;
  final Color? bannerTwoOColor;
  final Color? bannerThreeColor;

  const GetBanner({
    Key? key,
    this.bannerOneColor,
    this.bannerTwoOColor,
    this.bannerThreeColor,
  }) : super(key: key);

  @override
  _GetBannerState createState() => _GetBannerState();
}

class _GetBannerState extends State<GetBanner> {
  late PageController _pageController;

  int activePage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      keepPage: false,
      viewportFraction: 0.9,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 12 / 5,
        child: PageView(
          pageSnapping: true,
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              activePage = page;
            });
          },
          children: [
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(
                  vertical: 4.0, horizontal: PaddingSystem.padding10),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorSystem.greyBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: PaddingSystem.padding20,
                      vertical: PaddingSystem.padding20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: const TextSpan(
                              style: TextStyle(
                                fontFamily: kRubik,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Jessica Mendez ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: SizeSystem.size16,
                                    color: ColorSystem.primaryTextColor,
                                  ),
                                ),
                                TextSpan(
                                  text: '• GC',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: SizeSystem.size16,
                                    color: ColorSystem.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            IconSystem.badge,
                            height: 15,
                            width: 15,
                            color: ColorSystem.complimentary,
                          ),
                          const SizedBox(
                            width: 04,
                          ),
                          const Text(
                            "High",
                            style: TextStyle(
                              fontFamily: kRubik,
                              fontWeight: FontWeight.w600,
                              color: ColorSystem.complimentary,
                              fontSize: SizeSystem.size12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: SizeSystem.size8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              SvgPicture.asset(
                                LandingImages.guitarSolidIcon,
                                width: SizeSystem.size25,
                                height: SizeSystem.size25,
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                          const SizedBox(
                            width: SizeSystem.size10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: SizeSystem.size10,
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontFamily: kRubik,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Guitarist |',
                                      style: TextStyle(
                                        fontSize: SizeSystem.size12,
                                        color: ColorSystem.primary,
                                        fontFamily: kRubik,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' Buy Used',
                                      style: TextStyle(
                                        fontSize: SizeSystem.size12,
                                        color: ColorSystem.primary,
                                        fontFamily: kRubik,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: SizeSystem.size5,
                              ),
                              const Text(
                                "Visited on : 12-Mar-2022",
                                style: TextStyle(
                                  fontFamily: kRubik,
                                  color: ColorSystem.primary,
                                  fontSize: SizeSystem.size12,
                                ),
                              ),
                              const SizedBox(
                                height: SizeSystem.size20,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: SizeSystem.size8,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "L. PURCHASE",
                                style: TextStyle(
                                  fontFamily: kRubik,
                                  color: ColorSystem.secondary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeSystem.size10,
                                ),
                              ),
                              const SizedBox(
                                height: SizeSystem.size5,
                              ),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontFamily: kRubik,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '1.5 ',
                                      style: TextStyle(
                                        color: ColorSystem.primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: SizeSystem.size24,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'k',
                                      style: TextStyle(
                                        color: ColorSystem.primary,
                                        // fontWeight: FontWeight.w700,
                                        fontSize: SizeSystem.size12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                            child: VerticalDivider(
                              color: Color.fromRGBO(0, 0, 0, 0.04),
                              thickness: 1,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "LTV",
                                style: TextStyle(
                                  fontFamily: kRubik,
                                  color: ColorSystem.secondary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeSystem.size10,
                                ),
                              ),
                              const SizedBox(
                                height: SizeSystem.size5,
                              ),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontFamily: kRubik,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '105.5 ',
                                      style: TextStyle(
                                        color: ColorSystem.primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: SizeSystem.size24,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'k',
                                      style: TextStyle(
                                        color: ColorSystem.primary,
                                        // fontWeight: FontWeight.w700,
                                        fontSize: SizeSystem.size12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                            child: VerticalDivider(
                              color: Color.fromRGBO(0, 0, 0, 0.04),
                              thickness: 1,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "AVG. ORDER",
                                style: TextStyle(
                                  fontFamily: kRubik,
                                  color: ColorSystem.secondary,
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeSystem.size10,
                                ),
                              ),
                              const SizedBox(
                                height: SizeSystem.size5,
                              ),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontFamily: kRubik,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '26.2 ',
                                      style: TextStyle(
                                        color: ColorSystem.primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: SizeSystem.size24,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'k',
                                      style: TextStyle(
                                        color: ColorSystem.primary,
                                        // fontWeight: FontWeight.w700,
                                        fontSize: SizeSystem.size12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: PaddingSystem.padding20,
                horizontal: PaddingSystem.padding20,
              ),
              decoration: BoxDecoration(
                color: ColorSystem.purple,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ACCESSORIES",
                    style: TextStyle(
                      fontFamily: kRubik,
                      fontWeight: FontWeight.w600,
                      color: ColorSystem.white,
                      fontSize: SizeSystem.size12,
                    ),
                  ),
                  const Spacer(),
                  PieChartWidget(industrySectors),
                  const Spacer(),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: kRubik,
                      ),
                      children: [
                        TextSpan(
                          text: '37% ',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: SizeSystem.size14,
                            color: ColorSystem.white,
                          ),
                        ),
                        TextSpan(
                          text: '/ 42',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: SizeSystem.size10,
                            color: ColorSystem.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "\$57k Spent",
                    style: TextStyle(
                      fontFamily: kRubik,
                      color: ColorSystem.white.withOpacity(0.4),
                      fontSize: SizeSystem.size12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 50),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: PaddingSystem.padding20,
                  horizontal: PaddingSystem.padding20,
                ),
                decoration: BoxDecoration(
                  color: ColorSystem.pink,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "ORDER\nFREQUENCY",
                      style: TextStyle(
                        fontFamily: kRubik,
                        fontWeight: FontWeight.w600,
                        color: ColorSystem.white,
                        fontSize: SizeSystem.size12,
                      ),
                    ),
                    const Spacer(),
                    BarChartWidget(),
                    const Spacer(),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontFamily: kRubik,
                        ),
                        children: [
                          TextSpan(
                            text: '\$300% ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: SizeSystem.size14,
                              color: ColorSystem.white,
                            ),
                          ),
                          TextSpan(
                            text: '/Order',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: SizeSystem.size10,
                              color: ColorSystem.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "Weekly 1",
                      style: TextStyle(
                        fontFamily: kRubik,
                        color: ColorSystem.white.withOpacity(0.4),
                        fontSize: SizeSystem.size12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getThirdContainer() {
    return Expanded(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "L. PURCHASE",
                style: TextStyle(
                  fontFamily: kRubik,
                  color: ColorSystem.secondary,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeSystem.size10,
                ),
              ),
              const SizedBox(
                height: SizeSystem.size5,
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: kRubik,
                  ),
                  children: [
                    TextSpan(
                      text: '1.5 ',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: SizeSystem.size24,
                      ),
                    ),
                    TextSpan(
                      text: 'k',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        // fontWeight: FontWeight.w700,
                        fontSize: SizeSystem.size12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
            child: VerticalDivider(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              thickness: 1,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "LTV",
                style: TextStyle(
                  fontFamily: kRubik,
                  color: ColorSystem.secondary,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeSystem.size10,
                ),
              ),
              const SizedBox(
                height: SizeSystem.size5,
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: kRubik,
                  ),
                  children: [
                    TextSpan(
                      text: '105.5 ',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: SizeSystem.size24,
                      ),
                    ),
                    TextSpan(
                      text: 'k',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        // fontWeight: FontWeight.w700,
                        fontSize: SizeSystem.size12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
            child: VerticalDivider(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              thickness: 1,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "AVG. ORDER",
                style: TextStyle(
                  fontFamily: kRubik,
                  color: ColorSystem.secondary,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeSystem.size10,
                ),
              ),
              const SizedBox(
                height: SizeSystem.size5,
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: kRubik,
                  ),
                  children: [
                    TextSpan(
                      text: '26.2 ',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: SizeSystem.size24,
                      ),
                    ),
                    TextSpan(
                      text: 'k',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        // fontWeight: FontWeight.w700,
                        fontSize: SizeSystem.size12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
