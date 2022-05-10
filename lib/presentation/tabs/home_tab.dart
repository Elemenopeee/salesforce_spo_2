import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/design_system/design_system.dart';

import 'all_orders.dart';
import 'custom_tab_bar.dart';
import 'open_orders.dart';

class TabHome extends StatefulWidget {
  const TabHome({Key? key}) : super(key: key);

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
              const ProfileContainer(),
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

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  const Text(
                    "WED 16 MAR",
                    style: TextStyle(
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 05),
                child: Text(
                  "Hi, ${"Grace"}",
                  style: TextStyle(
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

class ProgressContainer extends StatelessWidget {
  const ProgressContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent.shade200.withOpacity(0.8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                        child: Text(
                          "MY SALES",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Center(
                        child: SvgPicture.asset(
                          'assets/icons/ic_graph.svg',
                          height: 90.00,
                          width: 90.00,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "12% ",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: "of store",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 08,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "29k This Month",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.indigoAccent.withOpacity(0.7),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                        child: Text(
                          "MY COMMISSION",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 08,
                      ),
                      Center(
                        child: SvgPicture.asset(
                          'assets/icons/ic_chart.svg',
                          height: 90.00,
                          width: 90.00,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(
                        height: 08,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "1.4",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: "k",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 08,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Nice Job!",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
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