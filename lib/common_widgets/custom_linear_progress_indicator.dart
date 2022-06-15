import 'package:flutter/material.dart';


class CustomLinearProgressIndicator extends StatelessWidget {
  final EdgeInsets? containerMargin;
  final double? containerHeight;
  final double? containerWidth;
  final Color? indicatorValueColor;
  final Color? indicatorBackgroundColor;
  final BorderRadius? containerRadius;
  final double? indicatorValue;

  const CustomLinearProgressIndicator({
    Key? key,
    this.containerMargin,
    this.containerHeight,
    this.containerWidth,
    this.indicatorValueColor,
    this.indicatorBackgroundColor,
    this.containerRadius,
    this.indicatorValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: containerMargin,
      width: containerWidth,
      height: containerHeight,
      child: ClipRRect(
        borderRadius: containerRadius,
        child: LinearProgressIndicator(
          value: indicatorValue,
          valueColor: AlwaysStoppedAnimation<Color>(indicatorValueColor!),
          backgroundColor: indicatorBackgroundColor,
        ),
      ),
    );
  }
}