import 'package:carousel_slider/carousel_slider.dart';
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
                height: 30,
              ),
              const GetCarouselBanner(),
              const SizedBox(
                height: 30,
              ),
              const GetFeatureList(),
              const SizedBox(
                height: 30,
              ),
              getOpenOrderHeader(),
              const SizedBox(
                height: 10,
              ),
              OpenOrderList(),
              const SizedBox(
                height: 20,
              ),
              getRecommendationHeader(),
              const SizedBox(
                height: 10,
              ),
              RecommendationList(),
              const SizedBox(
                height: 20,
              ),
              getOffersHeader(),
              const SizedBox(
                height: 20,
              ),
              OfferList(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            LandingImages.icDrawer,
            height: 20,
            width: 20,
            color: Colors.grey,
          ),
          const Text(
            "CLIENT",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: kRubik),
          ),
          const Text(
            "LEAVE",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: kRubik,
            ),
          ),
        ],
      ),
    );
  }

  Widget getOpenOrderHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Open Orders",
            style: TextStyle(
              fontSize: 22,
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
                  fontSize: 16,
                  color: Colors.grey.withOpacity(0.6),
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Recommendation",
            style: TextStyle(
              fontSize: 22,
              fontFamily: kRubik,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "View All",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.withOpacity(0.6),
                fontFamily: kRubik,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getOffersHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Related Offers & Enrolments",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          Text(
            "See More",
            style: TextStyle(fontSize: 16, color: Colors.grey.withOpacity(0.6)),
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
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF7265E3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F6FA),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
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
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '• GC',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Color(0xFF9C9EB9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        MusicIconsSystem.doubleBass,
                        width: 50,
                        height: 50,
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
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
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontFamily: kRubik,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Buy Used',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontFamily: kRubik,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            "Visited: 12-Mar-2022",
                            style: TextStyle(
                              fontFamily: kRubik,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),

                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "L. PURCHASE",
                        style: TextStyle(
                          fontFamily: kRubik,
                          color: Color(0xFF9C9EB9),
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        "LTV",
                        style: TextStyle(
                          fontFamily: kRubik,
                          color: Color(0xFF9C9EB9),
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        "AVG. ORDER",
                        style: TextStyle(
                          fontFamily: kRubik,
                          color: Color(0xFF9C9EB9),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "1.5k",
                        style: TextStyle(
                          fontFamily: kRubik,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        "105.5k",
                        style: TextStyle(
                          fontFamily: kRubik,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        "26.2k",
                        style: TextStyle(
                          fontFamily: kRubik,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFF9B90),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
        options: CarouselOptions(
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
}

class GetFeatureList extends StatefulWidget {
  const GetFeatureList({Key? key}) : super(key: key);

  @override
  State<GetFeatureList> createState() => _GetFeatureListState();
}

class _GetFeatureListState extends State<GetFeatureList> {
  int selectedList = 0;

  var listOfFeatureImages = [
    LandingImages.icActivity,
    LandingImages.icOrder,
    LandingImages.icHistory,
    LandingImages.icNotes,
    LandingImages.icCases,
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
                  width: 18,
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
                  color: const Color(0xFFF4F6FA),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    listOfFeatureImages[index],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                listOfFeature[index],
                style: const TextStyle(fontFamily: kRubik, fontSize: 14),
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
    LandingImages.icGuitarNew,
    LandingImages.icGuitarNew,
    LandingImages.icGuitarNew,
    LandingImages.icGuitarNew,
    LandingImages.icGuitarNew,
    LandingImages.icGuitarNew,
    LandingImages.icGuitarNew,
    LandingImages.icGuitarNew,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
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
                width: 18,
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
              color: const Color(0xFFF4F6FA)),
          child: SvgPicture.asset(
            listOfOrderImage[index],
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

class RecommendationList extends StatelessWidget {
  var listOfRecommendationImage = [
    LandingImages.icGuitarNew,
    LandingImages.icGuitarNew,
    LandingImages.icGuitarNew,
    LandingImages.icGuitarNew,
    LandingImages.icGuitarNew,
    LandingImages.icGuitarNew,
    LandingImages.icGuitarNew,
    LandingImages.icGuitarNew,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
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
                  width: 18,
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
              color: const Color(0xFFF4F6FA)),
          child: SvgPicture.asset(
            listOfRecommendationImage[index],
            color: Colors.orange,
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
                  width: 18,
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
              color: const Color(0xFFF4F6FA)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Guitar Class - 2.0",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "OFF 10%",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
