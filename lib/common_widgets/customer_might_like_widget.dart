import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/size_system.dart';

class CustomerMightLikeWidget extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String productImage;
  const CustomerMightLikeWidget({
    Key? key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(15),
            color: ColorSystem.greyBg,
          ),
          child: SvgPicture.asset(
            productImage,
            color: Colors.black87,
            height: 150,
            width: 150,
          ),
        ),
        const SizedBox(
          height: SizeSystem.size5,
        ),
        FittedBox(
          child: Text(
            productName,
            style: const TextStyle(
              fontSize: SizeSystem.size12,
              color: ColorSystem.primaryTextColor,
            ),
          ),
        ),
        const SizedBox(
          height: SizeSystem.size8,
        ),
        Text(
          productPrice,
          style: const TextStyle(
            fontSize: SizeSystem.size12,
            color: ColorSystem.primaryTextColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
