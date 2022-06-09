import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/common_widgets/client_feature_tabs_list.dart';
import 'package:salesforce_spo/common_widgets/client_carousel.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/design_system/primitives/landing_images.dart';
import '../../common_widgets/notched_bottom_navigation_bar.dart';
import '../../utils/constants.dart';

class ClientLandingScreen extends StatefulWidget {
  final String customerID;
  final String epsilonCustomerKey;

  const ClientLandingScreen(
      {required this.customerID, required this.epsilonCustomerKey, Key? key})
      : super(key: key);

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
            children: [
              getAppBar(),
              const SizedBox(
                height: SizeSystem.size30,
              ),
              ClientCarousel(
                customerId: widget.customerID,
                epsilonCustomerKey: widget.epsilonCustomerKey,
              ),
              // const GetCarouselBanner(),
              const SizedBox(
                height: SizeSystem.size30,
              ),
              ClientFeatureTabsList(
                customerId: widget.customerID,
              ),
            ],
          ),
        ),
      ),
        bottomNavigationBar: NotchedBottomNavigationBar(
          actions: [
            IconButton(
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: null,
              icon: SvgPicture.asset(
                IconSystem.user,
                width: 24,
                height: 24,
                color: ColorSystem.secondary,
              ),
            ),
            IconButton(
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {},
              icon: SvgPicture.asset(
                IconSystem.feed,
                width: 24,
                height: 24,
                color: ColorSystem.primary,
              ),
            ),
            IconButton(
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {},
              icon: SvgPicture.asset(
                IconSystem.sparkle,
                width: 24,
                height: 24,
                color: ColorSystem.primary,
              ),
            ),
            IconButton(
              focusColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: null,
              icon: SvgPicture.asset(
                IconSystem.more,
                width: 24,
                height: 24,
                color: ColorSystem.primary,
              ),
            ),
          ],
          centerButton: FloatingActionButton(
            backgroundColor: ColorSystem.primary,
            onPressed: () async {

            },
            child: SvgPicture.asset(
              IconSystem.plus,
              width: 24,
              height: 24,
              color: ColorSystem.white,
            ),
          ),
        )
    );
  }

  Widget getAppBar() {
    return Padding(
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
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: SvgPicture.asset(IconSystem.leaveIcon),
          ),
        ],
      ),
    );
  }
}
