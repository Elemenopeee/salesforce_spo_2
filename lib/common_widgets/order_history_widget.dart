import 'package:flutter/material.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/size_system.dart';

class OrderHistoryWidget extends StatelessWidget {
  final String? orderStatus;
  final String? orderItemsName;
  final String? orderDate;

  const OrderHistoryWidget({
    Key? key,
    this.orderStatus,
    this.orderItemsName,
    this.orderDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            orderStatus!,
            style: const TextStyle(
              fontSize: SizeSystem.size18,
              color: ColorSystem.primaryTextColor,
            ),
          ),
          const SizedBox(
            height: SizeSystem.size5,
          ),
          Text(
            orderItemsName!,
            style: const TextStyle(
              fontSize: SizeSystem.size18,
              color: ColorSystem.primaryTextColor,
            ),
          ),
          const SizedBox(
            height: SizeSystem.size5,
          ),
          Text(
            orderDate!,
            style: const TextStyle(
              fontSize: SizeSystem.size16,
              color: ColorSystem.secondary,
            ),
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
