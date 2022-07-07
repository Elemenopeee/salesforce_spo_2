import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../design_system/design_system.dart';
import '../utils/constants.dart';

class ProfileContainer extends StatelessWidget {
  final String agentName;

  const ProfileContainer({
    Key? key,
    required this.agentName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dateNow = DateTime.now();
    var date = DateTime(dateNow.year, dateNow.month, dateNow.day);

    var day = DateFormat(DateFormat.ABBR_WEEKDAY).format(date);
    var monthDate = DateFormat(DateFormat.ABBR_MONTH_DAY).format(date);


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 05),
                child: Text(
                  "Hi $agentName",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: kRubik,
                    color: ColorSystem.primary,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${day.toUpperCase()},',
                style: const TextStyle(
                  fontSize: SizeSystem.size16,
                  color: ColorSystem.primary,
                  fontFamily: kRubik,
                  letterSpacing: 2,
                ),
              ),
              Text(
                monthDate.toUpperCase(),
                style: const TextStyle(
                  fontSize: SizeSystem.size16,
                  fontWeight: FontWeight.bold,
                  color: ColorSystem.primary,
                  fontFamily: kRubik,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
