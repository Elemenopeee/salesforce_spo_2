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
    var formattedDate =
    DateFormat(DateFormat.ABBR_MONTH_WEEKDAY_DAY).format(date);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    IconSystem.sun,
                    width: SizeSystem.size16,
                    height: SizeSystem.size16,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    formattedDate.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorSystem.lavender2,
                      fontFamily: kRubik,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
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
          Container(
            height: SizeSystem.size60,
            width: SizeSystem.size60,
            child: SvgPicture.asset(
              IconSystem.userPlaceholder,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeSystem.size24),
            ),
          ),
        ],
      ),
    );
  }
}
