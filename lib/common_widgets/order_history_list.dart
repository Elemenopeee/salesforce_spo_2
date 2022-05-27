import 'package:flutter/material.dart';
import 'package:salesforce_spo/common_widgets/order_history_widget.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/models/order_history_model.dart';

class OrderHistoryList extends StatelessWidget {
  OrderHistoryList({Key? key}) : super(key: key);

  List<OrderHistoryModel?> orderHistoryData = [
    OrderHistoryModel(
      orderStatus: "Order Placed",
      orderItemsName: "Yamaha MX-100 Guitar",
      date: "20-Mar-2022",
    ),
    OrderHistoryModel(
      orderStatus: "Order Cancelled",
      orderItemsName: "Yamaha MX-100 Guitar",
      date: "20-Mar-2022",
    ),
    OrderHistoryModel(
      orderStatus: "Refund Initiated",
      orderItemsName: "Yamaha MX-100 Guitar",
      date: "20-Mar-2022",
    ),
    OrderHistoryModel(
      orderStatus: "Transaction failed",
      orderItemsName: "Yamaha MX-100 Guitar",
      date: "20-Mar-2022",
    ),
    OrderHistoryModel(
      orderStatus: "Order Delivered",
      orderItemsName: "Yamaha MX-100 Guitar",
      date: "20-Mar-2022",
    ),
    OrderHistoryModel(
      orderStatus: "Order Delivered",
      orderItemsName: "Yamaha MX-100 Guitar",
      date: "20-Mar-2022",
    ),
    OrderHistoryModel(
      orderStatus: "Order Delivered",
      orderItemsName: "Yamaha MX-100 Guitar",
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
          return OrderHistoryWidget(
            orderItemsName: item?.orderStatus,
            orderStatus: item?.orderStatus,
            orderDate: item?.date,
          );
        });
  }
}
