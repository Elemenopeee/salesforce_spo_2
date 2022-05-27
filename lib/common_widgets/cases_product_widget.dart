import 'package:flutter/material.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/size_system.dart';
import '../utils/constants.dart';

class CasesProductWidget extends StatelessWidget {
  final String? casesName;
  final String? casesDate;
  final String? casesStatus;
  final String? caseNumber;
  final String? casePriorityStatus;
  final String? userName;
  final Color? statusContainerColor;
  final Color? statusFontColor;

  const CasesProductWidget({
    Key? key,
    this.casesName,
    this.casesDate,
    this.casesStatus,
    this.caseNumber,
    this.casePriorityStatus,
    this.userName,
    this.statusContainerColor,
    this.statusFontColor,
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
                    casesName!,
                    style: const TextStyle(
                      fontSize: SizeSystem.size14,
                      fontFamily: kRubik,
                      color: ColorSystem.primaryTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: SizeSystem.size5,
                  ),
                  Text(
                    casesDate!,
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
                    '${"Last Updated By: "}${userName!}',
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
                  Container(
                    height: SizeSystem.size15,
                    width: SizeSystem.size50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SizeSystem.size5),
                      color: statusContainerColor,
                      // const Color.fromRGBO(232, 16, 27, 0.1)
                    ),
                    child: Center(
                      child: Text(
                        casePriorityStatus!,
                        style: TextStyle(
                          fontSize: SizeSystem.size10,
                          color: statusFontColor!,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: SizeSystem.size5,
                  ),
                  Text(
                    '${"Cases Number: "}${caseNumber!}',
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
                    '${"Status: "}${casesStatus!}',
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
        const Divider(
          thickness: 1,
          color: ColorSystem.greyDivider,
        ),
      ],
    );
  }
}
