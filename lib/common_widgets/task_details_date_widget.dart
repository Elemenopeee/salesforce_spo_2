import 'package:flutter/material.dart';

import '../design_system/design_system.dart';
import '../utils/constants.dart';

class TaskDetailsDateWidget extends StatelessWidget {
  const TaskDetailsDateWidget(
      {Key? key,
        required this.assigned_to_name,
        required this.modified_by_name,
        required this.due_by_date,
        required this.modified_date})
      : super(key: key);

  final String assigned_to_name;
  final String modified_by_name;
  final String due_by_date;
  final String modified_date;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        decoration: BoxDecoration(
            color: const Color(0xff8C80F8).withOpacity(0.08),
            borderRadius: BorderRadius.circular(14.0)),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0), color: Colors.white),
            padding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 14.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Due by:",
                          style: TextStyle(
                              color: Color(0xff2D3142),
                              fontSize: SizeSystem.size14,
                              fontFamily: kRubik,
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          due_by_date.toUpperCase(),
                          style: const TextStyle(
                              color: Color(0xff2D3142),
                              fontSize: SizeSystem.size18,
                              fontFamily: kRubik,
                              fontWeight: FontWeight.w600),
                        ),
                      ]),
                  const Icon(Icons.calendar_month_outlined)
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Assigned to:",
                      style: TextStyle(
                          color: Color(0xff2D3142),
                          fontSize: SizeSystem.size12,
                          fontFamily: kRubik,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Modified by:",
                      style: TextStyle(
                          color: Color(0xff2D3142),
                          fontSize: SizeSystem.size12,
                          fontFamily: kRubik,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(assigned_to_name,
                            style: const TextStyle(
                                color: Color(0xff53A5FF),
                                fontSize: SizeSystem.size12,
                                fontFamily: kRubik,
                                fontWeight: FontWeight.w600))),
                    Text.rich(TextSpan(
                        text: modified_by_name + " ",
                        style: const TextStyle(
                            color: Color(0xff53A5FF),
                            fontSize: SizeSystem.size12,
                            fontFamily: kRubik,
                            fontWeight: FontWeight.w600),
                        children: <InlineSpan>[
                          TextSpan(
                            text: "| " + modified_date,
                            style: const TextStyle(
                                color: Color(0xff2D3142),
                                fontSize: SizeSystem.size12,
                                fontFamily: kRubik,
                                fontWeight: FontWeight.normal),
                          )
                        ])),
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}