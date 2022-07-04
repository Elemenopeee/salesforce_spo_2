import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../design_system/design_system.dart';
import '../utils/constants.dart';
import 'custom_dialog_action.dart';

class TaskMetricsWidget extends StatelessWidget {
  final int allTasks;
  final int? unAssignedTasks;
  final int? pastOpenTasks;
  final int? pendingTasks;
  final int? completedTasks;
  final int? futureTasks;
  final bool isManager;

  const TaskMetricsWidget({
    Key? key,
    required this.pastOpenTasks,
    required this.unAssignedTasks,
    required this.allTasks,
    required this.pendingTasks,
    required this.completedTasks,
    required this.isManager,
    this.futureTasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        showDialog(
            context: context,
            builder: (BuildContext context) {
          return CupertinoAlertDialog(
            actions: [
              Material(
                child: Column(
                  children: [
                    CustomDialogAction(
                      label: 'Upcoming (${futureTasks?.toString() ?? 0})',
                      onTap: (){},
                    ),
                    Container(
                      height:
                      SizeSystem.size1,
                      color: Colors.grey
                          .withOpacity(0.2),
                    ),
                    CustomDialogAction(
                      label: 'Overdue (${pastOpenTasks?.toString() ?? 0})',
                      onTap: () {},
                    ),
                    Container(
                      height:
                      SizeSystem.size1,
                      color: Colors.grey
                          .withOpacity(0.2),
                    ),
                    CustomDialogAction(
                      label: 'All (${allTasks.toString()})',
                      onTap: () {},
                    ),
                    Container(
                      height:
                      SizeSystem.size1,
                      color: Colors.grey
                          .withOpacity(0.2),
                    ),
                    CustomDialogAction(
                      label: 'Today (${pendingTasks?.toString() ?? 0})',
                      onTap: () {},
                    ),
                    Container(
                      height:
                      SizeSystem.size1,
                      color: Colors.grey
                          .withOpacity(0.2),
                    ),
                    CustomDialogAction(
                      label: 'Completed (${completedTasks?.toString() ?? 0})',
                      onTap: () {},
                    ),
                    Container(
                      height:
                      SizeSystem.size1,
                      color: Colors.grey
                          .withOpacity(0.2),
                    ),
                    CustomDialogAction(
                      label: 'Unassigned (${unAssignedTasks?.toString() ?? 0})',
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          );
        },
        );
      },
      child: Container(
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
                Text(
                  '${isManager ? 'STORE' : 'MY'} TASKS',
                  style: const TextStyle(
                    letterSpacing: 1.5,
                    color: ColorSystem.primary,
                    fontSize: SizeSystem.size14,
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
                    unAssignedTasks: unAssignedTasks?.toDouble() ?? 0,
                    pendingTasks: pendingTasks?.toDouble() ?? 0,
                    completedTasks: completedTasks?.toDouble() ?? 0,
                    overdueTasks: pastOpenTasks?.toDouble() ?? 0,
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
                if(pendingTasks != null)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pendingTasks.toString(),
                      style: const TextStyle(
                        color: ColorSystem.purple,
                        fontSize: SizeSystem.size24,
                        fontFamily: kRubik,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: SizeSystem.size4,
                    ),
                    const Text(
                      'P',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        fontSize: SizeSystem.size12,
                        fontFamily: kRubik,
                      ),
                    ),
                  ],
                ),
                if(pastOpenTasks != null)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pastOpenTasks.toString(),
                        style: const TextStyle(
                          color: ColorSystem.peach,
                          fontSize: SizeSystem.size24,
                          fontFamily: kRubik,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: SizeSystem.size4,
                      ),
                      const Text(
                        'O',
                        style: TextStyle(
                          color: ColorSystem.primary,
                          fontSize: SizeSystem.size12,
                          fontFamily: kRubik,
                        ),
                      ),
                    ],
                  ),
                if(unAssignedTasks != null && isManager)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      unAssignedTasks.toString(),
                      style: const TextStyle(
                        color: ColorSystem.complimentary,
                        fontSize: SizeSystem.size24,
                        fontFamily: kRubik,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: SizeSystem.size4,
                    ),
                    const Text(
                      'U',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        fontSize: SizeSystem.size12,
                        fontFamily: kRubik,
                      ),
                    ),
                  ],
                ),
                if(completedTasks != null)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        completedTasks.toString(),
                        style: const TextStyle(
                          color: Color(0xFF7FE3F0),
                          fontSize: SizeSystem.size24,
                          fontFamily: kRubik,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: SizeSystem.size4,
                      ),
                      const Text(
                        'C',
                        style: TextStyle(
                          color: Color(0xFF7FE3F0),
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
      ),
    );
  }
}

List<PieChartSectionData> showingSections({
  required double pendingTasks,
  required double completedTasks,
  required double unAssignedTasks,
  required double overdueTasks,
}) {
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
          value: pendingTasks,
          radius: radius,
          titleStyle: const TextStyle(
            fontSize: fontSize,
          ),
        );
      case 2:
        return PieChartSectionData(
          color: ColorSystem.peach,
          value: overdueTasks,
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
