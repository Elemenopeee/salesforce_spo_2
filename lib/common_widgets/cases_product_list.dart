import 'package:flutter/material.dart';
import 'package:salesforce_spo/common_widgets/cases_product_widget.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/models/cases_product_model.dart';

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
      padding: const EdgeInsets.symmetric(
        horizontal: SizeSystem.size10,
      ),
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
              var item = casesProductData[index];
              return CasesProductWidget(
                productImage: item.productImgUrl,
                productName: item.productName,
                productStatus: item.productStatus,
              );
            }),
      ),
    );
  }
}
