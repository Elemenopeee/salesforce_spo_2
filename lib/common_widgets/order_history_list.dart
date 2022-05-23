import 'package:flutter/material.dart';
import 'package:salesforce_spo/design_system/design_system.dart';

class OrderHistoryList extends StatelessWidget {
  OrderHistoryList({Key? key}) : super(key: key);

  var orderStatus = [
    "Order Placed",
    "Order Cancelled",
    "Refund Initiated",
    "Transaction failed",
    "Order Delivered",
    "Order Delivered",
    "Order Delivered",
  ];
  var orderItemName = [
    "Yamaha MX-100 Guitar",
    "Yamaha MX-100 Guitar",
    "Yamaha MX-100 Guitar",
    "Yamaha MX-100 Guitar",
    "Yamaha MX-100 Guitar",
    "Yamaha MX-100 Guitar",
    "Yamaha MX-100 Guitar",
  ];
  var orderDate = [
    "20-Mar-2022",
    "20-Mar-2022",
    "20-Mar-2022",
    "20-Mar-2022",
    "20-Mar-2022",
    "20-Mar-2022",
    "20-Mar-2022",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: orderStatus.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getSingleFeatureList(context, index),
              const Divider(
                thickness: 1,
                color: ColorSystem.greyBg,
              )
            ],
          );
        });
  }

  Widget getSingleFeatureList(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            orderStatus[index],
            style: const TextStyle(
                fontSize: 18, color: ColorSystem.primaryTextColor),
          ),
          const SizedBox(
            height: 05,
          ),
          Text(
            orderItemName[index],
            style: const TextStyle(
                fontSize: 18, color: ColorSystem.primaryTextColor),
          ),
          const SizedBox(
            height: 05,
          ),
          Text(
            orderDate[index],
            style: const TextStyle(fontSize: 16, color: ColorSystem.secondary),
          ),
        ],
      ),
    );
  }
}
