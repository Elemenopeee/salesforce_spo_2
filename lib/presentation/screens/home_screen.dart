import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                height: 50,
              ),
              const GetFeatureList(),
              const SizedBox(
                height: 40,
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
                height: 10,
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
        children: const [
          // Image.asset(
          //   Images.icDrawer,
          //   height: 30,
          //   width: 30,
          //   color: Colors.grey,
          // ),
          Text(
            "CLIENT",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
          Text(
            "LEAVE",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
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
              fontSize: 20,
            ),
          ),
          InkWell(
            onTap: () {},
            child: InkWell(
              onTap: () {},
              child: Text(
                "View All",
                style: TextStyle(
                    fontSize: 16, color: Colors.grey.withOpacity(0.6)),
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
              fontSize: 20,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "View All",
              style:
                  TextStyle(fontSize: 16, color: Colors.grey.withOpacity(0.6)),
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
              fontSize: 20,
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
      child: CarouselSlider.builder(
        itemCount: 3,
        options: CarouselOptions(
            autoPlay: true,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, reason) {
              setState(() {
                currentPos = index;
              });
            }),
        itemBuilder: (context, int index, realIndex) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
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
                  width: 20,
                ),
                getSingleFeatureList(context, index),
                const SizedBox(
                  width: 20,
                ),
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
                    color: Colors.grey.withOpacity(0.1)),
                child: const Icon(Icons.timer_outlined),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(listOfFeature[index]),
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
    // Images.icGuitar,
    // Images.icGuitar,
    // Images.icGuitar,
    // Images.icGuitar,
    // Images.icGuitar,
    // Images.icGuitar,
    // Images.icGuitar,
    // Images.icGuitar,
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
                width: 20,
              ),
              getSingleOpenOrderList(context, index),
              const SizedBox(
                width: 20,
              ),
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
              color: Colors.grey.withOpacity(0.1)),
          child: Image.asset(
            listOfOrderImage[index],
          ),
        ),
      ],
    );
  }
}

class RecommendationList extends StatelessWidget {
  var listOfRecommendationImage = [
    // Images.icGuitarOne,
    // Images.icGuitarOne,
    // Images.icGuitarOne,
    // Images.icGuitarOne,
    // Images.icGuitarOne,
    // Images.icGuitarOne,
    // Images.icGuitarOne,
    // Images.icGuitarOne,
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
                  width: 20,
                ),
                getSingleRecommendationList(context, index),
                const SizedBox(
                  width: 20,
                ),
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
              color: Colors.grey.withOpacity(0.1)),
          child: Image.asset(
            listOfRecommendationImage[index],
          ),
        ),
      ],
    );
  }
}

class OfferList extends StatelessWidget {
  var listOfOffersImage = [
    // Images.icBgGuitar,
    // Images.icBgGuitar,
    // Images.icBgGuitar,
    // Images.icBgGuitar,
    // Images.icBgGuitar,
    // Images.icBgGuitar,
    // Images.icBgGuitar,
    // Images.icBgGuitar,
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
                  width: 20,
                ),
                getSingleOfferList(context, index),
                const SizedBox(
                  width: 20,
                ),
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
              color: Colors.grey.withOpacity(0.1)),
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
