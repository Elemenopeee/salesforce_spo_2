import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';

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
    // TODO: implement dispose
    super.dispose();
    _tabController?.dispose();
  }

  var listOfName = [
    "Sebastian",
    "Amanda",
    "You / Claire",
    "Sebastian",
    "Amanda",
    "You / Claire",
  ];
  var listOfViews = [
    "105 k",
    "73 k",
    "51 k",
    "105 k",
    "73 k",
    "51 k",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // const AppBarCustom(),
              const SizedBox(
                height: 30,
              ),
              ProfileContainer(
                agentName: widget.agentName,
              ),
              const SizedBox(
                height: 20,
              ),
              const ProgressContainer(),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  CustomTabBarExtended(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    height: 45,
                    containerColor: Colors.grey.withOpacity(0.1),
                    containerBorderRadius: 10.0,
                    tabBorderRadius: 10.0,
                    tabOneName: "Open Order",
                    tabTwoName: "All Order",
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(
                          0.0,
                          1.0,
                        ),
                        blurRadius: 2,
                        spreadRadius: 2,
                      )
                    ],
                    tabController: _tabController,
                    tabColor: Colors.white,
                    labelColor: Colors.black,
                    unSelectLabelColor: Colors.grey,
                    labelTextStyle:
                        const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: SizedBox(
                      height: 300,
                      child: TabBarView(
                        controller: _tabController,
                        children: const [
                          OpenOrderTab(),
                          AllOrderTab(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

// class AppBarCustom extends StatefulWidget {
//   const AppBarCustom({Key? key}) : super(key: key);
//
//   @override
//   _AppBarCustomState createState() => _AppBarCustomState();
// }
//
// class _AppBarCustomState extends State<AppBarCustom> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         const SizedBox(
//           width: 15,
//         ),
//         Image.asset(
//           Images.icDrawer,
//           height: 30,
//           width: 30,
//           color: Colors.grey,
//         ),
//         const SizedBox(
//           width: 15,
//         ),
//         Image.asset(
//           Images.icMessenger,
//           height: 30,
//           width: 30,
//           color: Colors.grey,
//         ),
//         const Spacer(),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: const [
//             Text(
//               "HOME",
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black),
//             ),
//           ],
//         ),
//         const Spacer(),
//         Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             Image.asset(
//               Images.icNotification,
//               color: Colors.grey,
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               height: 10,
//               width: 10,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(50),
//                 color: Colors.purple,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(
//           width: 15,
//         ),
//         Image.asset(
//           Images.icSearch,
//           color: Colors.grey,
//         ),
//         const SizedBox(
//           width: 20,
//         ),
//       ],
//     );
//   }
// }

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
    var date = DateTime(dateNow.month, dateNow.day);
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
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    formattedDate,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.indigoAccent,
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
                  "Hi, ${widget.agentName}",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Stack(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.pinkAccent),
              ),
              Positioned(
                top: 42,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green,
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
    var response = await HttpService().doGet(path: Endpoints.getTotalSales());
    totalSales = response.data['records'][0]['expr0'];
  }

  Future<void> _getTotalCommission() async {
    var response =
        await HttpService().doGet(path: Endpoints.getTotalCommission());
    totalCommission = response.data['records'][0]['expr0'];
  }

  Future<void> _getTodaysSale() async {
    var response = await HttpService().doGet(path: Endpoints.getTodaysSales());
    if (response.data['records'].length > 0) {
      todaysSale = response.data['records'][0]['expr0'];
    }
  }

  Future<void> _getTodaysCommission() async {
    var response =
        await HttpService().doGet(path: Endpoints.getTodaysCommission());
    if (response.data['records'].length > 0) {
      todaysCommission = response.data['records'][0]['expr0'];
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

  String formattedNumber (double value){
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
            children: [
              const Text(
                "Metrics of Month",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.more_horiz_outlined,
                color: Colors.grey.withOpacity(0.2),
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
                    color: Colors.blueAccent.shade200.withOpacity(0.8),
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
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            RichText(
                              maxLines: 1,
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: '\$ ',
                                    style: TextStyle(
                                      fontSize: 36,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                  TextSpan(
                                    text: formattedNumber(totalSales),
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              month,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: '\$ ',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                  TextSpan(
                                    text: formattedNumber(todaysSale),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 08,
                            ),
                            Text(
                              "Today",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 15,
                              ),
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
                    color: Colors.indigoAccent.withOpacity(0.7),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
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
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: '\$ ',
                                    style: TextStyle(
                                      fontSize: 36,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                  TextSpan(
                                    text: formattedNumber(totalCommission),
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              month,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: '\$ ',
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w200,
                                    ),
                                  ),
                                  TextSpan(
                                    text: formattedNumber(todaysCommission),
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 08,
                            ),
                            Text(
                              "Today",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 15,
                              ),
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
