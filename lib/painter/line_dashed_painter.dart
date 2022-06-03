import 'package:flutter/material.dart';
import 'package:salesforce_spo/design_system/design_system.dart';

class LineDashedPainter extends CustomPainter {

  final double height;

  LineDashedPainter({this.height = 40});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 1
      ..color = ColorSystem.secondary;
    var max = height;
    var dashWidth = 4;
    var dashSpace = 2;
    double startY = 0;
    while (max >= 0) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      final space = (dashSpace + dashWidth);
      startY += space;
      max -= space;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}