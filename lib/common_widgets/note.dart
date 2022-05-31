import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/design_system/primitives/color_system.dart';
import 'package:salesforce_spo/design_system/primitives/icon_system.dart';
import 'package:salesforce_spo/design_system/primitives/padding_system.dart';
import 'package:salesforce_spo/design_system/primitives/size_system.dart';

import '../utils/constants.dart';

class NoteWidget extends StatelessWidget {
  final String note;
  final String tag1;
  final String tag2;
  final String date;
  final Color bgColor;
  final bool pinned;
  const NoteWidget(
      {Key? key,
      required this.note,
      required this.tag1,
      required this.tag2,
      required this.date,
      required this.bgColor,
      required this.pinned})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(note),
      enabled: !pinned,
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),
        children: const [],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
            vertical: PaddingSystem.padding5,
            horizontal: PaddingSystem.padding10),
        decoration: BoxDecoration(
            color: bgColor,
            border: !pinned ? null : Border.all(color: ColorSystem.black),
            borderRadius: BorderRadius.circular(SizeSystem.size20)),
        child: Stack(children: [
          Container(
            padding: const EdgeInsets.all(PaddingSystem.padding20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note,
                  style: const TextStyle(
                      fontSize: SizeSystem.size12, fontFamily: kRubik),
                ),
                const SizedBox(
                  height: SizeSystem.size20,
                ),
                Visibility(
                  visible: pinned,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Jessica  is a gutiar geerk, and loves acoustic guitar, loves the color blue, she hates hip- hop related stuff, so try to avoid that. She is Enrolled in Beginner Classes, and a active store vistior, so try to up sell her the next lessons.the color blue, she hates hip- hop related stuff, so try to avoid that. She is Enrolled in Beginner Classes',
                          style: TextStyle(
                              fontSize: SizeSystem.size12,
                              color: ColorSystem.secondary,
                              fontFamily: kRubik),
                        ),
                        SizedBox(
                          height: SizeSystem.size20,
                        ),
                        Text(
                          'John Doe, GM West Village Store',
                          style: TextStyle(
                              fontSize: SizeSystem.size10,
                              color: ColorSystem.secondary,
                              fontFamily: kRubik),
                        ),
                        SizedBox(
                          height: SizeSystem.size10,
                        ),
                      ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: pinned
                                    ? ColorSystem.black
                                    : ColorSystem.secondary,
                                fontSize: SizeSystem.size12,
                                fontFamily: kRubik),
                            children: [
                          TextSpan(text: tag1),
                          const TextSpan(text: ' | '),
                          TextSpan(text: tag2),
                        ])),
                    Text(
                      date,
                      style: TextStyle(
                          color: pinned
                              ? ColorSystem.black
                              : ColorSystem.secondary,
                          fontFamily: kRubik,
                          fontSize: SizeSystem.size12),
                    )
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: pinned,
            child: Positioned(
                top: SizeSystem.size0,
                right: SizeSystem.size0,
                child: SvgPicture.asset(
                  IconSystem.notePinBg,
                  color: ColorSystem.black,
                )),
          ),
          Visibility(
            visible: pinned,
            child: Positioned(
                top: SizeSystem.size6,
                right: SizeSystem.size8,
                child: SvgPicture.asset(
                  IconSystem.pin,
                  color: ColorSystem.white,
                )),
          ),
        ]),
      ),
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.
        dismissible: DismissiblePane(onDismissed: () {}),

        // All actions are defined in the children parameter.
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
            child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  IconSystem.trash,
                  color: ColorSystem.black,
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
            child: IconButton(
                onPressed: () {}, icon: SvgPicture.asset(IconSystem.pinDark)),
          ),
        ],
      ),
    );
  }
}
