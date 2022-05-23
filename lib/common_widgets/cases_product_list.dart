import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/utils/constants.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/landing_images.dart';
import '../design_system/primitives/music_icons_system.dart';

class CasesProductList extends StatefulWidget {
  const CasesProductList({Key? key}) : super(key: key);

  @override
  _CasesProductListState createState() => _CasesProductListState();
}

class _CasesProductListState extends State<CasesProductList> {
  var listOfCasesImage = [
    LandingImages.verticalGuitar1,
    LandingImages.verticalGuitar2,
    LandingImages.verticalGuitar3,
    MusicIconsSystem.doubleBass,
    MusicIconsSystem.electricGuitar,
    LandingImages.verticalGuitar3,
  ];

  var listOfProductName = [
    "Product Name",
    "Product Name",
    "Guitar Name",
    "Guitar Name",
    "Product Name",
    "Product Name",
  ];

  var listOfProductStatus = [
    "Broken Product",
    "Returned",
    "Refund initiated",
    "Wrong Product",
    "Returned",
    "Refund initiated",
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.83,
        width: double.infinity,
        child: GridView.builder(
            itemCount: listOfCasesImage.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 4 / 5,
              crossAxisSpacing: 07,
              mainAxisSpacing: 00,
            ),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  getSingleCasesList(context, index),
                ],
              );
            }),
      ),
    );
  }

  Widget getSingleCasesList(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.19,
          width: 180,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(15),
            color: ColorSystem.secondaryGreyBg,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 05),
            child: SvgPicture.asset(listOfCasesImage[index],
                color: Colors.black87),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          listOfProductName[index],
          style: const TextStyle(fontSize: 16, fontFamily: kRubik),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          listOfProductStatus[index],
          style: const TextStyle(fontSize: 13, fontFamily: kRubik),
        ),
      ],
    );
  }
}
