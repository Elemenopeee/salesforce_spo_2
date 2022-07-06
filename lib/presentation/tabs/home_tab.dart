import 'dart:convert';

import 'package:flutter/material.dart';
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
import '../../common_widgets/task_metrics_widget.dart';
import '../../models/agent.dart';

class TabHome extends StatefulWidget {
  const TabHome({
    Key? key,
  }) : super(key: key);

  @override
  _TabHomeState createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int currentIndex = 0;
  int currentIndexForInnerTab = 0;
  late Future<void> futureUser;

  Agent? agent;

  String agentName = '';

  @override
  void initState() {
    super.initState();
    futureUser = getAgentProfile();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  Future<void> getAgentProfile() async {
    var email = await SharedPreferenceService().getValue(agentEmail);
    if (email != null) {
      var response = await HttpService().doPost(
          path: Endpoints.getAgentProfile(),
          body: jsonEncode(RequestBody.getAgentProfileBody(email: email)));
      if (response.data != null) {
        agent = Agent.fromJson(response.data['UserList'][0]['User'],
            isManager: response.data['UserList'][0]['IsManager']);

        if (agent != null) {
          if (agent!.name != null) {
            agentName = agent!.name!.split(' ').first;
          }
        }

        if (agent?.id != null) {
          SharedPreferenceService().setKey(key: agentId, value: agent!.id!);
        }

        if(agent?.name != null){
          SharedPreferenceService().setKey(key: savedAgentName, value: agent!.name!);
        }

        if (agent?.storeId != null) {
          SharedPreferenceService()
              .setKey(key: storeId, value: agent!.storeId!);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureUser,
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
            return SafeArea(
              child: RefreshIndicator(
                color: ColorSystem.primary,
                onRefresh: () async {
                  setState(() {
                    futureUser = getAgentProfile();
                  });
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProfileContainer(
                        agentName: agentName.isNotEmpty ? agentName : 'there',
                      ),
                      const SizedBox(
                        height: SizeSystem.size20,
                      ),
                      ProgressContainer(
                        isManager: agent?.isManager ?? false,
                      ),
                      const SizedBox(
                        height: SizeSystem.size20,
                      ),
                      TasksWidget(
                        agent: agent,
                        agentName:
                            agentName.isNotEmpty ? '$agentName\'s' : 'My',
                      ),
                      const SizedBox(
                        height: SizeSystem.size36,
                      ),
                    ],
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}

class ProgressContainer extends StatefulWidget {
  final bool isManager;

  const ProgressContainer({
    Key? key,
    required this.isManager,
  }) : super(key: key);

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
          body: jsonEncode(RequestBody.getMetricsAndSmartTriggersBody(
              widget.isManager ? myNewStore : myNewTask, id)));

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
                          todaySale: agentMetrics?.yesterdaySale ?? 0,
                          todayCommission:
                              agentMetrics?.yesterdayCommission ?? 0,
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
                          isManager: agentMetrics?.isManager ?? false,
                          allTasks: agentMetrics?.allTasks ?? 0,
                          pastOpenTasks: agentMetrics?.pastOpenTasks ?? 0,
                          pendingTasks: agentMetrics?.todayTasks ?? 0,
                          unAssignedTasks:
                              agentMetrics?.allUnassignedTasks ?? 0,
                          completedTasks: agentMetrics?.completedTasks ?? 0,
                          futureTasks: agentMetrics?.futureTasks ?? 0,
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
