import 'package:flutter/material.dart';
import 'package:salesforce_spo/design_system/design_system.dart';

import '../utils/constants.dart';

class TGCAppBar extends AppBar {
  final String label;
  final bool titleCentered;
  final List<Widget>? leftDrawerActions;
  final Widget? leadingWidget;

  TGCAppBar({
    Key? key,
    this.label = '',
    this.titleCentered = true,
    this.leftDrawerActions = const [],
    this.leadingWidget,
  }) : super(
          key: key,
          title: Text(
            label,
            style: const TextStyle(
              fontSize: SizeSystem.size18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: kRubik,
            ),
          ),
          centerTitle: titleCentered,
          actions: leftDrawerActions,
          leading: leadingWidget,
          // leadingWidth: 24,
          elevation: 0,
          backgroundColor: ColorSystem.scaffoldBackgroundColor,
        );
}
