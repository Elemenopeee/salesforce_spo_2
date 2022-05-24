import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/design_system/primitives/padding_system.dart';
import 'package:salesforce_spo/design_system/primitives/size_system.dart';
import 'package:salesforce_spo/utils/constants.dart';

import '../../../design_system/primitives/color_system.dart';
import '../../../design_system/primitives/landing_images.dart';
import '../../../design_system/primitives/music_icons_system.dart';

class CasesProductList extends StatefulWidget {
  const CasesProductList({Key? key}) : super(key: key);

  @override
  _CasesProductListState createState() => _CasesProductListState();
}

class _CasesProductListState extends State<CasesProductList> {
  var listOfCasesImage = [
    LandingImages.guitarNew,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
    MusicIconsSystem.bassGuitar,
    MusicIconsSystem.bassGuitar,
    LandingImages.guitar,
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
      padding: const EdgeInsets.symmetric(
          horizontal: PaddingSystem.padding10,
          vertical: PaddingSystem.padding20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.83,
        width: double.infinity,
        child: GridView.builder(
            itemCount: listOfCasesImage.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.7,
              crossAxisSpacing: SizeSystem.size8,
              mainAxisSpacing: SizeSystem.size0,
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
          height: MediaQuery.of(context).size.height * 0.20,
          width: MediaQuery.of(context).size.height * 0.20,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(SizeSystem.size15),
            color: ColorSystem.secondaryGreyBg,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: SizeSystem.size5),
            child: SvgPicture.asset(listOfCasesImage[index],
                color: Colors.black87),
          ),
        ),
        const SizedBox(
          height: SizeSystem.size10,
        ),
        Text(
          listOfProductName[index],
          style:
              const TextStyle(fontSize: SizeSystem.size16, fontFamily: kRubik),
        ),
        const SizedBox(
          height: SizeSystem.size10,
        ),
        Text(
          listOfProductStatus[index],
          style:
              const TextStyle(fontSize: SizeSystem.size12, fontFamily: kRubik),
        ),
        const SizedBox(
          height: SizeSystem.size10,
        ),
      ],
    );
  }
}
