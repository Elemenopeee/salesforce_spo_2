import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/utils/enums/social_icon_enum.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/size_system.dart';
import '../utils/constants.dart';

class TaskListWidget extends StatelessWidget {
  final String? title;
  final String? userName;
  final String? taskName;
  final String? timeStatus;
  final String? subTitle;
  final String? iconImage;
  final String? iconValue;
  final double? iconHeight;
  final double? iconWidth;
  final Color? iconColor;

  const TaskListWidget({
    Key? key,
    this.title,
    this.userName,
    this.taskName,
    this.timeStatus,
    this.subTitle,
    this.iconImage,
    this.iconColor,
    this.iconHeight,
    this.iconWidth,
    this.iconValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: kRubik,
                  ),
                  children: [
                    TextSpan(
                      text: '$title ',
                      style: const TextStyle(
                        fontSize: SizeSystem.size16,
                        color: ColorSystem.primary,
                      ),
                    ),
                    TextSpan(
                      text: userName,
                      style: const TextStyle(
                        fontSize: SizeSystem.size16,
                        color: ColorSystem.lavender3,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                taskName ?? "",
                style: const TextStyle(
                  fontSize: SizeSystem.size16,
                  color: ColorSystem.primary,
                ),
              ),
              const SizedBox(
                height: 05,
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: kRubik,
                  ),
                  children: [
                    TextSpan(
                      text: '$subTitle : ',
                      style: const TextStyle(
                        fontSize: SizeSystem.size14,
                        color: ColorSystem.secondary,
                      ),
                    ),
                    TextSpan(
                      text: timeStatus,
                      style: const TextStyle(
                        fontSize: SizeSystem.size14,
                        color: ColorSystem.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SvgPicture.asset(
          iconImage!,
          height: iconHeight,
          width: iconWidth,
          color: iconColor,
        ),
      ],
    );
  }
}
