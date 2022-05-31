import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/landing_images.dart';
import '../design_system/primitives/music_icons_system.dart';
import '../design_system/primitives/size_system.dart';

class OpenOrderList extends StatelessWidget {
  OpenOrderList({Key? key}) : super(key: key);

  var listOfOrderImage = [
    LandingImages.guitarNew,
    MusicIconsSystem.doubleBass,
    MusicIconsSystem.electricGuitar,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
        itemCount: listOfOrderImage.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Row(
            children: [
              const SizedBox(
                width: SizeSystem.size18,
              ),
              getSingleOpenOrderList(context, index),
            ],
          );
        },
      ),
    );
  }

  Widget getSingleOpenOrderList(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(15),
            color: ColorSystem.greyBg,
          ),
          child:
          SvgPicture.asset(listOfOrderImage[index], color: Colors.black87),
        ),
      ],
    );
  }
}