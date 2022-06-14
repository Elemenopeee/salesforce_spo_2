import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:salesforce_spo/common_widgets/custom_linear_progress_indicator.dart';
import 'package:salesforce_spo/common_widgets/task_alert_widget.dart';
import 'package:salesforce_spo/common_widgets/task_list_widget.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/models/task.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';
import 'package:salesforce_spo/services/networking/request_body.dart';

import '../../utils/constants.dart';

class TasksWidget extends StatefulWidget {
  final String agentName;

  const TasksWidget({
    Key? key,
    required this.agentName,
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

  String tabName = 'MyNewTask';
  String id = '0056C000003WsJVQA0';

  Future<void> getTasks() async {
    var response = await HttpService().doPost(
        path: Endpoints.getSmartTriggers(),
        body: jsonEncode(RequestBody.getSmartTriggersBody(tabName, id)));

    if (response.data != null) {
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
  }

  @override
  initState() {
    super.initState();
    futureTasks = getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureTasks,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator(
                color: ColorSystem.primary,
              ),
            );
          case ConnectionState.done:
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (todaysTasks.isNotEmpty)
                  TaskAlertWidget(
                    tasks: todaysTasks,
                  ),
                if (todaysTasks.isNotEmpty)
                  const SizedBox(
                    height: SizeSystem.size20,
                  ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: SizeSystem.size24),
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
                        // offset: const Offset(
                        //   0.0,
                        //   8.0,
                        // ),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${widget.agentName.toUpperCase()} TASKS',
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
                              text: '${allTasks.length - completedTasks.length}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: SizeSystem.size24,
                                color: ColorSystem.primary,
                              ),
                            ),
                            const WidgetSpan(
                                child: SizedBox(
                                  width: SizeSystem.size5,
                                )),
                            TextSpan(
                              text: 'Pending / ${allTasks.length} Tasks',
                              style: const TextStyle(
                                fontSize: SizeSystem.size12,
                                color: ColorSystem.primary,
                              ),
                            )
                          ],
                        ),
                      ),
                      CustomLinearProgressIndicator(
                        containerHeight: SizeSystem.size8,
                        containerMargin: const EdgeInsets.only(top: SizeSystem.size20),
                        containerRadius: const BorderRadius.all(
                          Radius.circular(SizeSystem.size20),
                        ),
                        indicatorValue: completedTasks.length / allTasks.length,
                        indicatorValueColor: ColorSystem.lavender3,
                        indicatorBackgroundColor: ColorSystem.additionalGrey,
                      ),
                      const SizedBox(
                        height: SizeSystem.size30,
                      ),
                      ListView.separated(
                        itemCount: allTasks.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return TaskListWidget(
                            status: allTasks[index].status,
                            subject: allTasks[index].subject,
                            taskType: allTasks[index].taskType,
                            activityDate: allTasks[index].taskDate,
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
