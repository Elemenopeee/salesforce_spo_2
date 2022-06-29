import 'package:flutter/material.dart';

import '../design_system/design_system.dart';
import '../utils/constants.dart';

class CustomDialogAction extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const CustomDialogAction({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(PaddingSystem.padding12),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: SizeSystem.size16,
            fontFamily: kRubik,
          ),
        ),
      ),
    );
  }
}