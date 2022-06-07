import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/common_widgets/browsing_history_widget.dart';
import 'package:salesforce_spo/models/browsing_history_model.dart';
import 'package:salesforce_spo/models/buy_again_model.dart';

import '../../design_system/design_system.dart';
import '../../design_system/primitives/icon_system.dart';
import '../../design_system/primitives/landing_images.dart';
import '../../design_system/primitives/music_icons_system.dart';
import '../../design_system/primitives/size_system.dart';
import '../../services/networking/endpoints.dart';
import '../../utils/constants.dart';

class BrowsingHistoryListTab extends StatefulWidget {

  @override
  State<BrowsingHistoryListTab> createState() => _BrowsingHistoryListTabState();
}

class _BrowsingHistoryListTabState extends State<BrowsingHistoryListTab> {
  List<BrowsingHistoryModel> browserHistoryData = [
    BrowsingHistoryModel(
      productImage: LandingImages.guitarNew,
      productName: "Gisbon Les Paul Standard '60s..",
      productPrice: "129.99",
    ),
    BrowsingHistoryModel(
      productImage: MusicIconsSystem.doubleBass,
      productName: "LYZ BX-100 Amplifier",
      productPrice: "29.99",
    ),
    BrowsingHistoryModel(
      productImage: MusicIconsSystem.electricGuitar,
      productName: "GC Lesson: 30 min, 4 pack",
      productPrice: "211.00",
    ),
    BrowsingHistoryModel(
      productImage: LandingImages.guitarNew,
      productName: "Gisbon Les Paul Standard '60s..",
      productPrice: "129.99",
    ),
    BrowsingHistoryModel(
      productImage: LandingImages.guitarNew,
      productName: "LYZ BX-100 Amplifier",
      productPrice: "29.99",
    ),
    BrowsingHistoryModel(
      productImage: LandingImages.guitarNew,
      productName: "GC Lesson: 30 min, 4 pack",
      productPrice: "211.00",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: SizeSystem.size50,
        ),
        SvgPicture.asset(IconSystem.noDataFound),
        const SizedBox(
          height: SizeSystem.size24,
        ),
        const Text(
          'NO DATA FOUND!',
          style: TextStyle(
            color: ColorSystem.primary,
            fontWeight: FontWeight.bold,
            fontFamily: kRubik,
            fontSize: SizeSystem.size20,
          ),
        )
      ],
    );
  }
}
