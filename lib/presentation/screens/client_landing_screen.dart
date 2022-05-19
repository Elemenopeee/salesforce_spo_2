import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/design_system/primitives/landing_images.dart';
import 'package:salesforce_spo/design_system/primitives/music_icons_system.dart';

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
            children: [
              getAppBar(),
              const SizedBox(
                height: SizeSystem.size30,
              ),
              const GetCarouselBanner(),
              const SizedBox(
                height: SizeSystem.size30,
              ),
              const GetFeatureList(),
              const SizedBox(
                height: SizeSystem.size25,
              ),
              getOpenOrderHeader(),
              const SizedBox(
                height: SizeSystem.size20,
              ),
              OpenOrderList(),
              const SizedBox(
                height: SizeSystem.size30,
              ),
              getRecommendationHeader(),
              const SizedBox(
                height: SizeSystem.size20,
              ),
              RecommendationList(),
              const SizedBox(
                height: SizeSystem.size30,
              ),
              getOffersHeader(),
              const SizedBox(
                height: SizeSystem.size20,
              ),
              OfferList(),
              const SizedBox(
                height: SizeSystem.size30,
              ),
            ],
          ),
        ),
      ),
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
    );
  }

  Widget getOpenOrderHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
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
    );
  }

  Widget getRecommendationHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
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
    );
  }

  Widget getOffersHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
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
    );
  }
}

class GetCarouselBanner extends StatefulWidget {
  const GetCarouselBanner({Key? key}) : super(key: key);

  @override
  State<GetCarouselBanner> createState() => _GetCarouselBannerState();
}

class _GetCarouselBannerState extends State<GetCarouselBanner> {
  int currentPos = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: CarouselSlider(
        items: [
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: 4.0, horizontal: PaddingSystem.padding10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorSystem.greyBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PaddingSystem.padding20,
                    vertical: PaddingSystem.padding20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      getFirstContainer(),
                      const SizedBox(
                        height: SizeSystem.size8,
                      ),
                      getSecondContainer(),
                      const SizedBox(
                        height: SizeSystem.size8,
                      ),
                      getThirdContainer(),
                    ]),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                vertical: 4.0, horizontal: PaddingSystem.padding10),
            child: Container(
              decoration: BoxDecoration(
                color: ColorSystem.pink,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                vertical: 4.0, horizontal: PaddingSystem.padding10),
            child: Container(
              decoration: BoxDecoration(
                color: ColorSystem.purple,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
        options: CarouselOptions(
            height: 190,
            autoPlay: false,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, reason) {
              setState(() {
                currentPos = index;
              });
            }),
      ),
    );
  }

  Widget getFirstContainer() {
    return Row(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontFamily: kRubik,
            ),
            children: [
              TextSpan(
                text: 'Jessica Mendez ',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: SizeSystem.size16,
                  color: ColorSystem.primaryTextColor,
                ),
              ),
              TextSpan(
                text: '• GC',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: SizeSystem.size16,
                  color: ColorSystem.secondary,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        SvgPicture.asset(
          IconSystem.badge,
          height: 15,
          width: 15,
          color: ColorSystem.complimentary,
        ),
        const SizedBox(
          width: 04,
        ),
        const Text(
          "High",
          style: TextStyle(
            fontFamily: kRubik,
            fontWeight: FontWeight.w600,
            color: ColorSystem.complimentary,
            fontSize: SizeSystem.size12,
          ),
        ),
      ],
    );
  }

  Widget getSecondContainer() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          children: [
            SvgPicture.asset(
              LandingImages.guitarSolidIcon,
              width: SizeSystem.size25,
              height: SizeSystem.size25,
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
        const SizedBox(
          width: SizeSystem.size10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: SizeSystem.size10,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  fontFamily: kRubik,
                ),
                children: [
                  TextSpan(
                    text: 'Guitarist |',
                    style: TextStyle(
                      fontSize: SizeSystem.size12,
                      color: ColorSystem.primary,
                      fontFamily: kRubik,
                    ),
                  ),
                  TextSpan(
                    text: ' Buy Used',
                    style: TextStyle(
                      fontSize: SizeSystem.size12,
                      color: ColorSystem.primary,
                      fontFamily: kRubik,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: SizeSystem.size5,
            ),
            const Text(
              "Visited on : 12-Mar-2022",
              style: TextStyle(
                fontFamily: kRubik,
                color: ColorSystem.primary,
                fontSize: SizeSystem.size12,
              ),
            ),
            const SizedBox(
              height: SizeSystem.size20,
            ),
          ],
        ),
      ],
    );
  }

  Widget getThirdContainer() {
    return Expanded(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "L. PURCHASE",
                style: TextStyle(
                  fontFamily: kRubik,
                  color: ColorSystem.secondary,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeSystem.size10,
                ),
              ),
              const SizedBox(
                height: SizeSystem.size5,
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: kRubik,
                  ),
                  children: [
                    TextSpan(
                      text: '1.5 ',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: SizeSystem.size24,
                      ),
                    ),
                    TextSpan(
                      text: 'k',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        // fontWeight: FontWeight.w700,
                        fontSize: SizeSystem.size12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
            child: VerticalDivider(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              thickness: 1,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "LTV",
                style: TextStyle(
                  fontFamily: kRubik,
                  color: ColorSystem.secondary,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeSystem.size10,
                ),
              ),
              const SizedBox(
                height: SizeSystem.size5,
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: kRubik,
                  ),
                  children: [
                    TextSpan(
                      text: '105.5 ',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: SizeSystem.size24,
                      ),
                    ),
                    TextSpan(
                      text: 'k',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        // fontWeight: FontWeight.w700,
                        fontSize: SizeSystem.size12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 50,
            child: VerticalDivider(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              thickness: 1,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "AVG. ORDER",
                style: TextStyle(
                  fontFamily: kRubik,
                  color: ColorSystem.secondary,
                  fontWeight: FontWeight.w500,
                  fontSize: SizeSystem.size10,
                ),
              ),
              const SizedBox(
                height: SizeSystem.size5,
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: kRubik,
                  ),
                  children: [
                    TextSpan(
                      text: '26.2 ',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: SizeSystem.size24,
                      ),
                    ),
                    TextSpan(
                      text: 'k',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        // fontWeight: FontWeight.w700,
                        fontSize: SizeSystem.size12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GetFeatureList extends StatefulWidget {
  const GetFeatureList({Key? key}) : super(key: key);

  @override
  State<GetFeatureList> createState() => _GetFeatureListState();
}

class _GetFeatureListState extends State<GetFeatureList> {
  int selectedList = 0;

  var listOfFeatureImages = [
    LandingImages.activityLite,
    LandingImages.orderLite,
    LandingImages.history,
    LandingImages.notes,
    LandingImages.cases,
  ];

  var listOfFeatureDarkImages = [
    LandingImages.activityDark,
    LandingImages.orderDark,
    LandingImages.history,
    LandingImages.notes,
    LandingImages.cases,
  ];

  var listOfFeature = [
    "Activity",
    "Orders",
    "History",
    "Notes",
    "Cases",
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
          itemCount: listOfFeature.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Row(
              children: [
                const SizedBox(
                  width: SizeSystem.size18,
                ),
                getSingleFeatureList(context, index),
              ],
            );
          }),
    );
  }

  Widget getSingleFeatureList(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              selectedList = index;
            });
          },
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: (selectedList == index)
                        ? Colors.black
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  color: ColorSystem.greyBg,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    (selectedList == index)
                        ? listOfFeatureDarkImages[index]
                        : listOfFeatureImages[index],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                listOfFeature[index],
                style: TextStyle(
                    color: (selectedList == index)
                        ? ColorSystem.primary
                        : ColorSystem.secondary,
                    fontFamily: kRubik,
                    fontSize: SizeSystem.size14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OpenOrderList extends StatelessWidget {
  OpenOrderList({Key? key}) : super(key: key);

  var listOfOrderImage = [
    LandingImages.guitarNew,
    MusicIconsSystem.doubleBass,
    MusicIconsSystem.electricGuitar,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
        itemCount: listOfOrderImage.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Row(
            children: [
              const SizedBox(
                width: SizeSystem.size18,
              ),
              getSingleOpenOrderList(context, index),
            ],
          );
        },
      ),
    );
  }

  Widget getSingleOpenOrderList(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(15),
            color: ColorSystem.greyBg,
          ),
          child:
              SvgPicture.asset(listOfOrderImage[index], color: Colors.black87),
        ),
      ],
    );
  }
}

class RecommendationList extends StatelessWidget {
  var listOfRecommendationImage = [
    MusicIconsSystem.bassoon,
    MusicIconsSystem.bassGuitar,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
    MusicIconsSystem.bassGuitar,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
    LandingImages.guitarNew,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
          itemCount: listOfRecommendationImage.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Row(
              children: [
                const SizedBox(
                  width: SizeSystem.size18,
                ),
                getSingleRecommendationList(context, index),
              ],
            );
          }),
    );
  }

  Widget getSingleRecommendationList(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(15),
            color: ColorSystem.greyBg,
          ),
          child: SvgPicture.asset(
            listOfRecommendationImage[index],
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class OfferList extends StatelessWidget {
  var listOfOffersImage = [
    LandingImages.icBgGuitar,
    LandingImages.icBgGuitar,
    LandingImages.icBgGuitar,
    LandingImages.icBgGuitar,
    LandingImages.icBgGuitar,
    LandingImages.icBgGuitar,
    LandingImages.icBgGuitar,
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ListView.builder(
          itemCount: listOfOffersImage.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Row(
              children: [
                const SizedBox(
                  width: SizeSystem.size18,
                ),
                getSingleOfferList(context, index),
              ],
            );
          }),
    );
  }

  Widget getSingleOfferList(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            image: DecorationImage(
                image: AssetImage(
                  listOfOffersImage[index],
                ),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(20),
            color: ColorSystem.greyBg,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: PaddingSystem.padding10,
                vertical: PaddingSystem.padding10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Guitar Class - 2.0",
                  style: TextStyle(
                      color: ColorSystem.white, fontSize: SizeSystem.size16),
                ),
                Text(
                  "OFF 10%",
                  style: TextStyle(
                      color: ColorSystem.white, fontSize: SizeSystem.size14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
