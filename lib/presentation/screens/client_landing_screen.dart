import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/common_widgets/client_feature_tabs_list.dart';
import 'package:salesforce_spo/common_widgets/get_banner.dart';
import 'package:salesforce_spo/common_widgets/open_order_list.dart';
import 'package:salesforce_spo/common_widgets/recommendation_list.dart';
import 'package:salesforce_spo/common_widgets/related_offer_list.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/design_system/primitives/landing_images.dart';

import '../../utils/constants.dart';

class ClientLandingScreen extends StatefulWidget {
  const ClientLandingScreen({Key? key}) : super(key: key);

  @override
  _ClientLandingScreenState createState() => _ClientLandingScreenState();
}

class _ClientLandingScreenState extends State<ClientLandingScreen> {
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
              // const GetCarouselBanner(),
              const SizedBox(
                height: SizeSystem.size30,
              ),
              const ClientFeatureTabsList(),
              const SizedBox(
                height: SizeSystem.size25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PaddingSystem.padding20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Open Orders",
                      style: TextStyle(
                        fontSize: SizeSystem.size16,
                        fontFamily: kRubik,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: SizeSystem.size16,
                            color: ColorSystem.secondary.withOpacity(0.4),
                            fontFamily: kRubik,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: SizeSystem.size20,
              ),
              OpenOrderList(),
              const SizedBox(
                height: SizeSystem.size30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PaddingSystem.padding20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recommendation",
                      style: TextStyle(
                        fontSize: SizeSystem.size18,
                        fontFamily: kRubik,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "View All",
                          style: TextStyle(
                            fontSize: SizeSystem.size16,
                            color: ColorSystem.secondary.withOpacity(0.4),
                            fontFamily: kRubik,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: SizeSystem.size20,
              ),
              RecommendationList(),
              const SizedBox(
                height: SizeSystem.size30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PaddingSystem.padding20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Related Offers & Enrolments",
                      style: TextStyle(
                        fontSize: SizeSystem.size18,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "See More",
                          style: TextStyle(
                            fontSize: SizeSystem.size16,
                            color: ColorSystem.secondary.withOpacity(0.4),
                            fontFamily: kRubik,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: SizeSystem.size20,
              ),
              RelatedOfferList(),
              const SizedBox(
                height: SizeSystem.size30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
