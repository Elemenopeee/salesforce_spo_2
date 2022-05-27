import 'package:flutter/material.dart';
import 'package:salesforce_spo/common_widgets/open_order_widget.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/landing_images.dart';
import '../design_system/primitives/music_icons_system.dart';
import '../design_system/primitives/size_system.dart';
import '../models/open_order_model.dart';

class OpenOrderList extends StatelessWidget {
  OpenOrderList({Key? key}) : super(key: key);

  List<OpenOrderModel> openOrderData = [
    OpenOrderModel(
      orderImgUrl: LandingImages.guitarNew,
    ),
    OpenOrderModel(
      orderImgUrl: MusicIconsSystem.doubleBass,
    ),
    OpenOrderModel(
      orderImgUrl: MusicIconsSystem.electricGuitar,
    ),
    OpenOrderModel(
      orderImgUrl: LandingImages.guitarNew,
    ),
    OpenOrderModel(
      orderImgUrl: LandingImages.guitarNew,
    ),
    OpenOrderModel(
      orderImgUrl: LandingImages.guitarNew,
    ),
    OpenOrderModel(
      orderImgUrl: LandingImages.guitarNew,
    ),
    OpenOrderModel(
      orderImgUrl: LandingImages.guitarNew,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
      width: double.infinity,
      child: ListView.builder(
        itemCount: openOrderData.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size18),
        itemBuilder: (context, index) {
          var item = openOrderData[index];
          return OpenOrderWidget(
            borderRadius: BorderRadius.circular(SizeSystem.size15),
            borderColor: Colors.transparent,
            containerBgColor: ColorSystem.greyBg,
            orderImage: item.orderImgUrl,
          );
        },
      ),
    );
  }
}
