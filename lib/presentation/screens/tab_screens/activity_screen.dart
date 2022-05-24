import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common_widgets/related_offer_list.dart';
import '../../../design_system/primitives/color_system.dart';
import '../../../design_system/primitives/landing_images.dart';
import '../../../design_system/primitives/music_icons_system.dart';
import '../../../design_system/primitives/padding_system.dart';
import '../../../design_system/primitives/size_system.dart';
import '../../../utils/constants.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: PaddingSystem.padding20),
        child: Column(children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Abandoned Cart",
                  style: TextStyle(
                    fontSize: SizeSystem.size16,
                    fontFamily: kRubik,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      "View All",
                      style: TextStyle(
                        fontSize: SizeSystem.size16,
                        color: ColorSystem.secondary.withOpacity(0.4),
                        fontFamily: kRubik,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: SizeSystem.size20,
          ),
          BrowsingtList(),
          const SizedBox(
            height: SizeSystem.size30,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Browsing History",
                  style: TextStyle(
                    fontSize: SizeSystem.size18,
                    fontFamily: kRubik,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      "View All",
                      style: TextStyle(
                        fontSize: SizeSystem.size16,
                        color: ColorSystem.secondary.withOpacity(0.4),
                        fontFamily: kRubik,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: SizeSystem.size20,
          ),
          AbandonedCartList(),
          const SizedBox(
            height: SizeSystem.size30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Related Offers & Enrolments",
                  style: TextStyle(
                    fontSize: SizeSystem.size18,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      "See More",
                      style: TextStyle(
                        fontSize: SizeSystem.size16,
                        color: ColorSystem.secondary.withOpacity(0.4),
                        fontFamily: kRubik,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: SizeSystem.size20,
          ),
          RelatedOfferList(),
          const SizedBox(
            height: SizeSystem.size30,
          )
        ]));
  }
}

class AbandonedCartList extends StatelessWidget {
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
                getSingleAbandonedCartList(context, index),
              ],
            );
          }),
    );
  }

  Widget getSingleAbandonedCartList(BuildContext context, int index) {
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
          child: SvgPicture.asset(
            listOfRecommendationImage[index],
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class BrowsingtList extends StatelessWidget {
  BrowsingtList({Key? key}) : super(key: key);

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
              getSingleBrowsingtList(context, index),
            ],
          );
        },
      ),
    );
  }

  Widget getSingleBrowsingtList(BuildContext context, int index) {
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
