import 'package:flutter/material.dart';
import 'package:salesforce_spo/design_system/primitives/color_system.dart';
import 'package:salesforce_spo/design_system/primitives/size_system.dart';
import 'package:salesforce_spo/utils/constants.dart';

class AgentTaskCountTile extends StatefulWidget {
  const AgentTaskCountTile(
      {Key? key,
        required this.onTap,
      required this.employeeName,
      required this.overdueTaskCount,
      required this.pendingTaskCount})
      : super(key: key);
  final String? employeeName;
  final int overdueTaskCount;
  final int pendingTaskCount;
  final VoidCallback onTap;
  @override
  State<AgentTaskCountTile> createState() => _AgentTaskCountTileState();
}

class _AgentTaskCountTileState extends State<AgentTaskCountTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.employeeName!,
                style: const TextStyle(
                  fontSize: SizeSystem.size16,
                  fontFamily: kRubik,
                  fontWeight: FontWeight.w500,
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: (widget.pendingTaskCount > 0)
                      ? TextSpan(
                          style: const TextStyle(
                            fontFamily: kRubik,
                          ),
                          children: [
                            TextSpan(
                              text: widget.pendingTaskCount.toString(),
                              style: const TextStyle(
                                  fontFamily: kRubik,
                                  fontSize: SizeSystem.size14,
                                  color: Colors.black),
                            ),
                            const TextSpan(
                              text: ' Pending',
                              style: TextStyle(
                                  fontFamily: kRubik,
                                  fontSize: SizeSystem.size12,
                                  color: Colors.black),
                            ),
                          ],
                        )
                      : const TextSpan(
                          style: TextStyle(
                            fontFamily: kRubik,
                          ),
                          children: [
                            TextSpan(
                              text: 'No Pending',
                              style: TextStyle(
                                  fontFamily: kRubik,
                                  fontSize: SizeSystem.size12,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                ),
                if (widget.overdueTaskCount > 0)
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: kRubik,
                      ),
                      children: [
                        TextSpan(
                          text: widget.overdueTaskCount.toString(),
                          style: const TextStyle(
                              fontFamily: kRubik,
                              fontSize: SizeSystem.size12,
                              color: Colors.red),
                        ),
                        const TextSpan(
                          text: ' Overdue',
                          style: TextStyle(
                              fontFamily: kRubik,
                              fontSize: SizeSystem.size12,
                              color: Colors.red),
                        ),
                      ],
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
