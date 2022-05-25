import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/models/cases_product_model.dart';
import 'package:salesforce_spo/utils/constants.dart';

import '../design_system/primitives/landing_images.dart';
import '../design_system/primitives/music_icons_system.dart';

class CasesProductList extends StatefulWidget {
  const CasesProductList({Key? key}) : super(key: key);

  @override
  _CasesProductListState createState() => _CasesProductListState();
}

class _CasesProductListState extends State<CasesProductList> {

  List<CasesProductModel> casesProductData = [
    CasesProductModel(
      productName: "Product Name",
      productStatus: "Broken Product",
      productImgUrl: LandingImages.verticalGuitar1,
    ),
    CasesProductModel(
      productName: "Product Name",
      productStatus: "Returned",
      productImgUrl: LandingImages.verticalGuitar2,
    ),
    CasesProductModel(
      productName: "Guitar Name",
      productStatus: "Refund initiated",
      productImgUrl: LandingImages.verticalGuitar3,
    ),
    CasesProductModel(
      productName: "Guitar Name",
      productStatus: "Wrong Product",
      productImgUrl: MusicIconsSystem.doubleBass,
    ),
    CasesProductModel(
      productName: "Product Name",
      productStatus: "Returned",
      productImgUrl: MusicIconsSystem.electricGuitar,
    ),
    CasesProductModel(
      productName: "Product Name",
      productStatus: "Refund initiated",
      productImgUrl: LandingImages.verticalGuitar3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size10,),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.83,
        width: double.infinity,
        child: GridView.builder(
            itemCount: casesProductData.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 4 / 5,
              crossAxisSpacing: 07,
              mainAxisSpacing: 00,
            ),
            itemBuilder: (context, index) {
              return getSingleCasesList(context, index);
            }),
      ),
    );
  }

  Widget getSingleCasesList(BuildContext context, int index) {
    var item = casesProductData[index];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size8),
      child: Column(
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
              padding: const EdgeInsets.only(bottom: SizeSystem.size5),
              child:
                  SvgPicture.asset(item.productImgUrl, color: Colors.black87),
            ),
          ),
          const SizedBox(
            height: SizeSystem.size10,
          ),
          Text(
            item.productName,
            style: const TextStyle(
                fontSize: SizeSystem.size16, fontFamily: kRubik),
          ),
          const SizedBox(
            height: SizeSystem.size10,
          ),
          Text(
            item.productStatus,
            style: const TextStyle(
                fontSize: SizeSystem.size13, fontFamily: kRubik),
          ),
        ],
      ),
    );
  }
}
