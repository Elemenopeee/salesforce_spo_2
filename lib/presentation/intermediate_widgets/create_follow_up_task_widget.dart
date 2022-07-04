import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/common_widgets/subject_widget.dart';
import 'package:salesforce_spo/models/task.dart';

import '../../common_widgets/custom_dialog_action.dart';
import '../../common_widgets/task_details_date_widget.dart';
import '../../design_system/design_system.dart';
import '../../models/order.dart';
import '../../models/order_item.dart';
import '../../services/networking/endpoints.dart';
import '../../services/networking/networking_service.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SizeSystem.size32),
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: PaddingSystem.padding16,
        ),
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
          const SubjectWidget(),
          const SizedBox(
            height: SizeSystem.size16,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.orders.length,
            itemBuilder: (BuildContext context, int index) {
              return FollowUpTaskOrderSelectionWidget(
                  order: widget.orders[index]);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: SizeSystem.size16,
              );
            },
          ),
          TaskDetailsDateWidget(
            showModifiedBy: false,
            task: widget.task,
            assigned_to_name: widget.task.assignedTo ?? '--',
            modified_by_name: widget.task.modifiedBy ?? '--',
            due_by_date: widget.task.taskDate ?? '--',
            modified_date: widget.task.lastModifiedDate ?? '--',
            lastModifiedById: widget.task.modifiedById ?? '--',
          ),
          const SizedBox(
            height: SizeSystem.size16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(ColorSystem.primary),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
    );
  }
}

class FollowUpTaskOrderSelectionWidget extends StatefulWidget {
  final Order order;

  const FollowUpTaskOrderSelectionWidget({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<FollowUpTaskOrderSelectionWidget> createState() =>
      _FollowUpTaskOrderSelectionWidgetState();
}

class _FollowUpTaskOrderSelectionWidgetState
    extends State<FollowUpTaskOrderSelectionWidget> {
  bool? selectedRadioOption = false;

  List<OrderItem> orderItems = [];
  List<OrderItem> selectedItems = [];

  late Future<void> futureOrderItems;

  Future<void> getFutureOrder() async {
    var response = await HttpService().doGet(
        path: Endpoints.getSmartTriggerOrder(widget.order.orderNumber ?? '--'));

    if (response.data != null) {
      for (var order in response.data['OrderList']) {
        for (var item in order['Items']) {
          try {
            orderItems.add(OrderItem.fromTaskJson(item));
          } on Exception catch (e) {
            print(e);
          }
        }
      }
    }
  }

  String dateFormatter(String date) {
    var dateTime = DateTime.parse(date);
    return DateFormat('MMM dd, yyyy').format(dateTime);
  }

  @override
  initState() {
    super.initState();
    futureOrderItems = getFutureOrder();
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
          FutureBuilder(
            future: futureOrderItems,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const Center(
                    child: SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: ColorSystem.primary,
                        ),
                      ),
                    ),
                  );
                case ConnectionState.done:
                  return ListView.separated(
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
                              value: selectedItems.contains(orderItems[index]),
                              shape: const CircleBorder(),
                              onChanged: (bool? value) {
                                if(value != null){
                                  if(value){
                                    selectedItems.add(orderItems[index]);
                                  }
                                  else {
                                    selectedItems.remove(orderItems[index]);
                                  }
                                }
                                setState((){});
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
                                    InkWell(
                                      onTap: () async {
                                        await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return CupertinoAlertDialog(
                                              actions: [
                                                Material(
                                                  child: Column(
                                                    children: [
                                                      CustomDialogAction(
                                                        label: 'Upcoming ',
                                                        onTap: () {},
                                                      ),
                                                      Container(
                                                        height:
                                                            SizeSystem.size1,
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                      ),
                                                      CustomDialogAction(
                                                        label: 'Overdue',
                                                        onTap: () {},
                                                      ),
                                                      Container(
                                                        height:
                                                            SizeSystem.size1,
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                      ),
                                                      CustomDialogAction(
                                                        label: 'All ',
                                                        onTap: () {},
                                                      ),
                                                      Container(
                                                        height:
                                                            SizeSystem.size1,
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                      ),
                                                      CustomDialogAction(
                                                        label: 'Today ',
                                                        onTap: () {},
                                                      ),
                                                      Container(
                                                        height:
                                                            SizeSystem.size1,
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                      ),
                                                      CustomDialogAction(
                                                        label: 'Completed',
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'data',
                                            style: TextStyle(
                                              color: ColorSystem.primary,
                                              fontFamily: kRubik,
                                              fontWeight: FontWeight.normal,
                                              fontSize: SizeSystem.size12,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                            IconSystem.downArrow,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: ColorSystem.black.withOpacity(0.3),
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
                  );
              }
            },
          ),
        ],
      ),
    );
  }
}
