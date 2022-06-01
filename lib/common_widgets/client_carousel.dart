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

class ClientCarousel extends StatefulWidget {
  final Color? bannerOneColor;
  final Color? bannerTwoOColor;
  final Color? bannerThreeColor;

  const ClientCarousel({
    Key? key,
    this.bannerOneColor,
    this.bannerTwoOColor,
    this.bannerThreeColor,
  }) : super(key: key);

  @override
  _ClientCarouselState createState() => _ClientCarouselState();
}

class _ClientCarouselState extends State<ClientCarousel> {
  late Future _futureClientDetails;

  Future<void> getClientBasicDetails() async {
    var clientId = '0014M00001nv3BwQAI';

  }

  @override
  Widget build(BuildContext context) {
    return const ClientPrimaryDetails(clientName: '',);
  }
}

class ClientPrimaryDetails extends StatelessWidget {
  final String clientName;
  final String? clientType;
  final String? primaryInstrument;
  final double? lastPurchaseValue;
  final double? ltv;
  final double? netTransactions;
  final double? lastVisitDate;

  const ClientPrimaryDetails({
    Key? key,
    required this.clientName,
    this.clientType,
    this.primaryInstrument,
    this.lastPurchaseValue,
    this.ltv,
    this.netTransactions,
    this.lastVisitDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.symmetric(
        horizontal: PaddingSystem.padding16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeSystem.size12,
        ),
        color: ColorSystem.culturedGrey,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: PaddingSystem.padding20,
        horizontal: PaddingSystem.padding16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    IconSystem.badge,
                    height: 15,
                    width: 15,
                    color: ColorSystem.complimentary,
                  ),
                  const SizedBox(
                    width: SizeSystem.size4,
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
              )
            ],
          ),
          const SizedBox(
            height: SizeSystem.size12,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                LandingImages.guitarSolidIcon,
                width: SizeSystem.size24,
                height: SizeSystem.size24,
              ),
              const SizedBox(
                width: SizeSystem.size10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    height: SizeSystem.size4,
                  ),
                  const Text(
                    "Visited on : 12-Mar-2022",
                    style: TextStyle(
                      fontFamily: kRubik,
                      color: ColorSystem.primary,
                      fontSize: SizeSystem.size12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: SizeSystem.size10,
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
                    height: SizeSystem.size4,
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: kRubik,
                      ),
                      children: [
                        TextSpan(
                          text: '1.5',
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
                height: SizeSystem.size50,
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
                    height: SizeSystem.size4,
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: kRubik,
                      ),
                      children: [
                        TextSpan(
                          text: '105.5',
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
                height: SizeSystem.size50,
                child: VerticalDivider(
                  color: Color.fromRGBO(0, 0, 0, 0.04),
                  thickness: 1,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "AOV",
                    style: TextStyle(
                      fontFamily: kRubik,
                      color: ColorSystem.secondary,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeSystem.size10,
                    ),
                  ),
                  const SizedBox(
                    height: SizeSystem.size4,
                  ),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: kRubik,
                      ),
                      children: [
                        TextSpan(
                          text: '26.2',
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
    );
  }
}
