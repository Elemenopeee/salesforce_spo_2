import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/landing_images.dart';
import '../design_system/primitives/music_icons_system.dart';
import '../design_system/primitives/size_system.dart';

class RecommendationList extends StatelessWidget {
  var listOfRecommendationImage = [
    MusicIconsSystem.bassoon,
    MusicIconsSystem.bassGuitar,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
    MusicIconsSystem.bassGuitar,
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
          itemCount: listOfRecommendationImage.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Row(
              children: [
                const SizedBox(
                  width: SizeSystem.size18,
                ),
                getSingleRecommendationList(context, index),
              ],
            );
          }),
    );
  }

  Widget getSingleRecommendationList(BuildContext context, int index) {
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
            color: ColorSystem.culturedGrey,
          ),
          child: SvgPicture.asset(
            listOfRecommendationImage[index],
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}