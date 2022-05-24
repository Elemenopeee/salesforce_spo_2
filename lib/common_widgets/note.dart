import 'package:flutter/material.dart';
import 'package:salesforce_spo/design_system/primitives/color_system.dart';
import 'package:salesforce_spo/design_system/primitives/padding_system.dart';
import 'package:salesforce_spo/design_system/primitives/size_system.dart';

import '../utils/constants.dart';

class NoteWidget extends StatelessWidget {
  final String note;
  final String tag1;
  final String tag2;
  final String date;
  final Color bgColor;
  const NoteWidget(
      {Key? key,
      required this.note,
      required this.tag1,
      required this.tag2,
      required this.date,
      required this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: PaddingSystem.padding5,
          horizontal: PaddingSystem.padding15),
      padding: const EdgeInsets.all(PaddingSystem.padding20),
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(SizeSystem.size10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note,
            style: const TextStyle(
                fontSize: SizeSystem.size14, fontFamily: kRubik),
          ),
          const SizedBox(
            height: SizeSystem.size20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                      style: const TextStyle(
                          color: ColorSystem.secondary,
                          fontSize: SizeSystem.size14,
                          fontFamily: kRubik),
                      children: [
                    TextSpan(text: tag1),
                    const TextSpan(text: ' | '),
                    TextSpan(text: tag2),
                  ])),
              Text(
                date,
                style: const TextStyle(
                    color: ColorSystem.secondary,
                    fontFamily: kRubik,
                    fontSize: SizeSystem.size14),
              )
            ],
          ),
        ],
      ),
    );
  }
}
