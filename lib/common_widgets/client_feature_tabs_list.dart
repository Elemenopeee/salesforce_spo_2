import 'package:flutter/material.dart';
import 'package:salesforce_spo/common_widgets/feature_tab_widget.dart';
import 'package:salesforce_spo/models/feature_tab_model.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/landing_images.dart';
import '../design_system/primitives/size_system.dart';

class ClientFeatureTabsList extends StatefulWidget {
  const ClientFeatureTabsList({Key? key}) : super(key: key);

  @override
  State<ClientFeatureTabsList> createState() => _ClientFeatureTabsListState();
}

class _ClientFeatureTabsListState extends State<ClientFeatureTabsList> {
  int selectedList = 0;

  List<FeatureTabModel> featureTabData = [
    FeatureTabModel(
      selectedImgUrl: LandingImages.orderLite,
      unSelectedImgUrl: LandingImages.orderDark,
      featureTabName: "Orders",
    ),
    FeatureTabModel(
      selectedImgUrl: LandingImages.activityLite,
      unSelectedImgUrl: LandingImages.activityDark,
      featureTabName: "Recom.",
    ),
    FeatureTabModel(
      selectedImgUrl: LandingImages.history,
      unSelectedImgUrl: LandingImages.history,
      featureTabName: "Recent",
    ),
    FeatureTabModel(
      selectedImgUrl: LandingImages.notes,
      unSelectedImgUrl: LandingImages.notes,
      featureTabName: "Notes",
    ),
    FeatureTabModel(
      selectedImgUrl: LandingImages.casesLight,
      unSelectedImgUrl: LandingImages.casesDark,
      featureTabName: "Cases",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
          itemCount: featureTabData.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size18),
          itemBuilder: (context, index) {
            var item = featureTabData[index];
            return FeatureTabWidget(
              image: (selectedList == index)
                  ? item.selectedImgUrl
                  : item.unSelectedImgUrl,
              borderColor:
                  (selectedList == index) ? Colors.black : Colors.transparent,
              borderRadius: BorderRadius.circular(SizeSystem.size15),
              onTap: () {
                setState(() {
                  (selectedList = index);
                });
              },
              containerBgColor: ColorSystem.greyBg,
              tabName: item.featureTabName,
              textColor: (selectedList == index)
                  ? ColorSystem.primary
                  : ColorSystem.secondary,
            );
          }),
    );
  }
}
