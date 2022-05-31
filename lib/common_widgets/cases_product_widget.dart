import 'package:flutter/material.dart';

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
                  priorityStatus(casePriorityStatus ?? ""),
                  const SizedBox(
                    height: SizeSystem.size5,
                  ),
                  Text(
                    '${"Cases Number: "}${caseNumber ?? ""}',
                    style: const TextStyle(
                      fontSize: SizeSystem.size12,
                      color: ColorSystem.secondary,
                      fontFamily: kRubik,
                    ),
                  ),
                  const SizedBox(
                    height: SizeSystem.size5,
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

  Widget priorityStatus(String status) {
    switch (status) {
      case "Medium < 24 hours":
        return Container(
          height: SizeSystem.size15,
          width: SizeSystem.size50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeSystem.size5),
              color: const Color.fromRGBO(232, 16, 27, 0.1)),
          child: const Center(
            child: Text(
              "High",
              style: TextStyle(
                  fontSize: SizeSystem.size10,
                  color: ColorSystem.complimentary),
            ),
          ),
        );
      case "Medium > 24 hours":
        return Container(
          height: SizeSystem.size15,
          width: SizeSystem.size50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeSystem.size5),
              color: const Color.fromRGBO(229, 117, 17, 0.1)),
          child: const Center(
            child: Text(
              "Medium",
              style: TextStyle(
                fontSize: SizeSystem.size10,
                color: ColorSystem.darkOchre,
              ),
            ),
          ),
        );
      case "Medium = 24 hours":
        return Container(
          height: SizeSystem.size15,
          width: SizeSystem.size50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeSystem.size5),
              color: const Color.fromRGBO(92, 52, 220, 0.1)),
          child: const Center(
            child: Text(
              "Low",
              style: TextStyle(
                fontSize: SizeSystem.size10,
                color: ColorSystem.purpleOchre,
              ),
            ),
          ),
        );
    }
    return const SizedBox();
  }
}
