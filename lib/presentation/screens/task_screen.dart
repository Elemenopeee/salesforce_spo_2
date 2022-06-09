import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/common_widgets/linear_progress_indicator_widget.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/design_system/primitives/social_icon_system.dart';

import '../../common_widgets/task_list_widget.dart';
import '../../models/task_model.dart';
import '../../utils/constants.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    List<TaskModel> graceListData = [
      TaskModel(
        userName: "Brian Adam for",
        taskName: "Warranty Purchase",
        title: "Call Alert",
        subTitle: "Warranty Purchase",
        timeStatus: "Overdue",
        iconImage: SocialIconSystem.icPhone,
      ),
      TaskModel(
        userName: "Ankit Kumar",
        title: "Send Mail",
        subTitle: "Ready For Pickup",
        timeStatus: "Today",
        iconImage: SocialIconSystem.icMail,
      ),
      TaskModel(
        userName: "Kayla Harris",
        taskName: "Pickup Reminder",
        title: "Send SMS",
        subTitle: "12-Month Follow Up",
        timeStatus: "Tomorrow",
        iconImage: SocialIconSystem.icMessage,
      ),
      TaskModel(
        userName: "Vivek Harris",
        taskName: "Pickup Reminder",
        title: "Send SMS",
        subTitle: "12-Month Follow Up",
        timeStatus: "JUL 03, 2022",
        iconImage: SocialIconSystem.icChat,
      ),
    ];
    return Scaffold(
      backgroundColor: ColorSystem.secondary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              left: SizeSystem.size30,
              right: SizeSystem.size30,
              top: SizeSystem.size20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeSystem.size16),
              color: ColorSystem.white,
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: SizeSystem.size20, vertical: SizeSystem.size20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "GRACE'S TASKS",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: SizeSystem.size12,
                              color: ColorSystem.lavender2,
                            ),
                          ),
                          const SizedBox(
                            height: SizeSystem.size10,
                          ),
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontFamily: kRubik,
                              ),
                              children: [
                                TextSpan(
                                  text: '3',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: SizeSystem.size24,
                                    color: ColorSystem.primary,
                                  ),
                                ),
                                WidgetSpan(
                                    child: SizedBox(
                                  width: SizeSystem.size5,
                                )),
                                TextSpan(
                                  text: 'Pending / 10 Task',
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
                      const Icon(
                        Icons.more_horiz_outlined,
                        color: ColorSystem.additionalGrey,
                        size: SizeSystem.size30,
                      ),
                    ],
                  ),
                  const LinearProgressIndicatorWidget(
                    containerWidth: SizeSystem.size320,
                    containerHeight: SizeSystem.size8,
                    containerMargin: EdgeInsets.only(top: SizeSystem.size20),
                    containerRadius: BorderRadius.all(
                      Radius.circular(SizeSystem.size20),
                    ),
                    indicatorValue: 0.7,
                    indicatorValueColor: ColorSystem.lavender3,
                    indicatorBackgroundColor: ColorSystem.greyBg,
                  ),
                  const SizedBox(
                    height: SizeSystem.size30,
                  ),
                  ListView.separated(
                    itemCount: graceListData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var item = graceListData[index];
                      return TaskListWidget(
                        userName: item.userName,
                        title: item.title,
                        taskName: item.taskName,
                        subTitle: item.subTitle,
                        timeStatus: item.timeStatus,
                        iconImage: item.iconImage,
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
          ),
        ),
      ),
    );
  }
}
