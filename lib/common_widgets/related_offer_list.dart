import 'package:flutter/material.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/landing_images.dart';
import '../design_system/primitives/padding_system.dart';
import '../design_system/primitives/size_system.dart';

class RelatedOfferList extends StatelessWidget {
  var listOfOffersImage = [
    LandingImages.icBgGuitar,
    LandingImages.icBgGuitar,
    LandingImages.icBgGuitar,
    LandingImages.icBgGuitar,
    LandingImages.icBgGuitar,
    LandingImages.icBgGuitar,
    LandingImages.icBgGuitar,
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
          itemCount: listOfOffersImage.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Row(
              children: [
                const SizedBox(
                  width: SizeSystem.size18,
                ),
                getSingleOfferList(context, index),
              ],
            );
          }),
    );
  }

  Widget getSingleOfferList(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            image: DecorationImage(
                image: AssetImage(
                  listOfOffersImage[index],
                ),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(20),
            color: ColorSystem.greyBg,
          ),
          child: Padding(
            padding:  const EdgeInsets.symmetric(
                horizontal: PaddingSystem.padding10,
                vertical: PaddingSystem.padding10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Guitar Class - 2.0",
                  style: TextStyle(
                      color: ColorSystem.white, fontSize: SizeSystem.size16),
                ),
                Text(
                  "OFF 10%",
                  style: TextStyle(
                      color: ColorSystem.white, fontSize: SizeSystem.size14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}