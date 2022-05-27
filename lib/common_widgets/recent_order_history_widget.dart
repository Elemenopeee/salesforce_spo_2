import 'package:flutter/material.dart';
import 'package:salesforce_spo/utils/constants.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/size_system.dart';

class RecentOrderHistoryWidget extends StatelessWidget {
  final String? orderTitle;
  final String? orderDescription;
  final String? orderDate;

  const RecentOrderHistoryWidget({
    Key? key,
    this.orderDate,
    this.orderTitle,
    this.orderDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: SizeSystem.size50, right: SizeSystem.size20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            orderTitle!,
            style: const TextStyle(
              fontSize: SizeSystem.size14,
              fontFamily: kRubik,
              fontWeight: FontWeight.w600,
              color: ColorSystem.primaryTextColor,
            ),
          ),
          const SizedBox(
            height: SizeSystem.size5,
          ),
          Text(
            orderDescription!,
            style: const TextStyle(
              fontSize: SizeSystem.size14,
              fontFamily: kRubik,
              color: ColorSystem.primaryTextColor,
            ),
          ),
          const SizedBox(
            height: SizeSystem.size5,
          ),
          Text(
            orderDate!,
            style: const TextStyle(
              fontSize: SizeSystem.size12,
              fontFamily: kRubik,
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
