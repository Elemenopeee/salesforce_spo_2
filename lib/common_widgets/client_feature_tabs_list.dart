import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/landing_images.dart';
import '../design_system/primitives/size_system.dart';
import '../utils/constants.dart';

class ClientFeatureTabsList extends StatefulWidget {
  const ClientFeatureTabsList({Key? key}) : super(key: key);

  @override
  State<ClientFeatureTabsList> createState() => _ClientFeatureTabsListState();
}

class _ClientFeatureTabsListState extends State<ClientFeatureTabsList> {
  int selectedList = 0;

  var listOfFeatureImages = [
    LandingImages.activityLite,
    LandingImages.orderLite,
    LandingImages.history,
    LandingImages.notes,
    LandingImages.cases,
  ];

  var listOfFeatureDarkImages = [
    LandingImages.activityDark,
    LandingImages.orderDark,
    LandingImages.history,
    LandingImages.notes,
    LandingImages.cases,
  ];

  var listOfFeature = [
    "Activity",
    "Orders",
    "History",
    "Notes",
    "Cases",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
          itemCount: listOfFeature.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Row(
              children: [
                const SizedBox(
                  width: SizeSystem.size18,
                ),
                getSingleFeatureList(context, index),
              ],
            );
          }),
    );
  }

  Widget getSingleFeatureList(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              selectedList = index;
            });
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: (selectedList == index)
                        ? Colors.black
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: ColorSystem.greyBg,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    (selectedList == index)
                        ? listOfFeatureDarkImages[index]
                        : listOfFeatureImages[index],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                listOfFeature[index],
                style: TextStyle(
                    color: (selectedList == index)
                        ? ColorSystem.primary
                        : ColorSystem.secondary,
                    fontFamily: kRubik,
                    fontSize: SizeSystem.size14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}