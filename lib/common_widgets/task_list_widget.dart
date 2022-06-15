import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/size_system.dart';
import '../utils/constants.dart';

class TaskListWidget extends StatelessWidget {
  final String? subject;
  final String? taskType;
  final String? status;
  final String? activityDate;
  final String? phone;
  final String? email;

  const TaskListWidget({
    Key? key,
    this.subject,
    this.taskType,
    this.status,
    this.activityDate,
    this.email,
    this.phone,
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: PaddingSystem.padding12),
      child: Row(
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
          InkWell(
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () async {
              if(phone != null){
                await launchUrl(Uri.parse('tel://$phone'));
              }
            },
            child: SvgPicture.asset(
              IconSystem.phone,
              height: 24,
              width: 24,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
