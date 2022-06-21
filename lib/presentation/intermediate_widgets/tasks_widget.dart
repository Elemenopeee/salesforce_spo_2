import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:salesforce_spo/common_widgets/custom_linear_progress_indicator.dart';
import 'package:salesforce_spo/common_widgets/task_alert_widget.dart';
import 'package:salesforce_spo/common_widgets/task_list_widget.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/models/agent.dart';
import 'package:salesforce_spo/models/task.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';
import 'package:salesforce_spo/services/networking/request_body.dart';
import 'package:salesforce_spo/services/storage/shared_preferences_service.dart';

import '../../utils/constants.dart';

class TasksWidget extends StatefulWidget {
  final String agentName;
  final bool showGraphs;

  const TasksWidget({
    Key? key,
    required this.agentName,
    this.showGraphs = false,
  }) : super(key: key);

  @override
  State<TasksWidget> createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  late Future<void> futureTasks;

  List<TaskModel> todaysTasks = [],
      pastOpenTasks = [],
      futureOpenTasks = [],
      completedTasks = [],
      unAssignedTasks = [],
      allTasks = [];

  List<TaskModel> displayedList = [];

  bool isManager = false;
  bool showingAgentTasks = true;
  bool showingOverdue = false;

  String agentTasks = 'MyNewTask';
  String storeTasks = 'MyNewStore';
  String id = '';

  Agent? agent;

  Future<void> getUser() async {
    var email = await SharedPreferenceService().getValue(agentEmail);

    if(email != null){
      var response = await HttpService().doGet(path: Endpoints.getUserInformation(email));

      if(response.data != null){
        agent = Agent.fromJson(response.data['records'][0]);
      }
    }

    if(agent != null){
      if(agent!.id != null){
        id = agent!.id!;
      }
      if(agent!.storeId != null){
        SharedPreferenceService().setKey(key: 'store_id', value: agent!.storeId!);
      }
    }
  }

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

    await getUser();

    var response = await HttpService().doPost(
        path: Endpoints.getSmartTriggers(),
        body: jsonEncode(RequestBody.getSmartTriggersBody(tabName, id)),
        tokenRequired: true);

    if (response.data != null) {
      if (response.data['IsManager'] != null) {
        isManager = response.data['IsManager'];
      }

      try {
        for (var task in response.data['TodayTasks']) {
          todaysTasks.add(TaskModel.fromJson(task));
        }
        for (var task in response.data['PastOpenTasks']) {
          pastOpenTasks.add(TaskModel.fromJson(task));
        }
        for (var task in response.data['FutureTasks']) {
          futureOpenTasks.add(TaskModel.fromJson(task));
        }
        for (var task in response.data['CompletedTasks']) {
          completedTasks.add(TaskModel.fromJson(task));
        }
        for (var task in response.data['AllUnassignedTasks']) {
          unAssignedTasks.add(TaskModel.fromJson(task));
        }
        for (var task in response.data['AllTasks']) {
          allTasks.add(TaskModel.fromJson(task));
        }
      } catch (e) {
        print(e);
      }
    }

    displayedList.clear();
    displayedList = List.from(allTasks);
  }

  double percentCalculator(int completedTasks, int allTasks) {
    if (completedTasks == allTasks) {
      return 0.7;
    } else if (completedTasks == 0) {
      return 0;
    } else {
      if (allTasks == 0) {
        return 0;
      }
      return 0.7 * completedTasks / allTasks;
    }
  }

  @override
  initState() {
    super.initState();
    futureTasks = getTasks(agentTasks);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureTasks,
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
                              '${showingAgentTasks ? widget.agentName.toUpperCase() : 'STORE'} TASKS',
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
                                    futureTasks = getTasks(storeTasks);
                                  } else {
                                    futureTasks = getTasks(agentTasks);
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
                                              label:
                                                  'Upcoming (${futureOpenTasks.length})',
                                              onTap: () {
                                                displayedList.clear();
                                                displayedList =
                                                    List.from(futureOpenTasks);
                                                Navigator.of(context).pop();
                                                showingOverdue = false;
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
                                              },
                                            ),
                                            Container(
                                              height: SizeSystem.size1,
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            CustomDialogAction(
                                              label: 'All (${allTasks.length})',
                                              onTap: () {
                                                displayedList.clear();
                                                displayedList =
                                                    List.from(allTasks);
                                                Navigator.of(context).pop();
                                                showingOverdue = false;
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
                                              },
                                            ),
                                            Container(
                                              height: SizeSystem.size1,
                                              color:
                                                  Colors.grey.withOpacity(0.2),
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
                                              },
                                            ),
                                            if(!showingAgentTasks)
                                            Container(
                                              height: SizeSystem.size1,
                                              color:
                                              Colors.grey.withOpacity(0.2),
                                            ),
                                            if(!showingAgentTasks)
                                            CustomDialogAction(
                                              label:
                                              'Unassigned (${unAssignedTasks.length})',
                                              onTap: () {
                                                displayedList.clear();
                                                displayedList =
                                                    List.from(unAssignedTasks);
                                                Navigator.of(context).pop();
                                                showingOverdue = false;
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
                                        completedTasks.length, todaysTasks.length),
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
                                      '${(percentCalculator(completedTasks.length, allTasks.length) * 100).toInt()}%',
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
                                  completedTasks.length, allTasks.length),
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
                  ),
                if (todaysTasks.isNotEmpty)
                  const SizedBox(
                    height: SizeSystem.size20,
                  ),
                Container(
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
                                '${showingAgentTasks ? widget.agentName.toUpperCase() : 'STORE'} TASKS',
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
                                      text:
                                          '${allTasks.length - completedTasks.length}',
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
                                    TextSpan(
                                      text:
                                          'Pending / ${allTasks.length} Tasks',
                                      style: const TextStyle(
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
                                InkWell(
                                  focusColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  onTap: () {
                                    if (showingAgentTasks) {
                                      futureTasks = getTasks(storeTasks);
                                    } else {
                                      futureTasks = getTasks(agentTasks);
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
                                                    'Upcoming (${futureOpenTasks.length})',
                                                onTap: () {
                                                  displayedList.clear();
                                                  displayedList = List.from(
                                                      futureOpenTasks);
                                                  Navigator.of(context).pop();
                                                  showingOverdue = false;
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
                                                      List.from(pastOpenTasks);
                                                  Navigator.of(context).pop();
                                                  showingOverdue = true;
                                                },
                                              ),
                                              Container(
                                                height: SizeSystem.size1,
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                              ),
                                              CustomDialogAction(
                                                label:
                                                    'All (${allTasks.length})',
                                                onTap: () {
                                                  displayedList.clear();
                                                  displayedList =
                                                      List.from(allTasks);
                                                  Navigator.of(context).pop();
                                                  showingOverdue = false;
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
                                                },
                                              ),
                                              Container(
                                                height: SizeSystem.size1,
                                                color: Colors.grey
                                                    .withOpacity(0.2),
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
                                                },
                                              ),
                                              if(!showingAgentTasks)
                                              Container(
                                                height: SizeSystem.size1,
                                                color:
                                                Colors.grey.withOpacity(0.2),
                                              ),
                                              if(!showingAgentTasks)
                                              CustomDialogAction(
                                                label:
                                                'Unassigned (${unAssignedTasks.length})',
                                                onTap: () {
                                                  displayedList.clear();
                                                  displayedList =
                                                      List.from(unAssignedTasks);
                                                  Navigator.of(context).pop();
                                                  showingOverdue = false;
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
                      CustomLinearProgressIndicator(
                        containerHeight: SizeSystem.size8,
                        containerMargin:
                            const EdgeInsets.only(top: SizeSystem.size20),
                        containerRadius: const BorderRadius.all(
                          Radius.circular(SizeSystem.size20),
                        ),
                        indicatorValue: allTasks.isNotEmpty
                            ? completedTasks.length / allTasks.length
                            : 0,
                        indicatorValueColor: ColorSystem.lavender3,
                        indicatorBackgroundColor: ColorSystem.additionalGrey,
                      ),
                      const SizedBox(
                        height: SizeSystem.size30,
                      ),
                      ListView.separated(
                        itemCount: displayedList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TaskListWidget(
                            task: displayedList[index],
                            taskId: displayedList[index].id!,
                            status: displayedList[index].status,
                            subject: displayedList[index].subject,
                            taskType: displayedList[index].taskType,
                            activityDate: displayedList[index].taskDate,
                            phone: displayedList[index].phone,
                            email: displayedList[index].email,
                            isOverdue: showingOverdue,
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
              ],
            );
        }
      },
    );
  }
}

class CustomDialogAction extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const CustomDialogAction({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(PaddingSystem.padding12),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: SizeSystem.size16,
            fontFamily: kRubik,
          ),
        ),
      ),
    );
  }
}
