import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../design_system/primitives/color_system.dart';

Color getCustomerLevelColor(String level) {
  switch (level) {
    case 'LOW':
      return ColorSystem.purple;
    case 'MEDIUM':
      return ColorSystem.darkOchre;
    case 'HIGH':
      return ColorSystem.complimentary;
    default:
      return ColorSystem.complimentary;
  }
}

String getCustomerLevel(double ltv) {
  if (ltv <= 500) {
    return 'LOW';
  } else if (ltv > 500 && ltv <= 1000) {
    return 'MEDIUM';
  } else {
    return 'HIGH';
  }
}

double aovCalculator(double? ltv, double? lnt) {
  if (ltv != null && lnt != null) {
    return ltv / lnt;
  } else {
    return 0;
  }
}

String formattedNumber(double value) {
  var f = NumberFormat.compact(locale: "en_US");
  return f.format(value);
}