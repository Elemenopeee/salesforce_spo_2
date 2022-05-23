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
  int selectedIndex = 0;

  var listOfFeatureImages = [
    LandingImages.activityLite,
    LandingImages.orderLite,
    LandingImages.history,
    LandingImages.notes,
    LandingImages.cases,
    LandingImages.promos,
  ];

  var listOfFeatureDarkImages = [
    LandingImages.activityDark,
    LandingImages.orderDark,
    LandingImages.history,
    LandingImages.notesDark,
    LandingImages.casesDark,
    LandingImages.promosDark,
  ];

  var listOfFeature = [
    "Activity",
    "Orders",
    "History",
    "Notes",
    "Cases",
    "Promos"
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
              selectedIndex = index;
            });
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: (selectedIndex == index)
                        ? Colors.black
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: ColorSystem.greyBg,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    (selectedIndex == index)
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
                    color: (selectedIndex == index)
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
