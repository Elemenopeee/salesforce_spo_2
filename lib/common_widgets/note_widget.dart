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
  final String date;
  final String name;
  final Color? bgColor;
  final bool pinned;
  final String? description;

  const NoteWidget({
    Key? key,
    required this.note,
    required this.name,
    required this.date,
    this.bgColor,
    required this.pinned,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(note),
      // enabled: !pinned,
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
            // border: !pinned ? null : Border.all(color: ColorSystem.black),
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
                      children: [
                        Text(
                          description ?? '--',
                          style: const TextStyle(
                            fontSize: SizeSystem.size12,
                            color: ColorSystem.secondary,
                            fontFamily: kRubik,
                          ),
                        ),
                        const SizedBox(
                          height: SizeSystem.size20,
                        ),
                      ]),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(
                            style: const TextStyle(
                                fontSize: SizeSystem.size10,
                                color: ColorSystem.secondary,
                                fontFamily: kRubik),
                            children: [
                          TextSpan(text: name),
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
            margin:
                const EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
            child: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  IconSystem.trash,
                  color: ColorSystem.black,
                )),
          ),
          Container(
            margin:
                const EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
            child: IconButton(
                onPressed: () {}, icon: SvgPicture.asset(IconSystem.pinDark)),
          ),
        ],
      ),
    );
  }
}
