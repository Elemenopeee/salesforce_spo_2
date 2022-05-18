import 'package:flutter/material.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/design_system/primitives/color_system.dart';
import 'package:salesforce_spo/utils/constants.dart';

class OrderWidget extends StatelessWidget {
  final String name;
  final String amount;
  final String date;
  final String items;
  final String orderId;
  final String orderPercentage;
  final bool isDraft;

  const OrderWidget({
    Key? key,
    required this.name,
    required this.amount,
    required this.date,
    required this.items,
    required this.orderId,
    required this.orderPercentage,
    this.isDraft = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 08),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: kRubik,
                  color: ColorSystem.primary,
                ),
              ),
              const SizedBox(
                height: 04,
              ),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: kRubik,
                  color: ColorSystem.primary,
                ),
              ),
              const SizedBox(
                height: 04,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'OID: $orderId',
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: kRubik,
                      color: ColorSystem.secondary,
                    ),
                  ),
                  if (isDraft)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SizeSystem.size6),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SizeSystem.size2),
                          color: ColorSystem.complimentary.withOpacity(0.2),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: SizeSystem.size8,
                          vertical: SizeSystem.size2,
                        ),
                        child: const Text(
                          'Open',
                          style: TextStyle(
                            color: ColorSystem.complimentary,
                            fontSize: SizeSystem.size10,
                            fontFamily: kRubik,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: kRubik,
                  color: ColorSystem.primary,
                ),
              ),
              const SizedBox(
                height: 04,
              ),
              Text(
                items,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: kRubik,
                  color: ColorSystem.primary,
                ),
              ),
              const SizedBox(
                height: 04,
              ),
              Text(
                orderPercentage,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: kRubik,
                  color: ColorSystem.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
