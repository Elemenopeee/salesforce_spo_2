import 'package:flutter/material.dart';
import 'package:salesforce_spo/common_widgets/recommendation_widget.dart';
import 'package:salesforce_spo/models/recommendation_product_model.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/landing_images.dart';
import '../design_system/primitives/music_icons_system.dart';
import '../design_system/primitives/size_system.dart';

class RecommendationList extends StatelessWidget {
  List<RecommendationProductModel> recommendationData = [
    RecommendationProductModel(
      imgUrl: MusicIconsSystem.bassoon,
    ),
    RecommendationProductModel(
      imgUrl: MusicIconsSystem.bassGuitar,
    ),
    RecommendationProductModel(
      imgUrl: LandingImages.guitarNew,
    ),
    RecommendationProductModel(
      imgUrl: LandingImages.guitarNew,
    ),
    RecommendationProductModel(
      imgUrl: MusicIconsSystem.bassGuitar,
    ),
    RecommendationProductModel(
      imgUrl: LandingImages.guitarNew,
    ),
    RecommendationProductModel(
      imgUrl: LandingImages.guitarNew,
    ),
    RecommendationProductModel(
      imgUrl: LandingImages.guitarNew,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
      width: double.infinity,
      child: ListView.builder(
          itemCount: recommendationData.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size18),
          itemBuilder: (context, index) {
            var item = recommendationData[index];
            return RecommendationWidget(
              borderRadius: BorderRadius.circular(SizeSystem.size15),
              borderColor: Colors.transparent,
              containerBgColor: ColorSystem.greyBg,
              orderImage: item.imgUrl,
            );
          }),
    );
  }
}
