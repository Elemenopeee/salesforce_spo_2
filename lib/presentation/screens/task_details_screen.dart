import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/common_widgets/comment_widget.dart';
import 'package:salesforce_spo/common_widgets/product_list_card_widget.dart';
import 'package:salesforce_spo/common_widgets/task_client_profile_widget.dart';
import 'package:salesforce_spo/common_widgets/task_details_date_widget.dart';
import 'package:salesforce_spo/common_widgets/tgc_app_bar.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/models/order.dart';
import 'package:salesforce_spo/models/order_item.dart';
import 'package:salesforce_spo/models/task.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/networking/request_body.dart';
import '../../utils/constants.dart';

class TaskDetailsScreen extends StatefulWidget {
  final String taskId;
  final String? email;
  final TaskModel task;

  const TaskDetailsScreen({
    Key? key,
    required this.taskId,
    required this.task,
    this.email,
  }) : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late Future<void> futureTaskDetails;

  String taskStatus = 'Open';

  List<Order> orders = [];

  Future<void> getTaskDetails() async {
    var response = await HttpService()
        .doGet(path: Endpoints.getTaskDetails(widget.taskId));

    try {
      if (response.data != null) {
        for (var orderJson in response.data['Orders']) {
          var orderLines = <OrderItem>[];

          try {
            for (var orderLine in orderJson['OrderLines']) {
              var orderLineItem = OrderItem.fromTaskOrderLineJson(orderLine);
              orderLines.add(orderLineItem);
            }
          } on Exception catch (e) {
            print(e);
          }

          try {
            var order = Order.fromOrderInfoJson(orderJson);
            order.orderLines = List.from(orderLines);
            orders.add(order);
          } on Exception catch (e) {
            print(e);
          }
        }
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> markTaskAsCompleted() async {
    var response = await HttpService().doPost(
      path: Endpoints.postTaskDetails(widget.task.id!),
      body: jsonEncode(
        RequestBody.getUpdateTaskBody(
          recordId: widget.task.id!,
          status: 'Completed',
        ),
      ),
    );
  }

  @override
  initState() {
    super.initState();
    taskStatus = widget.task.status ?? 'Open';
    futureTaskDetails = getTaskDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.scaffoldBackgroundColor,
      appBar: TGCAppBar(
        label: 'CALL ALERT',
        trailingActions: [
          if(taskStatus != 'Completed')
          InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () async {
              if (widget.task.phone != null) {
                var phone = widget.task.phone;
                await launchUrl(Uri.parse('tel://$phone'));
              }
            },
            child: SvgPicture.asset(
              IconSystem.phone,
              height: 24,
              width: 24,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            width: SizeSystem.size16,
          ),
        ],
        leadingWidget: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              IconSystem.leftArrow,
              color: ColorSystem.primary,
              height: SizeSystem.size12,
              width: SizeSystem.size24,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: futureTaskDetails,
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
              return ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  if (taskStatus == 'Completed')
                    Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: SizeSystem.size4,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: SizeSystem.size8,
                          vertical: SizeSystem.size4,
                        ),
                        decoration: BoxDecoration(
                          color: ColorSystem.additionalGreen.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(SizeSystem.size4),
                        ),
                        child: Text(
                          taskStatus,
                          style: const TextStyle(
                            color: ColorSystem.additionalGreen,
                            fontFamily: kRubik,
                            fontSize: SizeSystem.size12,
                          ),
                        ),
                      ),
                    ),
                  ProfileWidget(
                      name: widget.task.contactName ?? '--',
                      number: widget.task.phone ?? '--',
                      email: widget.task.email ?? '--'),
                  const SizedBox(
                    height: SizeSystem.size20,
                  ),
                  ListView.separated(
                    itemCount: orders.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return ProductListCard(
                        order: orders[index],
                        Id: orders[index].orderNumber ?? '--',
                        Date: orders[index].createdDate ?? '--',
                        taskType: orders[index].taskType,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                  ),
                  TaskDetailsDateWidget(
                    task: widget.task,
                    assigned_to_name: widget.task.assignedTo ?? '--',
                    modified_by_name: widget.task.modifiedBy ?? '--',
                    due_by_date: widget.task.taskDate ?? '--',
                    modified_date: widget.task.lastModifiedDate ?? '--',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AddComment(
                    task: widget.task,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (taskStatus != 'Completed')
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorSystem.lavender3),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ))),
                                onPressed: () {},
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: Text(
                                    '+',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              ColorSystem.primary),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ))),
                                  onPressed: () async {
                                    await markTaskAsCompleted();
                                    widget.task.status = 'Completed';
                                    setState((){
                                      taskStatus = 'Completed';
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: const [
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 22),
                                        child: Text(
                                          'Mark as complete',
                                          style: TextStyle(
                                              fontSize: 16, fontFamily: kRubik),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
