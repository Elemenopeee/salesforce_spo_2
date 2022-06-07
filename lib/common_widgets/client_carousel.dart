import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/common_widgets/client_accessories_banner.dart';
import 'package:salesforce_spo/models/client_metric.dart';
import 'package:salesforce_spo/models/customer.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/icon_system.dart';
import '../design_system/primitives/padding_system.dart';
import '../design_system/primitives/size_system.dart';
import '../models/purchase_category.dart';
import '../utils/constant_functions.dart';
import '../utils/constants.dart';
import '../utils/enums/music_instrument_enum.dart';
import 'client_channel_banner.dart';

class ClientCarousel extends StatefulWidget {
  final String customerId;

  const ClientCarousel({
    Key? key,
    required this.customerId,
  }) : super(key: key);

  @override
  _ClientCarouselState createState() => _ClientCarouselState();
}

class _ClientCarouselState extends State<ClientCarousel> {
  late Future _futureClientDetails;

  Customer? customer;

  List<ClientMetric> purchaseCategories = [];
  List<ClientMetric> channels = [];

  Future<void> getClientBasicDetails() async {
    var response = await HttpService()
        .doGet(path: Endpoints.getClientBasicDetails(widget.customerId));

    customer = Customer.fromJson(json: response.data['records'][0]);
    await getClientChannelAndCategoryDetails();
  }

  Future<void> getClientChannelAndCategoryDetails() async {
    var response = await HttpService().doGet(
        path: Endpoints.getClientPurchaseChannelAndCategory('1000000000002'),
        headers: kPurchaseChannelHeaders);

    if (response.data != null) {
      Map<String, dynamic> purchaseChannelMap =
          response.data['PurchaseChannel'];

      purchaseChannelMap.forEach((key, value) {
        channels.add(ClientMetric.fromPair(key, value));
      });

      channels.sort((a, b) => b.value.compareTo(a.value));

      Map<String, dynamic> purchaseCategoriesMap =
          response.data['PurchaseCategory'];

      purchaseCategoriesMap.forEach((key, value) {
        purchaseCategories.add(ClientMetric.fromPair(key, value));
      });

      purchaseCategories.sort((a, b) => b.value.compareTo(a.value));

    }
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
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator(
                color: ColorSystem.primary,
              ),
            );
          case ConnectionState.done:
            return CarouselSlider(
              items: [
                ClientPrimaryDetails(
                  clientName: customer?.name ?? '--',
                  primaryInstrument: customer?.primaryInstrument,
                  ltv: customer?.lifeTimeNetSalesAmount,
                  netTransactions: customer?.lifetimeNetTransactions,
                  lastVisitDate: customer?.lastTransactionDate,
                  lastPurchaseValue: customer?.lastPurchaseValue,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ClientAccessoriesBanner(
                    accessories: purchaseCategories,
                  ),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClientChannelBanner(
                        details: channels,
                      ),
                    )),
                ClientSales(),
              ],
              options: CarouselOptions(height: 168, viewportFraction: 0.7),
            );
        }
      },
    );
  }
}

class ClientSales extends StatelessWidget {
  const ClientSales({Key? key}) : super(key: key);

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
                child: PieChart(
                  PieChartData(
                    sections: showingSections(
                      800,
                      2000,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '18.8k',
                      maxLines: 2,
                      style: TextStyle(
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
                            '0.2k',
                            style: TextStyle(
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
                          Text(
                            '2.22k',
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
          SizeSystem.size16,
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
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: SizeSystem.size16,
                        color: ColorSystem.primaryTextColor,
                      ),
                    ),
                    const TextSpan(
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
              if (ltv != null)
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
              SvgPicture.asset(MusicInstrument.getInstrumentIcon(
                  MusicInstrument.getMusicInstrumentFromString(
                      primaryInstrument!))),
              const SizedBox(
                width: SizeSystem.size10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: kRubik,
                      ),
                      children: [
                        TextSpan(
                          text: '${primaryInstrument ?? '--'} |',
                          style: const TextStyle(
                            fontSize: SizeSystem.size12,
                            color: ColorSystem.primary,
                            fontFamily: kRubik,
                          ),
                        ),
                        const TextSpan(
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
                    "Last purchase : ${lastVisitDate != null ? formatDate(lastVisitDate!) : '--'}",
                    style: const TextStyle(
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
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: kRubik,
                      ),
                      children: [
                        TextSpan(
                          text: lastPurchaseValue != null
                              ? '\$${formattedNumber(lastPurchaseValue!)}'
                              : '--',
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
                          text:
                              ltv != null ? '\$${formattedNumber(ltv!)}' : '--',
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
                          text:
                              '\$${formattedNumber(aovCalculator(ltv, netTransactions))}',
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
