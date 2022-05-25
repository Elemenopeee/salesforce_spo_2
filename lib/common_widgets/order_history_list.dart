import 'package:flutter/material.dart';
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
          return getSingleFeatureList(context, index);
        });
  }

  Widget getSingleFeatureList(BuildContext context, int index) {
    var item = orderHistoryData[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item?.orderStatus ?? "",
            style: const TextStyle(
                fontSize: SizeSystem.size18,
                color: ColorSystem.primaryTextColor),
          ),
          const SizedBox(
            height: SizeSystem.size5,
          ),
          Text(
            item?.orderItemsName ?? "",
            style: const TextStyle(
                fontSize: SizeSystem.size18,
                color: ColorSystem.primaryTextColor),
          ),
          const SizedBox(
            height: SizeSystem.size5,
          ),
          Text(
            item?.date ?? "",
            style: const TextStyle(
                fontSize: SizeSystem.size16, color: ColorSystem.secondary),
          ),
          const Divider(
            thickness: 1,
            color: ColorSystem.greyBg,
          )
        ],
      ),
    );
  }
}
