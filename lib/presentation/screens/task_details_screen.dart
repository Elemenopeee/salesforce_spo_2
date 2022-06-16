import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/common_widgets/comment_widget.dart';
import 'package:salesforce_spo/common_widgets/product_list_card_widget.dart';
import 'package:salesforce_spo/common_widgets/task_client_profile_widget.dart';
import 'package:salesforce_spo/common_widgets/task_details_date_widget.dart';
import 'package:salesforce_spo/common_widgets/tgc_app_bar.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/models/customer.dart';
import 'package:salesforce_spo/models/order.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';

class TaskDetailsScreen extends StatefulWidget {
  final String taskId;
  final String? email;

  const TaskDetailsScreen({
    Key? key,
    required this.taskId,
    this.email,
  }) : super(key: key);

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late Future<void> futureTaskDetails;
  late Future<void> futureUserInformation;

  List<Order> orders = [];

  Customer? customer;

  Future<void> getUserInformation() async {
    if (widget.email != null) {
      var response = await HttpService().doGet(
          path: Endpoints.getUserInformation('ankit.kumar@guitarcenter.com'));

      if (response.data != null) {
        if (response.data['records'] != null) {
          customer =
              Customer.fromUserInfoJson(json: response.data['records'][0]);
        }
      }
    }
  }

  Future<void> getTaskDetails() async {
    var response = await HttpService()
        .doGet(path: Endpoints.getTaskDetails(widget.taskId));

    try {
      if (response.data != null) {
        for (var order in response.data['Orders']) {
          try {
            orders.add(Order.fromOrderInfoJson(order));
            print(orders.length);
          } on Exception catch (e) {
            print(e);
          }
        }
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  initState() {
    super.initState();
    futureTaskDetails = getTaskDetails();
    futureUserInformation = getUserInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSystem.scaffoldBackgroundColor,
      appBar: TGCAppBar(
        label: 'CALL ALERT',
        leadingWidget: InkWell(
          onTap: (){
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
          return ListView(
            padding: const EdgeInsets.all(10),
            children: [
              if (widget.email != null)
                FutureBuilder(
                  future: futureUserInformation,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (customer != null) {
                      return ProfileWidget(
                          name: customer?.name ?? '--',
                          number: customer?.phone ?? '--',
                          email: customer?.email ?? '--');
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              if (widget.email != null)
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
                      Date: orders[index].createdDate ?? '--');
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
              ),
              const AddComment(
                assigned_to_name: 'Rajas',
                modified_by_name: 'Rajas',
                due_by_date: 'Todays date',
                modified_date: 'Yesterdays date',
              ),
              const SizedBox(
                height: 20,
              ),
              const TaskDetailsDateWidget(
                assigned_to_name: 'Rajas',
                modified_by_name: 'Rajas',
                due_by_date: 'Today',
                modified_date: 'Yesterday',
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(ColorSystem.lavender3),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                              )
                          )
                      ),
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            '+',
                            style: TextStyle(fontSize: 30),
                          ),
                        ),),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(ColorSystem.primary),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )
                            )
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 22),
                              child: const Text(
                                'Mark as complete',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          );
        },
      ),
    );
  }
}
