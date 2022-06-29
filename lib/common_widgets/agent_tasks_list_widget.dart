import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/common_widgets/task_list_widget.dart';
import 'package:salesforce_spo/design_system/primitives/color_system.dart';
import 'package:salesforce_spo/design_system/primitives/size_system.dart';
import 'package:salesforce_spo/models/agent.dart';
import 'package:salesforce_spo/utils/constants.dart';

import '../design_system/design_system.dart';
import '../models/task.dart';
import '../presentation/intermediate_widgets/tasks_widget.dart';
import '../presentation/screens/task_details_screen.dart';
import 'agent_task_count_tile.dart';
import 'custom_dialog_action.dart';
import 'custom_linear_progress_indicator.dart';

class AgentTaskList extends StatefulWidget {
  const AgentTaskList(
      {Key? key, required this.onTap, required this.agentTaskList})
      : super(key: key);
  final List<Agent> agentTaskList;
  final VoidCallback onTap;

  @override
  State<AgentTaskList> createState() => _AgentTaskListState();
}

class _AgentTaskListState extends State<AgentTaskList> {
  bool managerViewingTeamTasks = true;

  int managerViewIndex = 0;

  List<TaskModel> displayedList = [];

  bool showingOverdue = false;

  @override
  Widget build(BuildContext context) {
    if (managerViewingTeamTasks) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: SizeSystem.size24),
        padding: const EdgeInsets.symmetric(
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeSystem.size24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'EMPLOYEE\'S TASKS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeSystem.size14,
                            color: ColorSystem.lavender2,
                            fontFamily: kRubik,
                            letterSpacing: 2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              height: 30,
            ),
            ListView.separated(
              itemCount: widget.agentTaskList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeSystem.size24),
              itemBuilder: (context, index) {
                return AgentTaskCountTile(
                  onTap: () {
                    setState(() {
                      managerViewIndex = index;
                      managerViewingTeamTasks = false;
                      displayedList.clear();
                      displayedList = List.from(widget.agentTaskList[index].allTasks);
                    });
                  },
                  employeeName: widget.agentTaskList[index].name,
                  overdueTaskCount:
                      widget.agentTaskList[index].pastOpenTasks.length,
                  pendingTaskCount:
                      (widget.agentTaskList[index].todayTasks.length +
                          widget.agentTaskList[index].pastOpenTasks.length),
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
      );
    } else {
      var tempAgent = widget.agentTaskList[managerViewIndex];

      return Container(
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
                    InkWell(
                      onTap: () {
                        setState(() {
                          managerViewingTeamTasks = true;
                        });
                      },
                      focusColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            CupertinoIcons.chevron_back,
                            size: SizeSystem.size16,
                            color: ColorSystem.lavender2,
                          ),
                          const SizedBox(
                            width: SizeSystem.size4,
                          ),
                          Text(
                            '${tempAgent.name != null ? tempAgent.name!.toUpperCase() : '--'}\'S TASKS',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: SizeSystem.size12,
                              color: ColorSystem.lavender2,
                            ),
                          ),
                        ],
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
                                '${tempAgent.allTasks.length - tempAgent.completedTasks.length}',
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
                                'Pending / ${tempAgent.allTasks.length} Tasks',
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
                                  'Upcoming (${tempAgent.futureTasks
                                      .length})',
                                  onTap: () {
                                    displayedList.clear();
                                    displayedList =
                                        List.from(
                                            tempAgent.futureTasks);
                                    Navigator.of(context)
                                        .pop();
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
                                  'Overdue (${tempAgent.pastOpenTasks
                                      .length})',
                                  onTap: () {
                                    displayedList.clear();
                                    displayedList =
                                        List.from(
                                            tempAgent.pastOpenTasks);
                                    Navigator.of(context)
                                        .pop();
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
                                  'All (${tempAgent.allTasks
                                      .length})',
                                  onTap: () {
                                    displayedList.clear();
                                    displayedList =
                                        List.from(tempAgent.allTasks);
                                    Navigator.of(context)
                                        .pop();
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
                                  'Today (${tempAgent.todayTasks
                                      .length})',
                                  onTap: () {
                                    displayedList.clear();
                                    displayedList =
                                        List.from(
                                            tempAgent.todayTasks);
                                    Navigator.of(context)
                                        .pop();
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
                                  'Completed (${tempAgent.completedTasks
                                      .length})',
                                  onTap: () {
                                    displayedList.clear();
                                    displayedList =
                                        List.from(
                                            tempAgent.completedTasks);
                                    Navigator.of(context)
                                        .pop();
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
                    IconSystem.funnel,
                    width: SizeSystem.size24,
                    color: ColorSystem.additionalGrey,
                  ),
                ),
              ],
            ),
            CustomLinearProgressIndicator(
              containerHeight: SizeSystem.size8,
              containerMargin: const EdgeInsets.only(top: SizeSystem.size20),
              containerRadius: const BorderRadius.all(
                Radius.circular(SizeSystem.size20),
              ),
              indicatorValue: tempAgent.allTasks.isNotEmpty
                  ? tempAgent.completedTasks.length / tempAgent.allTasks.length
                  : 0,
              indicatorValueColor: ColorSystem.skyBlue,
              indicatorBackgroundColor: ColorSystem.lavender3,
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
                  onTap: () async {
                    await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) {
                              return TaskDetailsScreen(
                                taskId: displayedList[index]
                                    .id!,
                                email: displayedList[index]
                                    .email,
                                task: displayedList[index],
                              );
                            }));
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
      );
    }
  }
}
