import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:salesforce_spo/common_widgets/custom_linear_progress_indicator.dart';
import 'package:salesforce_spo/common_widgets/agent_tasks_list_widget.dart';
import 'package:salesforce_spo/common_widgets/horizontal_multiple_progress_indicator.dart';
import 'package:salesforce_spo/common_widgets/task_alert_widget.dart';
import 'package:salesforce_spo/common_widgets/task_list_widget.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/models/agent.dart';
import 'package:salesforce_spo/models/task.dart';
import 'package:salesforce_spo/presentation/tabs/custom_tab_bar.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';
import 'package:salesforce_spo/services/networking/request_body.dart';
import 'package:salesforce_spo/services/storage/shared_preferences_service.dart';

import '../../common_widgets/custom_dialog_action.dart';
import '../../models/agent_metrics.dart';
import '../../utils/constants.dart';
import '../screens/task_details_screen.dart';

class TasksWidget extends StatefulWidget {
  final String agentName;
  final bool showGraphs;
  final Agent? agent;

  const TasksWidget({
    Key? key,
    required this.agentName,
    this.showGraphs = false,
    this.agent,
  }) : super(key: key);

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget>
    with SingleTickerProviderStateMixin {
  late Future<void> futureTasks;
  late Future<void> futureTeamTasks;
  late TabController teamsTabController;

  List<TaskModel> todaysTasks = [],
      pastOpenTasks = [],
      futureOpenTasks = [],
      completedTasks = [],
      unAssignedTasks = [],
      allTasks = [];

  List<TaskModel> displayedList = [];
  List<TaskModel> specificAgentTasks = [];

  List<Agent> teamTaskList = [];

  bool isManager = false;
  bool showingAgentTasks = true;
  bool showingOverdue = false;
  bool showingUnAssignedTasks = true;
  bool managerViewingTeamTasks = true;

  int managerViewIndex = 0;

  String id = '';

  String filterName = 'UNASSIGNED';

  int unAssignedTasksCount = 0;

  void clearLists() {
    todaysTasks.clear();
    pastOpenTasks.clear();
    futureOpenTasks.clear();
    completedTasks.clear();
    unAssignedTasks.clear();
    allTasks.clear();
  }

  Future<void> getTasks(String tabName) async {
    clearLists();

    id = await SharedPreferenceService().getValue(agentId) ?? '';

    var response = await HttpService().doPost(
        path: Endpoints.getSmartTriggers(),
        body:
            jsonEncode(RequestBody.getMetricsAndSmartTriggersBody(tabName, id)),
        tokenRequired: true);

    if (response.data != null) {
      try {
        for (var task in response.data['TodayOpenTasks']) {
          todaysTasks.add(TaskModel.fromJson(task));
        }
        for (var task in response.data['PastOpenTasks']) {
          pastOpenTasks.add(TaskModel.fromJson(task));
        }
        for (var task in response.data['FutureOpenTasks']) {
          futureOpenTasks.add(TaskModel.fromJson(task));
        }
        for (var task in response.data['CompletedTasks']) {
          completedTasks.add(TaskModel.fromJson(task));
        }
        for (var task in response.data['UnassignedOpenTasks']) {
          unAssignedTasks.add(TaskModel.fromJson(task));
        }
        for (var task in response.data['AllOpenTasks']) {
          allTasks.add(TaskModel.fromJson(task));
        }
      } catch (e) {
        print(e);
      }
    }

    if (isManager && showingAgentTasks) {
      await getAgentMetrics();
    }

    displayedList.clear();
    if (!showingAgentTasks) {
      displayedList = List.from(unAssignedTasks);
    } else {
      displayedList = List.from(allTasks);
    }

    teamsTabController = TabController(length: isManager ? 2 : 1, vsync: this);
    teamsTabController.addListener(_handleTabSelection);
  }

  Future<void> getAgentMetrics() async {
    var id = await SharedPreferenceService().getValue(agentId);

    if (id != null) {
      var response = await HttpService().doPost(
          path: Endpoints.getAgentMetrics(),
          body: jsonEncode(
              RequestBody.getMetricsAndSmartTriggersBody(myNewStore, id)));

      if (response.data != null) {
        var agentMetrics = AgentMetrics.fromJson(response.data);
        unAssignedTasksCount = agentMetrics.allUnassignedTasks;
      }
    }
  }

  Future<void> getTeamTasks() async {
    teamTaskList.clear();

    var response = await HttpService().doPost(
        path: Endpoints.getTeamTaskList(),
        body: jsonEncode(
            RequestBody.getMetricsAndSmartTriggersBody('MyNewTeam', id)),
        tokenRequired: true);

    try {
      for (var agentTaskJson in response.data['AggregatedTaskList']) {
        teamTaskList.add(Agent.fromTeamTaskListJson(agentTaskJson));
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  double percentCalculator(int todaysTasks, int allTasks) {
    if (todaysTasks == 0) {
      return 0;
    } else {
      if (allTasks == 0) {
        return 0.7;
      }
      return 0.7 * (allTasks - todaysTasks) / allTasks;
    }
  }

  @override
  initState() {
    super.initState();

    if (widget.agent != null) {
      isManager = widget.agent!.isManager;
    }

    futureTasks = getTasks(myNewTask);
    futureTeamTasks = getTeamTasks();
  }

  void _handleTabSelection() {
    if (teamsTabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        futureTasks,
        futureTeamTasks,
      ]),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const SizedBox(
              height: SizeSystem.size100,
              child: Center(
                child: CircularProgressIndicator(
                  color: ColorSystem.primary,
                ),
              ),
            );
          case ConnectionState.done:
            if (allTasks.isEmpty) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: SizeSystem.size24),
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeSystem.size24,
                  vertical: SizeSystem.size30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(SizeSystem.size20),
                  boxShadow: [
                    BoxShadow(
                      color: ColorSystem.blue1.withOpacity(0.15),
                      blurRadius: 12.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${showingAgentTasks ? widget.agentName.toUpperCase() : 'STORE $filterName'} TASKS',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeSystem.size14,
                                color: ColorSystem.lavender2,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(
                              height: SizeSystem.size20,
                            ),
                            const Text(
                              'No Tasks Available',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeSystem.size14,
                                color: ColorSystem.primary,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (isManager)
                              InkWell(
                                focusColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                onTap: () {
                                  if (showingAgentTasks) {
                                    futureTasks = getTasks(myNewStore);
                                  } else {
                                    futureTasks = getTasks(myNewTask);
                                  }
                                  showingAgentTasks = !showingAgentTasks;
                                  setState(() {});
                                },
                                child: SvgPicture.asset(
                                  showingAgentTasks
                                      ? IconSystem.storeTasks
                                      : IconSystem.agentTasks,
                                  width: SizeSystem.size36,
                                ),
                              ),
                            const SizedBox(
                              width: SizeSystem.size16,
                            ),
                            InkWell(
                              focusColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      actions: [
                                        Column(
                                          children: [
                                            CustomDialogAction(
                                              label: 'All (${allTasks.length})',
                                              onTap: () {
                                                displayedList.clear();
                                                displayedList =
                                                    List.from(allTasks);
                                                Navigator.of(context).pop();
                                                showingOverdue = false;
                                                showingUnAssignedTasks = false;
                                                filterName = 'ALL';
                                              },
                                            ),
                                            Container(
                                              height: SizeSystem.size1,
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            CustomDialogAction(
                                              label:
                                                  'Today (${todaysTasks.length})',
                                              onTap: () {
                                                displayedList.clear();
                                                displayedList =
                                                    List.from(todaysTasks);
                                                Navigator.of(context).pop();
                                                showingOverdue = false;
                                                showingUnAssignedTasks = false;
                                                filterName = 'TODAYS';
                                              },
                                            ),
                                            Container(
                                              height: SizeSystem.size1,
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            if (!showingAgentTasks)
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  CustomDialogAction(
                                                    label:
                                                        'Unassigned (${unAssignedTasks.length})',
                                                    onTap: () {
                                                      displayedList.clear();
                                                      displayedList = List.from(
                                                          unAssignedTasks);
                                                      Navigator.of(context)
                                                          .pop();
                                                      showingOverdue = false;
                                                      showingUnAssignedTasks =
                                                          true;
                                                      filterName = 'UNASSIGNED';
                                                    },
                                                  ),
                                                  Container(
                                                    height: SizeSystem.size1,
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                  ),
                                                ],
                                              ),
                                            CustomDialogAction(
                                              label:
                                                  'Completed (${completedTasks.length})',
                                              onTap: () {
                                                displayedList.clear();
                                                displayedList =
                                                    List.from(completedTasks);
                                                Navigator.of(context).pop();
                                                showingOverdue = false;
                                                showingUnAssignedTasks = false;
                                                filterName = 'COMPLETED';
                                              },
                                            ),
                                            Container(
                                              height: SizeSystem.size1,
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            CustomDialogAction(
                                              label:
                                                  'Overdue (${pastOpenTasks.length})',
                                              onTap: () {
                                                displayedList.clear();
                                                displayedList =
                                                    List.from(pastOpenTasks);
                                                Navigator.of(context).pop();
                                                showingOverdue = true;
                                                showingUnAssignedTasks = false;
                                                filterName = 'OVERDUE';
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                );
                                setState(() {});
                              },
                              child: SvgPicture.asset(
                                IconSystem.menu,
                                width: SizeSystem.size24,
                                color: ColorSystem.additionalGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: SizeSystem.size60,
                    ),
                    SvgPicture.asset(IconSystem.noTasks),
                  ],
                ),
              );
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.showGraphs)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Stack(
                              children: [
                                Center(
                                  child: CircularPercentIndicator(
                                    radius: 100 / 3,
                                    lineWidth: 9.0,
                                    percent: 1,
                                    center: SvgPicture.asset(
                                      IconSystem.sparkle,
                                      color: ColorSystem.skyBlue,
                                      width: SizeSystem.size24,
                                    ),
                                    backgroundColor: Colors.transparent,
                                    linearGradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: <Color>[
                                          ColorSystem.skyBlue.withOpacity(0.3),
                                          ColorSystem.skyBlue.withOpacity(0.3)
                                        ]),
                                    rotateLinearGradient: true,
                                    circularStrokeCap: CircularStrokeCap.round,
                                  ),
                                ),
                                Center(
                                  child: CircularPercentIndicator(
                                    radius: 100 / 3,
                                    lineWidth: 9.0,
                                    percent: percentCalculator(
                                        todaysTasks.length, allTasks.length),
                                    startAngle: 360,
                                    backgroundColor: Colors.transparent,
                                    linearGradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: <Color>[
                                          ColorSystem.skyBlue,
                                          ColorSystem.skyBlue
                                        ]),
                                    rotateLinearGradient: true,
                                    circularStrokeCap: CircularStrokeCap.round,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Today",
                              style: TextStyle(
                                fontSize: SizeSystem.size14,
                                fontFamily: kRubik,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            CircularPercentIndicator(
                              radius: 250 / 3,
                              lineWidth: 15.0,
                              percent: 0.70,
                              startAngle: 235,
                              backgroundColor: Colors.transparent,
                              center: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    SvgPicture.asset(
                                      IconSystem.taskIcon,
                                      height: SizeSystem.size40,
                                      width: SizeSystem.size20,
                                    ),
                                    const SizedBox(
                                      height: SizeSystem.size10,
                                    ),
                                    Text(
                                      '${(percentCalculator(todaysTasks.length, allTasks.length) * 100).toInt()}%',
                                      style: const TextStyle(
                                        fontSize: SizeSystem.size24,
                                        fontFamily: kRubik,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${completedTasks.length} / ${allTasks.length}',
                                      style: const TextStyle(
                                        fontSize: SizeSystem.size14,
                                        fontFamily: kRubik,
                                      ),
                                    ),
                                    const Text(
                                      'Completed',
                                      style: TextStyle(
                                        fontSize: SizeSystem.size14,
                                        fontFamily: kRubik,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              linearGradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                    ColorSystem.lavender3.withOpacity(0.3),
                                    ColorSystem.lavender3.withOpacity(0.3),
                                  ]),
                              rotateLinearGradient: true,
                              circularStrokeCap: CircularStrokeCap.round,
                            ),
                            CircularPercentIndicator(
                              radius: 250 / 3,
                              lineWidth: 15.0,
                              percent: percentCalculator(
                                  todaysTasks.length, allTasks.length),
                              startAngle: 235,
                              backgroundColor: Colors.transparent,
                              linearGradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                    ColorSystem.lavender3,
                                    ColorSystem.lavender3
                                  ]),
                              rotateLinearGradient: true,
                              circularStrokeCap: CircularStrokeCap.round,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            SvgPicture.asset(
                              IconSystem.placeHolderEmoji,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "C.Sat",
                              style: TextStyle(
                                fontSize: SizeSystem.size14,
                                fontFamily: kRubik,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 30,
                ),
                if (todaysTasks.isNotEmpty)
                  TaskAlertWidget(
                    tasks: todaysTasks,
                    onTap: () {
                      futureTasks = getTasks(myNewTask);
                    },
                  ),
                if (todaysTasks.isNotEmpty)
                  const SizedBox(
                    height: SizeSystem.size20,
                  ),
                if (isManager)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SizeSystem.size14),
                    child: CustomTabBarExtended(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SizeSystem.size16),
                      height: 48,
                      containerColor: Colors.grey.withOpacity(0.1),
                      containerBorderRadius: 10.0,
                      tabBorderRadius: 10.0,
                      tabOneName: 'Team',
                      tabTwoName: 'Task',
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
                      tabController: teamsTabController,
                      tabColor: Colors.white,
                      labelColor: Colors.black,
                      unSelectLabelColor: Colors.grey,
                      labelTextStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: kRubik,
                        fontSize: 16,
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (!isManager)
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: SizeSystem.size24),
                    padding: const EdgeInsets.symmetric(
                      horizontal: SizeSystem.size24,
                      vertical: SizeSystem.size30,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(SizeSystem.size20),
                      boxShadow: [
                        BoxShadow(
                          color: ColorSystem.blue1.withOpacity(0.15),
                          blurRadius: 12.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${showingAgentTasks ? widget.agentName.toUpperCase() : 'STORE $filterName'} TASKS',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: SizeSystem.size12,
                                    color: ColorSystem.lavender2,
                                  ),
                                ),
                                const SizedBox(
                                  height: SizeSystem.size10,
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: const TextStyle(
                                      fontFamily: kRubik,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '${allTasks.length}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: SizeSystem.size24,
                                          color: ColorSystem.primary,
                                        ),
                                      ),
                                      const WidgetSpan(
                                        child: SizedBox(
                                          width: SizeSystem.size5,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: 'Active Tasks',
                                        style: TextStyle(
                                          fontSize: SizeSystem.size12,
                                          color: ColorSystem.primary,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isManager)
                                  Badge(
                                    showBadge: showingAgentTasks,
                                    elevation: 6,
                                    badgeContent: Text(
                                      unAssignedTasksCount.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    child: InkWell(
                                      focusColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      onTap: () {
                                        if (showingAgentTasks) {
                                          futureTasks = getTasks(myNewTask);
                                        } else {
                                          futureTasks = getTasks(myNewStore);
                                        }
                                        showingAgentTasks = !showingAgentTasks;
                                        setState(() {});
                                      },
                                      child: SvgPicture.asset(
                                        showingAgentTasks
                                            ? IconSystem.storeTasks
                                            : IconSystem.agentTasks,
                                        width: SizeSystem.size36,
                                      ),
                                    ),
                                  ),
                                const SizedBox(
                                  width: SizeSystem.size20,
                                ),
                                InkWell(
                                  focusColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoAlertDialog(
                                          actions: [
                                            Column(
                                              children: [
                                                CustomDialogAction(
                                                  label:
                                                      'All (${allTasks.length})',
                                                  onTap: () {
                                                    displayedList.clear();
                                                    displayedList =
                                                        List.from(allTasks);
                                                    Navigator.of(context).pop();
                                                    showingOverdue = false;
                                                    showingUnAssignedTasks =
                                                        false;
                                                    filterName = 'ALL';
                                                  },
                                                ),
                                                Container(
                                                  height: SizeSystem.size1,
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                ),
                                                CustomDialogAction(
                                                  label:
                                                      'Today (${todaysTasks.length})',
                                                  onTap: () {
                                                    displayedList.clear();
                                                    displayedList =
                                                        List.from(todaysTasks);
                                                    Navigator.of(context).pop();
                                                    showingOverdue = false;
                                                    showingUnAssignedTasks =
                                                        false;
                                                    filterName = 'TODAYS';
                                                  },
                                                ),
                                                Container(
                                                  height: SizeSystem.size1,
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                ),
                                                if (!showingAgentTasks)
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      CustomDialogAction(
                                                        label:
                                                            'Unassigned (${unAssignedTasks.length})',
                                                        onTap: () {
                                                          displayedList.clear();
                                                          displayedList =
                                                              List.from(
                                                                  unAssignedTasks);
                                                          Navigator.of(context)
                                                              .pop();
                                                          showingOverdue =
                                                              false;
                                                          showingUnAssignedTasks =
                                                              true;
                                                          filterName =
                                                              'UNASSIGNED';
                                                        },
                                                      ),
                                                      Container(
                                                        height:
                                                            SizeSystem.size1,
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                      ),
                                                    ],
                                                  ),
                                                CustomDialogAction(
                                                  label:
                                                      'Completed (${completedTasks.length})',
                                                  onTap: () {
                                                    displayedList.clear();
                                                    displayedList = List.from(
                                                        completedTasks);
                                                    Navigator.of(context).pop();
                                                    showingOverdue = false;
                                                    showingUnAssignedTasks =
                                                        false;
                                                    filterName = 'COMPLETED';
                                                  },
                                                ),
                                                Container(
                                                  height: SizeSystem.size1,
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                ),
                                                CustomDialogAction(
                                                  label:
                                                      'Overdue (${pastOpenTasks.length})',
                                                  onTap: () {
                                                    displayedList.clear();
                                                    displayedList = List.from(
                                                        pastOpenTasks);
                                                    Navigator.of(context).pop();
                                                    showingOverdue = true;
                                                    showingUnAssignedTasks =
                                                        false;
                                                    filterName = 'OVERDUE';
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                    setState(() {});
                                  },
                                  child: SvgPicture.asset(
                                    IconSystem.funnel,
                                    width: SizeSystem.size24,
                                    color: ColorSystem.additionalGrey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: SizeSystem.size20,
                        ),
                        HorizontalMultipleProgressIndicator(
                            pendingValue:
                                (todaysTasks.length + futureOpenTasks.length) /
                                    allTasks.length,
                            overdueValue:
                                pastOpenTasks.length / allTasks.length,
                            unAssignedValue:
                                unAssignedTasks.length / allTasks.length),
                        const SizedBox(
                          height: SizeSystem.size30,
                        ),
                        ListView.separated(
                          itemCount: displayedList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return TaskListWidget(
                              onTap: () async {
                                await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                  return TaskDetailsScreen(
                                    taskId: displayedList[index].id!,
                                    email: displayedList[index].email,
                                    task: displayedList[index],
                                  );
                                }));
                                setState(() {
                                  futureTasks = getTasks(myNewTask);
                                });
                              },
                              task: displayedList[index],
                              taskId: displayedList[index].id!,
                              status: displayedList[index].status,
                              subject: displayedList[index].subject,
                              taskType: displayedList[index].taskType,
                              activityDate: displayedList[index].taskDate,
                              phone: displayedList[index].phone,
                              email: displayedList[index].email,
                              isOverdue: showingOverdue,
                              showingStoreTasks: !showingAgentTasks,
                              showingUnassignedTask: showingUnAssignedTasks,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              color: Colors.white,
                              child: Divider(
                                color: Colors.grey.withOpacity(0.2),
                                thickness: 1,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                if (isManager)
                  Center(
                    child: [
                      AgentTaskList(onTap: () {}, agentTaskList: teamTaskList),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: SizeSystem.size24),
                        padding: const EdgeInsets.symmetric(
                          horizontal: SizeSystem.size24,
                          vertical: SizeSystem.size30,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(SizeSystem.size20),
                          boxShadow: [
                            BoxShadow(
                              color: ColorSystem.blue1.withOpacity(0.15),
                              blurRadius: 12.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${showingAgentTasks ? widget.agentName.toUpperCase() : 'STORE $filterName'} TASKS',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: SizeSystem.size12,
                                        color: ColorSystem.lavender2,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: SizeSystem.size10,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(
                                          fontFamily: kRubik,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '${allTasks.length}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: SizeSystem.size24,
                                              color: ColorSystem.primary,
                                            ),
                                          ),
                                          const WidgetSpan(
                                            child: SizedBox(
                                              width: SizeSystem.size5,
                                            ),
                                          ),
                                          const TextSpan(
                                            text: 'Active Tasks',
                                            style: TextStyle(
                                              fontSize: SizeSystem.size12,
                                              color: ColorSystem.primary,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (isManager)
                                      Badge(
                                        showBadge: showingAgentTasks,
                                        elevation: 6,
                                        badgeContent: Text(
                                          unAssignedTasksCount.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        child: InkWell(
                                          focusColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          onTap: () {
                                            if (showingAgentTasks) {
                                              futureTasks =
                                                  getTasks(myNewStore);
                                            } else {
                                              futureTasks = getTasks(myNewTask);
                                            }
                                            showingAgentTasks =
                                                !showingAgentTasks;
                                            setState(() {});
                                          },
                                          child: SvgPicture.asset(
                                            showingAgentTasks
                                                ? IconSystem.storeTasks
                                                : IconSystem.agentTasks,
                                            width: SizeSystem.size36,
                                          ),
                                        ),
                                      ),
                                    const SizedBox(
                                      width: SizeSystem.size20,
                                    ),
                                    InkWell(
                                      focusColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      onTap: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CupertinoAlertDialog(
                                              actions: [
                                                Column(
                                                  children: [
                                                    CustomDialogAction(
                                                      label:
                                                          'All (${allTasks.length})',
                                                      onTap: () {
                                                        displayedList.clear();
                                                        displayedList =
                                                            List.from(allTasks);
                                                        Navigator.of(context)
                                                            .pop();
                                                        showingOverdue = false;
                                                        showingUnAssignedTasks =
                                                            false;
                                                        filterName = 'ALL';
                                                      },
                                                    ),
                                                    Container(
                                                      height: SizeSystem.size1,
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                    ),
                                                    CustomDialogAction(
                                                      label:
                                                          'Today (${todaysTasks.length})',
                                                      onTap: () {
                                                        displayedList.clear();
                                                        displayedList =
                                                            List.from(
                                                                todaysTasks);
                                                        Navigator.of(context)
                                                            .pop();
                                                        showingOverdue = false;
                                                        showingUnAssignedTasks =
                                                            false;
                                                        filterName = 'TODAY';
                                                      },
                                                    ),
                                                    Container(
                                                      height: SizeSystem.size1,
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                    ),
                                                    if (!showingAgentTasks)
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          CustomDialogAction(
                                                            label:
                                                                'Unassigned (${unAssignedTasks.length})',
                                                            onTap: () {
                                                              displayedList
                                                                  .clear();
                                                              displayedList =
                                                                  List.from(
                                                                      unAssignedTasks);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              showingOverdue =
                                                                  false;
                                                              showingUnAssignedTasks =
                                                                  true;
                                                              filterName =
                                                                  'UNASSIGNED';
                                                            },
                                                          ),
                                                          Container(
                                                            height: SizeSystem
                                                                .size1,
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.2),
                                                          ),
                                                        ],
                                                      ),
                                                    CustomDialogAction(
                                                      label:
                                                          'Completed (${completedTasks.length})',
                                                      onTap: () {
                                                        displayedList.clear();
                                                        displayedList =
                                                            List.from(
                                                                completedTasks);
                                                        Navigator.of(context)
                                                            .pop();
                                                        showingOverdue = false;
                                                        showingUnAssignedTasks =
                                                            false;
                                                        filterName =
                                                            'COMPLETED';
                                                      },
                                                    ),
                                                    Container(
                                                      height: SizeSystem.size1,
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                    ),
                                                    CustomDialogAction(
                                                      label:
                                                          'Overdue (${pastOpenTasks.length})',
                                                      onTap: () {
                                                        displayedList.clear();
                                                        displayedList =
                                                            List.from(
                                                                pastOpenTasks);
                                                        Navigator.of(context)
                                                            .pop();
                                                        showingOverdue = true;
                                                        showingUnAssignedTasks =
                                                            false;
                                                        filterName = 'OVERDUE';
                                                      },
                                                    ),
                                                  ],
                                                )
                                              ],
                                            );
                                          },
                                        );
                                        setState(() {});
                                      },
                                      child: SvgPicture.asset(
                                        IconSystem.funnel,
                                        width: SizeSystem.size24,
                                        color: ColorSystem.additionalGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: SizeSystem.size20,
                            ),
                            HorizontalMultipleProgressIndicator(
                                pendingValue: (todaysTasks.length +
                                        futureOpenTasks.length) /
                                    allTasks.length,
                                overdueValue:
                                    pastOpenTasks.length / allTasks.length,
                                unAssignedValue:
                                    unAssignedTasks.length / allTasks.length),
                            const SizedBox(
                              height: SizeSystem.size30,
                            ),
                            ListView.separated(
                              itemCount: displayedList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return TaskListWidget(
                                  onTap: () async {
                                    await Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return TaskDetailsScreen(
                                        taskId: displayedList[index].id!,
                                        email: displayedList[index].email,
                                        task: displayedList[index],
                                      );
                                    }));
                                    setState(() {
                                      futureTasks = getTasks(showingAgentTasks
                                          ? myNewTask
                                          : myNewStore);
                                    });
                                  },
                                  task: displayedList[index],
                                  taskId: displayedList[index].id!,
                                  status: displayedList[index].status,
                                  subject: displayedList[index].subject,
                                  taskType: displayedList[index].taskType,
                                  activityDate: displayedList[index].taskDate,
                                  phone: displayedList[index].phone,
                                  email: displayedList[index].email,
                                  isOverdue: showingOverdue,
                                  showingStoreTasks: !showingAgentTasks,
                                  showingUnassignedTask: showingUnAssignedTasks,
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Container(
                                  color: Colors.white,
                                  child: Divider(
                                    color: Colors.grey.withOpacity(0.2),
                                    thickness: 1,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ][teamsTabController.index],
                  ),
              ],
            );
        }
      },
    );
  }
}
