import 'package:flutter/material.dart';
import 'package:salesforce_spo/design_system/primitives/color_system.dart';

Color setBackgroundColor({required int index}) {
  if (index == 0) {
    return ColorSystem.noteBlueColor;
  }

  if (index == 1) {
    return ColorSystem.notePinkColor;
  }

  if (index == 2 || index % 2 == 0) {
    return ColorSystem.noteYellowColor;
  }
  if (index % 3 == 0) {
    return ColorSystem.noteBlueColor;
  }

  return ColorSystem.noteBlueColor;
}
