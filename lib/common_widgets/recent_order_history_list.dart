import 'package:flutter/material.dart';
import 'package:salesforce_spo/common_widgets/recent_order_history_widget.dart';
import 'package:salesforce_spo/models/recent_order_history_model.dart';

class RecentOrderHistoryList extends StatelessWidget {
  RecentOrderHistoryList({Key? key}) : super(key: key);

  List<RecentOrderHistoryModel?> orderHistoryData = [
    RecentOrderHistoryModel(
      orderTitle: "Call Jessica in 3 days",
      orderDescription: "Ankit kumar has an upcoming Task with Ankit Kumar",
      date: "20-Mar-2022",
    ),
    RecentOrderHistoryModel(
      orderTitle: "Call Ankit",
      orderDescription:
          "Brain Szczepanski has an upcoming Task with Ankit Kumar",
      date: "20-Mar-2022",
    ),
    RecentOrderHistoryModel(
      orderTitle: "Send Quote to Ankit",
      orderDescription: "Szczepanski has a Task with Ankit Kumar",
      date: "20-Mar-2022",
    ),
    RecentOrderHistoryModel(
      orderTitle: "Send Quote to Ankit",
      orderDescription: "Szczepanski has a Task with Ankit Kumar",
      date: "20-Mar-2022",
    ),
    RecentOrderHistoryModel(
      orderTitle: "Send Quote to Ankit",
      orderDescription: "Szczepanski has a Task with Ankit Kumar",
      date: "20-Mar-2022",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: orderHistoryData.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var item = orderHistoryData[index];
          return RecentOrderHistoryWidget(
            orderTitle: item?.orderTitle,
            orderDescription: item?.orderDescription,
            orderDate: item?.date,
          );
        });
  }
}
