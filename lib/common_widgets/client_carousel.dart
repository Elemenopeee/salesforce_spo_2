import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/common_widgets/pi_chart_widget.dart';
import 'package:salesforce_spo/models/customer.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/icon_system.dart';
import '../design_system/primitives/landing_images.dart';
import '../design_system/primitives/padding_system.dart';
import '../design_system/primitives/size_system.dart';
import '../presentation/screens/chart/sector.dart';
import '../utils/constant_functions.dart';
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

  Customer? customer;

  Future<void> getClientBasicDetails() async {
    var clientId = '0014M00001nv3BwQAI';

    var response = await HttpService()
        .doGet(path: Endpoints.getClientBasicDetails(clientId));

    customer = Customer.fromJson(json: response.data['records'][0]);
  }

  @override
  void initState() {
    super.initState();
    _futureClientDetails = getClientBasicDetails();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureClientDetails,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            return ClientPrimaryDetails(
              clientName: customer?.name ?? '--',
              primaryInstrument: customer?.primaryInstrument,
              ltv: customer?.lifeTimeNetSalesAmount,
              netTransactions: customer?.lifetimeNetTransactions,
              lastVisitDate: customer?.lastTransactionDate,
            );
        }
      },
    );
  }
}

class ClientPrimaryDetails extends StatelessWidget {
  final String clientName;
  final String? clientType;
  final String? primaryInstrument;
  final double? lastPurchaseValue;
  final double? ltv;
  final double? netTransactions;
  final String? lastVisitDate;

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

  String formatDate(String date) {
    return DateFormat('dd-MMM-yyyy').format(DateTime.parse(date));
  }

  String formattedNumber(double value) {
    var f = NumberFormat.compact(locale: "en_US");
    try {
      return f.format(value);
    } catch (e) {
      return '0';
    }
  }

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
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: kRubik,
                  ),
                  children: [
                    TextSpan(
                      text: '$clientName ',
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
              if(ltv != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    IconSystem.badge,
                    height: 15,
                    width: 15,
                    color: getCustomerLevelColor(getCustomerLevel(ltv!)),
                  ),
                  const SizedBox(
                    width: SizeSystem.size4,
                  ),
                  Text(
                    getCustomerLevel(ltv!),
                    style: TextStyle(
                      fontFamily: kRubik,
                      fontWeight: FontWeight.w600,
                      color: getCustomerLevelColor(getCustomerLevel(ltv!)),
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
                  Text(
                    "Visited on : ${lastVisitDate != null ? formatDate(lastVisitDate!) : '--'}",
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
                          text: '--',
                          style: TextStyle(
                            color: ColorSystem.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: SizeSystem.size24,
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
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: kRubik,
                      ),
                      children: [
                        TextSpan(
                          text: ltv != null ? formattedNumber(ltv!) : '--',
                          style: const TextStyle(
                            color: ColorSystem.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: SizeSystem.size24,
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
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: kRubik,
                      ),
                      children: [
                        TextSpan(
                          text: formattedNumber(aovCalculator(ltv, netTransactions)),
                          style: const TextStyle(
                            color: ColorSystem.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: SizeSystem.size24,
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
