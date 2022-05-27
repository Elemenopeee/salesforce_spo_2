import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/size_system.dart';
import '../utils/constants.dart';

class CasesProductWidget extends StatelessWidget {
  final String? productImage;
  final String? productName;
  final String? productStatus;

  const CasesProductWidget({
    Key? key,
    this.productImage,
    this.productName,
    this.productStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.19,
            width: MediaQuery.of(context).size.height * 0.21,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(15),
              color: ColorSystem.secondaryGreyBg,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: SizeSystem.size5),
              child: SvgPicture.asset(productImage!, color: Colors.black87),
            ),
          ),
          const SizedBox(
            height: SizeSystem.size10,
          ),
          Text(
            productName!,
            style: const TextStyle(
                fontSize: SizeSystem.size16, fontFamily: kRubik),
          ),
          const SizedBox(
            height: SizeSystem.size10,
          ),
          Text(
            productStatus!,
            style: const TextStyle(
                fontSize: SizeSystem.size13, fontFamily: kRubik),
          ),
        ],
      ),
    );
  }
}
