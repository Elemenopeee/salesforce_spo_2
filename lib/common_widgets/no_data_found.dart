import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../design_system/primitives/icon_system.dart';
import '../design_system/primitives/padding_system.dart';
import '../design_system/primitives/size_system.dart';
import '../utils/constants.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: PaddingSystem.padding40),
      SvgPicture.asset(IconSystem.nothingFound),
      const SizedBox(height: PaddingSystem.padding20),
      const Text(
        'NO DATA FOUND !',
        style: TextStyle(
            fontSize: SizeSystem.size24,
            fontWeight: FontWeight.bold,
            fontFamily: kRubik),
      )
    ]);
  }
}
