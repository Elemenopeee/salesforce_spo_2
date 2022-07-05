import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/common_widgets/comment_widget.dart';
import 'package:salesforce_spo/common_widgets/create_task_comment_widget.dart';
import 'package:salesforce_spo/common_widgets/create_task_date_widget.dart';
import 'package:salesforce_spo/common_widgets/subject_widget.dart';
import 'package:salesforce_spo/models/task.dart';
import '../../common_widgets/task_details_date_widget.dart';
import '../../design_system/design_system.dart';
import '../../models/order.dart';
import '../../models/order_item.dart';
import '../../utils/constants.dart';

class CreateFollowUpTaskWidget extends StatefulWidget {
  final List<Order> orders;
  final TaskModel task;

  const CreateFollowUpTaskWidget({
    Key? key,
    required this.orders,
    required this.task,
  }) : super(key: key);

  @override
  State<CreateFollowUpTaskWidget> createState() =>
      _CreateFollowUpTaskWidgetState();
}

class _CreateFollowUpTaskWidgetState extends State<CreateFollowUpTaskWidget> {
  late List<List<OrderItem>> selectedItems;

  @override
  initState() {
    super.initState();
    selectedItems = [];
    for (var order in widget.orders) {
      selectedItems.add([]);
    }
  }

  Map<String, dynamic> subjectBody = {
    'subject': '',
  };

  Map<String, dynamic> dueDateBody = {
    'dueDate': '',
  };

  Map<String, dynamic> commentBody = {
    'comment': '',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SizeSystem.size32),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: SizeSystem.size8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: PaddingSystem.padding16,
              vertical: PaddingSystem.padding24,
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  IconSystem.followUpTaskIcon,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  'Follow Up Task Details',
                  style: TextStyle(
                    color: ColorSystem.primary,
                    fontFamily: kRubik,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeSystem.size16,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: PaddingSystem.padding16,
              ),
              children: [
                SubjectWidget(
                  subjectBody: subjectBody,
                ),
                const SizedBox(
                  height: SizeSystem.size16,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.orders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FollowUpTaskOrderSelectionWidget(
                      order: widget.orders[index],
                      task: widget.task,
                      selectedItems: selectedItems[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: SizeSystem.size16,
                    );
                  },
                ),
                CreateTaskDateWidget(
                    dueByDate: widget.task.taskDate ?? '--',
                    dueDateMap: dueDateBody,
                    assigneeName: widget.task.assignedTo ?? '--'),
                const SizedBox(
                  height: SizeSystem.size16,
                ),
                CreateTaskCommentWidget(commentBody: commentBody),
                const SizedBox(
                  height: SizeSystem.size16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(ColorSystem.primary),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ))),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: PaddingSystem.padding22),
                          child: Text(
                            'Create Task',
                            style: TextStyle(fontSize: 16, fontFamily: kRubik),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: SizeSystem.size32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FollowUpTaskOrderSelectionWidget extends StatefulWidget {
  final Order order;
  final TaskModel task;
  final List<OrderItem> selectedItems;

  const FollowUpTaskOrderSelectionWidget({
    Key? key,
    required this.order,
    required this.task,
    required this.selectedItems,
  }) : super(key: key);

  @override
  State<FollowUpTaskOrderSelectionWidget> createState() =>
      _FollowUpTaskOrderSelectionWidgetState();
}

class _FollowUpTaskOrderSelectionWidgetState
    extends State<FollowUpTaskOrderSelectionWidget> {
  bool? selectedRadioOption = false;

  List<OrderItem> orderItems = [];

  String dateFormatter(String date) {
    var dateTime = DateTime.parse(date);
    return DateFormat('MMM dd, yyyy').format(dateTime);
  }

  @override
  initState() {
    super.initState();
    orderItems = List.from(widget.order.orderLines ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          SizeSystem.size14,
        ),
        color: ColorSystem.culturedGrey,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: SizeSystem.size16,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingSystem.padding16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.order.orderNumber ?? '--',
                  style: const TextStyle(
                    color: ColorSystem.primary,
                    fontFamily: kRubik,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeSystem.size12,
                  ),
                ),
                Text(
                  '${widget.order.brand ?? '--'} | ${dateFormatter(widget.order.createdDate ?? '--')}',
                  style: const TextStyle(
                    color: ColorSystem.primary,
                    fontWeight: FontWeight.normal,
                    fontSize: SizeSystem.size14,
                    fontFamily: kRubik,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: SizeSystem.size12,
          ),
          Container(
            height: SizeSystem.size1,
            color: ColorSystem.secondary.withOpacity(0.4),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(PaddingSystem.padding16),
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: ColorSystem.primary,
                      checkColor: ColorSystem.white,
                      value: widget.selectedItems.contains(orderItems[index]),
                      shape: const CircleBorder(),
                      onChanged: (bool? value) {
                        if (value != null) {
                          if (value) {
                            widget.selectedItems.add(orderItems[index]);
                          } else {
                            widget.selectedItems.remove(orderItems[index]);
                          }
                        }
                        setState(() {});
                      },
                    ),
                    CachedNetworkImage(
                      imageUrl: orderItems[index].imageUrl ?? '--',
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: SizeSystem.size72,
                          width: SizeSystem.size72,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              SizeSystem.size12,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              SizeSystem.size12,
                            ),
                            child: Image(
                              image: imageProvider,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      width: SizeSystem.size10,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderItems[index].description ?? '--',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: ColorSystem.primary,
                                fontFamily: kRubik,
                                fontWeight: FontWeight.normal,
                                fontSize: SizeSystem.size12,
                              ),
                            ),
                            const SizedBox(
                              height: SizeSystem.size10,
                            ),
                            Text(
                              widget.task.taskType ?? '--',
                              style: const TextStyle(
                                color: ColorSystem.primary,
                                fontFamily: kRubik,
                                fontWeight: FontWeight.normal,
                                fontSize: SizeSystem.size12,
                              ),
                            ),
                            Divider(
                              color: ColorSystem.primary.withOpacity(0.3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: SizeSystem.size1,
                color: ColorSystem.secondary.withOpacity(0.4),
              );
            },
            itemCount: orderItems.length,
          ),
        ],
      ),
    );
  }
}
