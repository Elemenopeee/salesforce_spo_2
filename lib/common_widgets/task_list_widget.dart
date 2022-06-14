import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/design_system/design_system.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/size_system.dart';
import '../utils/constants.dart';

class TaskListWidget extends StatelessWidget {
  final String? subject;
  final String? taskType;
  final String? status;
  final String? activityDate;

  const TaskListWidget({
    Key? key,
    this.subject,
    this.taskType,
    this.status,
    this.activityDate,
  }) : super(key: key);

  String getSubtitleFromDate(String? activityDate) {
    if (activityDate == null) {
      return '';
    } else {
      var dateTime = DateTime.parse(activityDate);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = DateTime(now.year, now.month, now.day - 1);
      final tomorrow = DateTime(now.year, now.month, now.day + 1);
      final dateToCheck = DateTime(dateTime.year, dateTime.month, dateTime.day);
      if (dateToCheck == today) {
        return ' : Today';
      } else if (dateToCheck == yesterday ||
          dateToCheck.millisecondsSinceEpoch <
              yesterday.millisecondsSinceEpoch) {
        return ' : Overdue';
      } else if (dateToCheck == tomorrow) {
        return ' : Tomorrow';
      } else {
        return ' : ${DateFormat('MMM dd, yyyy').format(dateTime)}';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$subject',
                style: const TextStyle(
                  fontSize: SizeSystem.size16,
                  color: ColorSystem.primary,
                  fontFamily: kRubik,
                ),
              ),
              const SizedBox(
                height: SizeSystem.size4,
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: kRubik,
                  ),
                  children: [
                    TextSpan(
                      text: '$taskType',
                      style: const TextStyle(
                        fontSize: SizeSystem.size14,
                        color: ColorSystem.secondary,
                      ),
                    ),
                    TextSpan(
                      text: getSubtitleFromDate(activityDate),
                      style: TextStyle(
                        fontSize: SizeSystem.size14,
                        color: getSubtitleFromDate(activityDate).contains('Overdue')
                            ? ColorSystem.complimentary
                            : ColorSystem.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (subject != null)
          subject!.toLowerCase().contains('call')
              ? SvgPicture.asset(
                  IconSystem.phone,
                  height: 24,
                  width: 24,
                  color: Colors.black,
                )
              : const SizedBox(),
      ],
    );
  }
}
