import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/presentation/screens/task_details_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../design_system/design_system.dart';
import '../models/task.dart';
import '../utils/constants.dart';

class TaskAlertWidget extends StatefulWidget {
  final List<TaskModel> tasks;

  const TaskAlertWidget({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  @override
  State<TaskAlertWidget> createState() => _TaskAlertWidgetState();
}

class _TaskAlertWidgetState extends State<TaskAlertWidget> {
  final controller = PageController(viewportFraction: 1.0, keepPage: true);

  DateTime getDateTime(String date) {
    return DateTime.parse(date);
  }

  String getMonth(DateTime dateTime) {
    return DateFormat('MMM').format(dateTime);
  }

  String getDate(DateTime dateTime) {
    return DateFormat('dd').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 120,
          child: PageView.builder(
            controller: controller,
            itemCount: widget.tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    margin: const EdgeInsets.only(top: 10.0, bottom: 0),
                    decoration: BoxDecoration(),
                    child: Column(children: [
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(0xFFF1F4F9),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 14),
                              decoration: BoxDecoration(
                                  color: Color(0xffFF9B90),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      getMonth(getDateTime(
                                          DateTime.now().toString())),
                                      style: const TextStyle(
                                          fontSize: SizeSystem.size14,
                                          fontFamily: kRubik,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      getDate(getDateTime(
                                          DateTime.now().toString())),
                                      style: const TextStyle(
                                          fontSize: SizeSystem.size20,
                                          fontFamily: kRubik,
                                          color: Colors.white),
                                    )
                                  ]),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.tasks[index].subject ?? '--',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Color(0xff2D3142),
                                        fontSize: SizeSystem.size14,
                                        fontFamily: kRubik,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: SizeSystem.size6,
                                    ),
                                    Text(
                                      widget.tasks[index].taskType ?? '--',
                                      style: const TextStyle(
                                        color: Color(0xff2D3142),
                                        fontSize: SizeSystem.size14,
                                        fontFamily: kRubik,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: SizeSystem.size6,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return TaskDetailsScreen(
                                              task: widget.tasks[index],
                                              taskId:
                                                  widget.tasks[index].id ?? '',
                                            email: widget.tasks[index].email,
                                          );
                                        }));
                                      },
                                      child: const Text(
                                        'View Task',
                                        style: TextStyle(
                                            color: Color(0xff8C80F8),
                                            fontSize: SizeSystem.size16,
                                            height: 1.4,
                                            fontFamily: kRubik,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(right: 40, top: 0.0),
                      padding: const EdgeInsets.symmetric(
                        vertical: 3,
                        horizontal: 22,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xffB5AFF9).withOpacity(0.3),
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                            offset: const Offset(
                              0.0,
                              8.0,
                            ),
                          )
                        ],
                      ),
                      // ignore: prefer_const_constructors
                      child: Text(
                        'TODAY',
                        style: const TextStyle(
                          color: Color(0xff2D3142),
                          fontSize: SizeSystem.size12,
                          fontFamily: kRubik,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 30,
                    bottom: 0,
                    child: Container(
                      //color: Colors.red.withOpacity(0.2),
                      child: Image.asset(
                        IconSystem.agentTaskAlertIllustration,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        if (widget.tasks.isNotEmpty)
          SmoothPageIndicator(
            controller: controller,
            count: widget.tasks.length,
            effect: const ExpandingDotsEffect(
              activeDotColor: Color(0xFFB5AFF9),
              dotColor: Color(0xFFD6D9E0),
              dotHeight: 6,
              dotWidth: 6,
              // strokeWidth: 5,
            ),
          ),
      ],
    );
  }
}
