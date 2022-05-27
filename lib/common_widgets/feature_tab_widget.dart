import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../design_system/primitives/size_system.dart';
import '../utils/constants.dart';

class FeatureTabWidget extends StatelessWidget {
  final Color? containerBgColor;
  final Color? borderColor;
  final Color? textColor;
  final BorderRadius? borderRadius;
  final Function? onTap;
  final String? image;
  final String? tabName;

  const FeatureTabWidget({
    Key? key,
    this.containerBgColor,
    this.borderColor,
    this.borderRadius,
    this.onTap,
    this.image,
    this.tabName,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () => onTap!() ?? () {},
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.072,
                width: MediaQuery.of(context).size.height * 0.072,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: borderColor!,
                  ),
                  borderRadius: borderRadius!,
                  color: containerBgColor!,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    image!,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                tabName!,
                style: TextStyle(
                  color: textColor!,
                  fontFamily: kRubik,
                  fontSize: SizeSystem.size14,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: SizeSystem.size18,
        ),
      ],
    );
  }
}
