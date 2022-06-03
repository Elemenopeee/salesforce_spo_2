import 'package:flutter/material.dart';

import '../design_system/primitives/landing_images.dart';
import '../design_system/primitives/music_icons_system.dart';
import '../design_system/primitives/size_system.dart';
import '../models/customer_might_like_model.dart';
import 'customer_might_like_widget.dart';

class CustomerMightLikeList extends StatelessWidget {
  List<CustomerMightLikeModel> customerLikeData = [
    CustomerMightLikeModel(
      productImage: LandingImages.guitarNew,
      productName: "Gisbon Les Paul Standard '60s..",
      productPrice: "129.99",
    ),
    CustomerMightLikeModel(
      productImage: MusicIconsSystem.doubleBass,
      productName: "LYZ BX-100 Amplifier",
      productPrice: "29.99",
    ),
    CustomerMightLikeModel(
      productImage: MusicIconsSystem.electricGuitar,
      productName: "GC Lesson: 30 min, 4 pack",
      productPrice: "211.00",
    ),
    CustomerMightLikeModel(
      productImage: LandingImages.guitarNew,
      productName: "Gisbon Les Paul Standard '60s..",
      productPrice: "129.99",
    ),
    CustomerMightLikeModel(
      productImage: LandingImages.guitarNew,
      productName: "LYZ BX-100 Amplifier",
      productPrice: "29.99",
    ),
    CustomerMightLikeModel(
      productImage: LandingImages.guitarNew,
      productName: "GC Lesson: 30 min, 4 pack",
      productPrice: "211.00",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: customerLikeData.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          var item = customerLikeData[index];
          return Row(
            children: [
              const SizedBox(
                width: SizeSystem.size18,
              ),
              CustomerMightLikeWidget(
                productName: item.productName ?? "",
                productPrice: item.productPrice ?? "",
                productImage: item.productImage ?? "",
              ),
            ],
          );
        },
      ),
    );
  }
}
