import 'package:flutter/material.dart';
import 'package:salesforce_spo/design_system/design_system.dart';

class HorizontalMultipleProgressIndicator extends StatelessWidget {
  final double pendingValue;
  final double overdueValue;
  final double unAssignedValue;

  const HorizontalMultipleProgressIndicator({
    Key? key,
    required this.pendingValue,
    required this.overdueValue,
    required this.unAssignedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(SizeSystem.size12),
      child: SizedBox(
        height: 10,
        child: Row(
          children: [
            Expanded(
              flex: (pendingValue *100).toInt(),
              child: Container(
                height: 8,
                child: Row(),
                color: ColorSystem.pieChartGreen,
              ),
            ),
            Expanded(
              flex: (overdueValue * 100).toInt(),
              child: Container(
                height: 8,
                color: ColorSystem.pieChartRed,
              ),
            ),
            Expanded(
              flex: (unAssignedValue * 100).toInt(),
              child: Container(
                height: 8,
                color: ColorSystem.pieChartAmber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
