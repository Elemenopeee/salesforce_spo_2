import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/common_widgets/my_sales_widget.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/models/agent_metrics.dart';
import 'package:salesforce_spo/presentation/intermediate_widgets/tasks_widget.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';
import 'package:salesforce_spo/services/networking/request_body.dart';
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
            // const SizedBox(
            //   height: SizeSystem.size36,
            // ),
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

  int monthNumber = 1;

  late Future<void> futureAgentMetrics;

  AgentMetrics? agentMetrics;

  Future<void> getAgentMetrics() async {
    var id = await SharedPreferenceService().getValue(agentId);

    if (id != null) {
      var response = await HttpService().doPost(
          path: Endpoints.getAgentMetrics(),
          body: jsonEncode(
              RequestBody.getMetricsAndSmartTriggersBody('MyNewStore', id)));

      if (response.data != null) {
        agentMetrics = AgentMetrics.fromJson(response.data);
        monthNumber = response.data['PerDaySale']['Month__c'];
      }
    }
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'Month';
    }
  }

  @override
  void initState() {
    super.initState();
    futureAgentMetrics = getAgentMetrics();
  }

  String formattedNumber(double value) {
    var f = NumberFormat.compact(locale: "en_US");
    return f.format(value);
  }

  @override
  Widget build(BuildContext context) {
    var dateTime = DateTime.now();
    var month = DateFormat(DateFormat.MONTH).format(dateTime);

    return FutureBuilder(
      future: futureAgentMetrics,
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Metrics of ${getMonthName(monthNumber)}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: kRubik,
                          color: ColorSystem.primary,
                        ),
                      ),
                      const Icon(
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
                        child: MySalesWidget(
                          todaySale: 10000,
                          todayCommission: 100000,
                          perDayCommissions:
                              agentMetrics?.perDayCommission ?? [],
                          perDaySales: agentMetrics?.perDaySale ?? [],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TaskMetricsWidget(
                          allTasks: agentMetrics?.allTasks ?? 0,
                          pastOpenTasks: agentMetrics?.pastOpenTasks ?? 0,
                          pendingTasks: ((agentMetrics?.todayTasks ?? 0) +
                              (agentMetrics?.pastOpenTasks ?? 0)),
                          unAssignedTasks:
                              agentMetrics?.allUnassignedTasks ?? 0,
                          completedTasks: agentMetrics?.completedTasks ?? 0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}

class TaskMetricsWidget extends StatelessWidget {
  final int allTasks;
  final int unAssignedTasks;
  final int pastOpenTasks;
  final int pendingTasks;
  final int completedTasks;

  const TaskMetricsWidget({
    Key? key,
    required this.pastOpenTasks,
    required this.unAssignedTasks,
    required this.allTasks,
    required this.pendingTasks,
    required this.completedTasks,
  }) : super(key: key);

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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'MY TASK',
                style: TextStyle(
                  letterSpacing: 1.5,
                  color: ColorSystem.primary,
                  fontSize: SizeSystem.size12,
                  fontFamily: kRubik,
                ),
              ),
              Text(
                allTasks.toString(),
                style: const TextStyle(
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
                  allTasks.toDouble(),
                  pendingTasks.toDouble(),
                  completedTasks.toDouble(),
                  unAssignedTasks.toDouble(),
                ),
                centerSpaceColor: ColorSystem.purple.withOpacity(0.1),
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
                    pendingTasks.toString(),
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
                    'PENDING',
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
                    pastOpenTasks.toString(),
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
                    'OVERDUE',
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

List<PieChartSectionData> showingSections(
  double allTasks,
  double pendingTasks,
  double completedTasks,
  double unAssignedTasks,
) {
  return List.generate(4, (i) {
    const fontSize = 0.0;
    const radius = 26.0;
    switch (i) {
      case 0:
        return PieChartSectionData(
          color: const Color(0xFF7FE3F0),
          value: completedTasks,
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: fontSize,
          ),
        );
      case 1:
        return PieChartSectionData(
          color: const Color(0xFF6B5FD2),
          value: allTasks,
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: fontSize,
          ),
        );
      case 2:
        return PieChartSectionData(
          color: ColorSystem.peach,
          value: pendingTasks,
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: fontSize,
          ),
        );
      case 3:
        return PieChartSectionData(
          color: ColorSystem.complimentary,
          value: unAssignedTasks,
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