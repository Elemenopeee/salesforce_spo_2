import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common_widgets/client_feature_tabs_list.dart';
import '../../common_widgets/get_banner.dart';
import '../../design_system/primitives/landing_images.dart';
import '../../design_system/primitives/padding_system.dart';
import '../../design_system/primitives/size_system.dart';
import '../../utils/constants.dart';

class CasesTab extends StatefulWidget {
  const CasesTab({Key? key}) : super(key: key);

  @override
  _CasesTabState createState() => _CasesTabState();
}

class _CasesTabState extends State<CasesTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: PaddingSystem.padding20,
                    right: PaddingSystem.padding20,
                    top: PaddingSystem.padding20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      LandingImages.drawer,
                      height: SizeSystem.size20,
                      width: SizeSystem.size20,
                      color: const Color(0xFF888888),
                    ),
                    const Text(
                      "CLIENT",
                      style: TextStyle(
                          fontSize: SizeSystem.size14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF222222),
                          fontFamily: kRubik),
                    ),
                    const Text(
                      "LEAVE",
                      style: TextStyle(
                        fontSize: SizeSystem.size14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF888888),
                        fontFamily: kRubik,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: SizeSystem.size30,
              ),
              const GetBanner(),
              const SizedBox(
                height: SizeSystem.size30,
              ),
              const ClientFeatureTabsList(),
              const SizedBox(
                height: SizeSystem.size25,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
