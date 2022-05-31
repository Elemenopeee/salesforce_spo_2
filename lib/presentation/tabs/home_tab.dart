import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';
import 'package:salesforce_spo/services/storage/shared_preferences_service.dart';
import 'package:salesforce_spo/utils/constants.dart';

import 'all_orders.dart';
import 'custom_tab_bar.dart';
import 'open_orders.dart';

class TabHome extends StatefulWidget {
  final String agentName;

  const TabHome({
    Key? key,
    required this.agentName,
  }) : super(key: key);

  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int currentIndex = 0;
  int currentIndexForInnerTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProfileContainer(
              agentName: widget.agentName,
            ),
            const SizedBox(
              height: SizeSystem.size20,
            ),
            const ProgressContainer(),
            const SizedBox(
              height: SizeSystem.size36,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SizeSystem.size28,
                vertical: SizeSystem.size14,
              ),
              child: SvgPicture.asset(IconSystem.inProgress),
            ),
            const SizedBox(
              height: SizeSystem.size36,
            ),
            const Center(
              child: Text(
                'Work in progress',
                style: TextStyle(
                  color: ColorSystem.secondary,
                  fontSize: SizeSystem.size12,
                  fontFamily: kRubik,
                ),
              ),
            ),
            const SizedBox(
              height: SizeSystem.size36,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileContainer extends StatefulWidget {
  final String agentName;

  const ProfileContainer({
    Key? key,
    required this.agentName,
  }) : super(key: key);

  @override
  State<ProfileContainer> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  @override
  Widget build(BuildContext context) {
    var dateNow = DateTime.now();
    var date = DateTime(dateNow.year, dateNow.month, dateNow.day);
    var formattedDate =
        DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY).format(date);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    IconSystem.sun,
                    width: SizeSystem.size16,
                    height: SizeSystem.size16,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    formattedDate.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorSystem.lavender2,
                      fontFamily: kRubik,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 05),
                child: Text(
                  "Hi ${widget.agentName}",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: kRubik,
                    color: ColorSystem.primary,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: SizeSystem.size60,
            width: SizeSystem.size60,
            child: SvgPicture.asset(
              IconSystem.userPlaceholder,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeSystem.size24),
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressContainer extends StatefulWidget {
  const ProgressContainer({Key? key}) : super(key: key);

  @override
  State<ProgressContainer> createState() => _ProgressContainerState();
}

class _ProgressContainerState extends State<ProgressContainer> {
  double totalSales = 0;
  double totalCommission = 0;
  double todaysSale = 0;
  double todaysCommission = 0;

  late Future<void> _futureSales;
  late Future<void> _futureCommission;
  late Future<void> _futureTodaysSale;
  late Future<void> _futureTodaysCommission;

  Future<void> _getTotalSales() async {
    var agentMail = await SharedPreferenceService().getValue('agent_email');
    if (agentMail != null) {
      var response =
          await HttpService().doGet(path: Endpoints.getTotalSales(agentMail));
      try {
        totalSales = response.data['records'][0]['Sales'];
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> _getTotalCommission() async {
    var agentMail = await SharedPreferenceService().getValue('agent_email');
    if (agentMail != null) {
      var response = await HttpService()
          .doGet(path: Endpoints.getTotalCommission(agentMail));
      try {
        totalCommission = response.data['records'][0]['commission'];
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> _getTodaysSale() async {
    var agentMail = await SharedPreferenceService().getValue('agent_email');
    if (agentMail != null) {
      var response =
          await HttpService().doGet(path: Endpoints.getTodaysSales(agentMail));
      List<dynamic> records = response.data['records'];
      if (records.isNotEmpty) {
        try {
          var saleData = records.firstWhere(
              (element) => element['Gross_Sales_Yesterday__c'] != null);
          todaysSale = saleData['Gross_Sales_Yesterday__c'];
        } catch (e) {
          print(e);
        }
      }
    }
  }

  Future<void> _getTodaysCommission() async {
    var agentMail = await SharedPreferenceService().getValue('agent_email');
    if (agentMail != null) {
      var response = await HttpService()
          .doGet(path: Endpoints.getTodaysCommission(agentMail));
      List<dynamic> records = response.data['records'];

      if (records.isNotEmpty) {
        try {
          var commissionData = records.firstWhere(
              (element) => element['Comm_Amount_Yesterday__c'] != null);
          todaysCommission = commissionData['Comm_Amount_Yesterday__c'];
        } catch (e) {
          print(e);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _futureSales = _getTotalSales();
    _futureCommission = _getTotalCommission();
    _futureTodaysSale = _getTodaysSale();
    _futureTodaysCommission = _getTodaysCommission();
  }

  String formattedNumber(double value) {
    var f = NumberFormat.compact(locale: "en_US");
    return f.format(value);
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.now();
    var month = DateFormat(DateFormat.MONTH).format(dateTime);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Metrics of Month",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: kRubik,
                  color: ColorSystem.primary,
                ),
              ),
              Icon(
                Icons.more_horiz_outlined,
                color: Colors.white,
                size: 40,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  // height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF8C80F8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: FutureBuilder(
                      future: Future.wait([
                        _futureSales,
                        _futureTodaysSale,
                      ]),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "MY SALES",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                fontFamily: kRubik,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Center(
                              child: SizedBox(
                                height: 80,
                                width: 100,
                                child: totalSales == 0 && totalCommission == 0
                                    ? SvgPicture.asset(IconSystem.noSales)
                                    : PieChart(
                                        PieChartData(
                                          sections: showingSections(
                                              todaysSale, totalSales),
                                          centerSpaceColor:
                                              const Color(0xFF8C80F8),
                                          centerSpaceRadius: 24,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  totalSales == 0
                                      ? '--'
                                      : formattedNumber(totalSales)
                                          .toLowerCase(),
                                  style: const TextStyle(
                                    fontSize: SizeSystem.size24,
                                    color: ColorSystem.white,
                                    fontFamily: kRubik,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  todaysSale == 0
                                      ? '--'
                                      : formattedNumber(todaysSale),
                                  style: const TextStyle(
                                    fontSize: SizeSystem.size14,
                                    color: ColorSystem.white,
                                    fontFamily: kRubik,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: SizeSystem.size4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  month,
                                  style: TextStyle(
                                    fontSize: SizeSystem.size12,
                                    color: ColorSystem.white.withOpacity(0.5),
                                    fontFamily: kRubik,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'Today',
                                  style: TextStyle(
                                    fontSize: SizeSystem.size12,
                                    color: ColorSystem.white.withOpacity(0.5),
                                    fontFamily: kRubik,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  // height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFFAF8EFF),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: FutureBuilder(
                      future: Future.wait([
                        _futureCommission,
                        _futureTodaysCommission,
                      ]),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "MY COMMISSION",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                fontFamily: kRubik,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Center(
                              child: SizedBox(
                                height: 80,
                                width: 100,
                                child: totalSales == 0 && totalCommission == 0
                                    ? SvgPicture.asset(IconSystem.noCommission)
                                    : PieChart(
                                        PieChartData(
                                          sections: showingSections(
                                              todaysCommission,
                                              totalCommission),
                                          centerSpaceColor:
                                              const Color(0xFFAF8EFF),
                                          centerSpaceRadius: 24,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  totalCommission == 0
                                      ? '--'
                                      : formattedNumber(totalCommission)
                                          .toLowerCase(),
                                  style: const TextStyle(
                                    fontSize: SizeSystem.size24,
                                    color: ColorSystem.white,
                                    fontFamily: kRubik,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  todaysCommission == 0
                                      ? '--'
                                      : formattedNumber(todaysCommission),
                                  style: const TextStyle(
                                    fontSize: SizeSystem.size14,
                                    color: ColorSystem.white,
                                    fontFamily: kRubik,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: SizeSystem.size4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  month,
                                  style: TextStyle(
                                    fontSize: SizeSystem.size12,
                                    color: ColorSystem.white.withOpacity(0.5),
                                    fontFamily: kRubik,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  'Today',
                                  style: TextStyle(
                                    fontSize: SizeSystem.size12,
                                    color: ColorSystem.white.withOpacity(0.5),
                                    fontFamily: kRubik,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> showingSections(double today, double total) {
  return List.generate(2, (i) {
    const fontSize = 0.0;
    const radius = 10.0;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: const Color(0xFF7FE3F0),
          value: today,
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: fontSize,
          ),
        );
      case 1:
        return PieChartSectionData(
          color: const Color(0xFF5763A9),
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

// CustomTabBarExtended(
// padding: const EdgeInsets.symmetric(horizontal: 30),
// height: 40,
// containerColor: Colors.grey.withOpacity(0.1),
// containerBorderRadius: 10.0,
// tabBorderRadius: 10.0,
// tabOneName: "Open Orders",
// tabTwoName: "All Orders",
// boxShadow: [
// BoxShadow(
// color: Colors.grey.shade300,
// offset: const Offset(
// 0.0,
// 1.0,
// ),
// blurRadius: 2,
// spreadRadius: 2,
// )
// ],
// tabController: _tabController,
// tabColor: Colors.white,
// labelColor: Colors.black,
// unSelectLabelColor: Colors.grey,
// labelTextStyle: const TextStyle(
// fontWeight: FontWeight.bold,
// fontFamily: kRubik,
// ),
// ),

// SizedBox(
// height: 360,
// child: TabBarView(
// controller: _tabController,
// children: const [
// OpenOrderTab(),
// AllOrderTab(),
// ],
// ),
// )
