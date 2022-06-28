import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:salesforce_spo/design_system/primitives/color_system.dart';
import 'package:salesforce_spo/design_system/primitives/size_system.dart';
import 'package:salesforce_spo/models/agent.dart';
import 'package:salesforce_spo/utils/constants.dart';

import 'agent_task_tile.dart';

class AgentTaskList extends StatefulWidget {
  const AgentTaskList({Key? key, required this.agentTaskList})
      : super(key: key);
  final List<Agent> agentTaskList;

  @override
  State<AgentTaskList> createState() => _AgentTaskListState();
}

class _AgentTaskListState extends State<AgentTaskList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
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
                padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size24),
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
                            letterSpacing: 2
                          ),
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
                padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size24),
                itemBuilder: (context, index) {
                  return EmployeesTaskWidget(
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
        ),
      ],
    );
  }
}
