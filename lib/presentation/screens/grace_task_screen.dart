import 'package:flutter/material.dart';
import 'package:salesforce_spo/design_system/design_system.dart';

import '../../common_widgets/grace_task_list_widget.dart';
import '../../models/grace_task_model.dart';
import '../../utils/constants.dart';

class GraceTaskScreen extends StatefulWidget {
  const GraceTaskScreen({Key? key}) : super(key: key);

  @override
  State<GraceTaskScreen> createState() => _GraceTaskScreenState();
}

class _GraceTaskScreenState extends State<GraceTaskScreen> {
  @override
  Widget build(BuildContext context) {
    List<GraceTaskModel> graceListData = [
      GraceTaskModel(
        userName: "Brian Adam for",
        taskName: "Warranty Purchase",
        title: "Call Alert",
        subTitle: "Warranty Purchase",
        timeStatus: "Overdue",
      ),
      GraceTaskModel(
          userName: "Ankit Kumar",
          title: "Send Mail",
          subTitle: "Ready For Pickup",
          timeStatus: "Today"),
      GraceTaskModel(
        userName: "Kayla Harris",
        taskName: "Pickup Reminder",
        title: "Send SMS",
        subTitle: "12-Month Follow Up",
        timeStatus: "Tomorrow",
      ),
      GraceTaskModel(
        userName: "Vivek Harris",
        taskName: "Pickup Reminder",
        title: "Send SMS",
        subTitle: "12-Month Follow Up",
        timeStatus: "JUL 03, 2022",
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
              borderRadius: BorderRadius.circular(SizeSystem.size15),
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
                          Container(
                            margin:
                                const EdgeInsets.only(top: SizeSystem.size20),
                            width: 281,
                            height: SizeSystem.size8,
                            child: const ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(SizeSystem.size10)),
                              child: LinearProgressIndicator(
                                value: 0.7,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    ColorSystem.lavender3),
                                backgroundColor: ColorSystem.greyBg,
                              ),
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
                  const SizedBox(
                    height: SizeSystem.size30,
                  ),
                  ListView.separated(
                    itemCount: graceListData.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var item = graceListData[index];
                      return GraceTaskListWidget(
                        userName: item.userName,
                        title: item.title,
                        taskName: item.taskName,
                        subTitle: item.subTitle,
                        timeStatus: item.timeStatus,
                        iconImage: Icons.whatsapp,
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
