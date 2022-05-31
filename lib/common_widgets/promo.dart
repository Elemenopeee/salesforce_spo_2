import 'package:flutter/material.dart';
import 'package:salesforce_spo/design_system/primitives/color_system.dart';
import 'package:salesforce_spo/design_system/primitives/padding_system.dart';
import 'package:salesforce_spo/design_system/primitives/size_system.dart';

import '../utils/constants.dart';

class Promo extends StatelessWidget {
  final String title;
  final String date;
  const Promo({
    Key? key,
    required this.title,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: PaddingSystem.padding10,
          vertical: PaddingSystem.padding5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: SizeSystem.size20,
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            color: ColorSystem.black,
                            fontSize: SizeSystem.size16,
                            fontFamily: kRubik),
                      ),
                      const SizedBox(
                        height: SizeSystem.size10,
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                            fontSize: SizeSystem.size14,
                            color: ColorSystem.secondary,
                            fontFamily: kRubik),
                      ),
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
