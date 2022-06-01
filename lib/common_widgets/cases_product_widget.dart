import 'package:flutter/material.dart';
import 'package:salesforce_spo/common_widgets/priority_status_container.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/size_system.dart';
import '../utils/constants.dart';

class CasesProductWidget extends StatelessWidget {
  final String? casesReason;
  final String? casesDate;
  final String? casesStatus;
  final String? caseNumber;
  final String? casePriorityStatus;
  final String? userName;

  const CasesProductWidget({
    Key? key,
    this.casesReason,
    this.casesDate,
    this.casesStatus,
    this.caseNumber,
    this.casePriorityStatus,
    this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    casesReason ?? "",
                    style: const TextStyle(
                      fontSize: SizeSystem.size14,
                      fontFamily: kRubik,
                      color: ColorSystem.primaryTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: SizeSystem.size6,
                  ),
                  Text(
                    casesDate ?? "",
                    style: const TextStyle(
                      fontSize: SizeSystem.size12,
                      color: ColorSystem.secondary,
                      fontFamily: kRubik,
                    ),
                  ),
                  const SizedBox(
                    height: SizeSystem.size6,
                  ),
                  Text(
                    '${"Last Updated By: "}${userName ?? ""}',
                    style: const TextStyle(
                      fontSize: SizeSystem.size12,
                      color: ColorSystem.secondary,
                      fontFamily: kRubik,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  PriorityStatusContainer(
                    borderRadius: BorderRadius.circular(SizeSystem.size5),
                    priorityStatus: casePriorityStatus,
                    // priorityStatus: casePriorityStatus,
                  ),
                  // priorityStatus(casePriorityStatus ?? ""),
                  const SizedBox(
                    height: SizeSystem.size4,
                  ),
                  Text(
                    '${"Case Number: "}${caseNumber ?? ""}',
                    style: const TextStyle(
                      fontSize: SizeSystem.size12,
                      color: ColorSystem.secondary,
                      fontFamily: kRubik,
                    ),
                  ),
                  const SizedBox(
                    height: SizeSystem.size4,
                  ),
                  Text(
                    '${"Status: "}${casesStatus ?? ""}',
                    style: const TextStyle(
                      fontSize: SizeSystem.size12,
                      color: ColorSystem.secondary,
                      fontFamily: kRubik,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
