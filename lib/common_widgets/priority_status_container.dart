import 'package:flutter/material.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/size_system.dart';

class PriorityStatusContainer extends StatelessWidget {
  final String? priorityStatus;
  final BorderRadius? borderRadius;

  const PriorityStatusContainer({
    Key? key,
    this.priorityStatus,
    this.borderRadius,
  }) : super(key: key);

  Color priorityContainerColor(String status) {
    switch (status) {
      case "High":
        return ColorSystem.primary;
      case "Medium":
        return ColorSystem.darkOchre;
      case "Low":
        return ColorSystem.purple;
    }
    return Colors.transparent;
  }

  Color? priorityFontColor(String status) {
    switch (status) {
      case "High":
        return ColorSystem.complimentary;
      case "Medium":
        return ColorSystem.darkOchre;
      case "Low":
        return ColorSystem.purpleSecondary;
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: priorityContainerColor(priorityStatus?.split(" ").first ?? ""),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: SizeSystem.size6, vertical: SizeSystem.size2),
        child: Center(
          child: Text(
            priorityStatus?.split(" ").first ?? "",
            style: TextStyle(
                fontSize: SizeSystem.size10,
                color:
                    priorityFontColor(priorityStatus?.split(" ").first ?? "")),
          ),
        ),
      ),
    );
  }
}
