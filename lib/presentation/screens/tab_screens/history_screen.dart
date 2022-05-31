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
    return Container(
        padding: const EdgeInsets.only(top: PaddingSystem.padding20),
        child: ListView.builder(
            itemCount: orderStatus.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return getSingleFeatureList(context, index);
            }));
  }

  Widget getSingleFeatureList(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            orderStatus[index],
            style: const TextStyle(
                fontSize: SizeSystem.size16,
                color: ColorSystem.primaryTextColor),
          ),
          const SizedBox(
            height: SizeSystem.size5,
          ),
          Text(
            orderItemName[index],
            style: const TextStyle(
                fontSize: SizeSystem.size16,
                color: ColorSystem.primaryTextColor),
          ),
          const SizedBox(
            height: SizeSystem.size5,
          ),
          Text(
            orderDate[index],
            style: const TextStyle(
                fontSize: SizeSystem.size14, color: ColorSystem.secondary),
          ),
          const SizedBox(
            height: SizeSystem.size5,
          ),
          const Divider(
            thickness: SizeSystem.size1,
          ),
        ],
      ),
    );
  }
}
