import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../design_system/primitives/size_system.dart';

class OpenOrderWidget extends StatelessWidget {
  final String? orderImage;
  final Color? containerBgColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;

  const OpenOrderWidget({
    Key? key,
    this.orderImage,
    this.containerBgColor,
    this.borderColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(
            border: Border.all(
              color: borderColor!,
            ),
            borderRadius: borderRadius,
            color: containerBgColor,
            // color: ColorSystem.greyBg,
          ),
          child: SvgPicture.asset(
            orderImage!,
            color: Colors.black87,
          ),
        ),
        const SizedBox(
          width: SizeSystem.size18,
        ),
      ],
    );
  }
}
