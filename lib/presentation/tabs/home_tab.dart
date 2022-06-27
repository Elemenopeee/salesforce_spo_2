import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/common_widgets/my_sales_widget.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/presentation/intermediate_widgets/tasks_widget.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';
import 'package:salesforce_spo/services/storage/shared_preferences_service.dart';
import 'package:salesforce_spo/utils/constants.dart';

import '../../common_widgets/profile_container.dart';
import 'all_orders.dart';
import 'custom_tab_bar.dart';
import 'open_orders.dart';

class TabHome extends StatefulWidget {
  final String? agentName;

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
              agentName: widget.agentName ?? 'there',
            ),
            const SizedBox(
              height: SizeSystem.size20,
            ),
            const ProgressContainer(),

            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: SizeSystem.size28,
            //     vertical: SizeSystem.size14,
            //   ),
            //   child: SvgPicture.asset(IconSystem.inProgress),
            // ),
            // const SizedBox(
            //   height: SizeSystem.size36,
            // ),
            TasksWidget(
              agentName:
                  widget.agentName != null ? '${widget.agentName}\'s' : 'My',
            ),
            // const Center(
            //   child: Text(
            //     'Work in progress',
            //     style: TextStyle(
            //       color: ColorSystem.secondary,
            //       fontSize: SizeSystem.size12,
            //       fontFamily: kRubik,
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: SizeSystem.size36,
            ),
          ],
        ),
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

  // late Future<void> _futureSales;
  // late Future<void> _futureCommission;
  // late Future<void> _futureTodaysSale;
  // late Future<void> _futureTodaysCommission;
  //
  // Future<void> _getTotalSales() async {
  //   var agentMail = await SharedPreferenceService().getValue('agent_email');
  //   if (agentMail != null) {
  //     var response =
  //         await HttpService().doGet(path: Endpoints.getTotalSales(agentMail));
  //     try {
  //       totalSales = response.data['records'][0]['Sales'];
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  // }
  //
  // Future<void> _getTotalCommission() async {
  //   var agentMail = await SharedPreferenceService().getValue('agent_email');
  //   if (agentMail != null) {
  //     var response = await HttpService()
  //         .doGet(path: Endpoints.getTotalCommission(agentMail));
  //     try {
  //       totalCommission = response.data['records'][0]['commission'];
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  // }
  //
  // Future<void> _getTodaysSale() async {
  //   var agentMail = await SharedPreferenceService().getValue('agent_email');
  //   if (agentMail != null) {
  //     var response =
  //         await HttpService().doGet(path: Endpoints.getTodaysSales(agentMail));
  //     List<dynamic> records = response.data['records'];
  //     if (records.isNotEmpty) {
  //       try {
  //         var saleData = records.firstWhere(
  //             (element) => element['Gross_Sales_Yesterday__c'] != null);
  //         todaysSale = saleData['Gross_Sales_Yesterday__c'];
  //       } catch (e) {
  //         print(e);
  //       }
  //     }
  //   }
  // }
  //
  // Future<void> _getTodaysCommission() async {
  //   var agentMail = await SharedPreferenceService().getValue('agent_email');
  //   if (agentMail != null) {
  //     var response = await HttpService()
  //         .doGet(path: Endpoints.getTodaysCommission(agentMail));
  //     List<dynamic> records = response.data['records'];
  //
  //     if (records.isNotEmpty) {
  //       try {
  //         var commissionData = records.firstWhere(
  //             (element) => element['Comm_Amount_Yesterday__c'] != null);
  //         todaysCommission = commissionData['Comm_Amount_Yesterday__c'];
  //       } catch (e) {
  //         print(e);
  //       }
  //     }
  //   }
  // }
  //
  // Future<void>

  @override
  void initState() {
    super.initState();
    // _futureSales = _getTotalSales();
    // _futureCommission = _getTotalCommission();
    // _futureTodaysSale = _getTodaysSale();
    // _futureTodaysCommission = _getTodaysCommission();
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
                child: MySalesWidget(totalSales: 100, totalCommission: 100),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child:TaskMetricsWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TaskMetricsWidget extends StatelessWidget {
  const TaskMetricsWidget({Key? key}) : super(key: key);

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MY TASK',
                style: TextStyle(
                  letterSpacing: 1.5,
                  color: ColorSystem.primary,
                  fontSize: SizeSystem.size12,
                  fontFamily: kRubik,
                ),
              ),
              Text(
                '40',
                style: TextStyle(
                  color: ColorSystem.primary,
                  fontSize: SizeSystem.size24,
                  fontWeight: FontWeight.bold,
                  fontFamily: kRubik,
                ),
              )
            ],
          ),
          const SizedBox(
            height: SizeSystem.size12,
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: PieChart(
              PieChartData(
                sections: showingSections(
                    100,
                    1000),
                centerSpaceColor:
                const Color(0xFFAF8EFF).withOpacity(0.1),
                centerSpaceRadius: 24,
              ),
            ),
          ),
          const SizedBox(
            height: SizeSystem.size20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '27',
                    style: TextStyle(
                      color: ColorSystem.purple,
                      fontSize: SizeSystem.size24,
                      fontFamily: kRubik,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: SizeSystem.size4,
                  ),
                  Text(
                    'MY TASK',
                    style: TextStyle(
                      color: ColorSystem.primary,
                      fontSize: SizeSystem.size12,
                      fontFamily: kRubik,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '27',
                    style: TextStyle(
                      color: ColorSystem.peach,
                      fontSize: SizeSystem.size24,
                      fontFamily: kRubik,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: SizeSystem.size4,
                  ),
                  Text(
                    'MY TASK',
                    style: TextStyle(
                      color: ColorSystem.primary,
                      fontSize: SizeSystem.size12,
                      fontFamily: kRubik,
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


List<PieChartSectionData> showingSections(double today, double total) {
  return List.generate(3, (i) {
    const fontSize = 0.0;
    const radius = 26.0;
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
          color: const Color(0xFF6B5FD2),
          value: total,
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: fontSize,
          ),
        );
      case 2:
        return PieChartSectionData(
          color: ColorSystem.peach,
          value: today,
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
