import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/design_system/primitives/padding_system.dart';
import 'package:salesforce_spo/presentation/screens/tab_screens/case_screen.dart';
import 'package:salesforce_spo/presentation/screens/tab_screens/notes_screen.dart';
import 'package:salesforce_spo/presentation/screens/tab_screens/promos_screen.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/landing_images.dart';
import '../design_system/primitives/size_system.dart';
import '../presentation/screens/tab_screens/history_screen.dart';
import '../presentation/screens/tab_screens/orders_screen.dart';
import '../utils/constants.dart';

class ClientFeatureTabsList extends StatefulWidget {
  const ClientFeatureTabsList({Key? key}) : super(key: key);

  @override
  State<ClientFeatureTabsList> createState() => _ClientFeatureTabsListState();
}

class _ClientFeatureTabsListState extends State<ClientFeatureTabsList>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late TabController _tabController;

  var listOfFeatureImages = [
    LandingImages.activityLite,
    LandingImages.orderLite,
    LandingImages.history,
    LandingImages.notes,
    LandingImages.cases,
    LandingImages.promos,
  ];

  var listOfFeatureDarkImages = [
    LandingImages.activityDark,
    LandingImages.orderDark,
    LandingImages.history,
    LandingImages.notesDark,
    LandingImages.casesDark,
    LandingImages.promosDark,
  ];

  var listOfFeature = [
    "Orders",
    "Recom.",
    "Activity",
    "Notes",
    "Cases",
    "Promos"
  ];

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // give the tab bar a height [can change hheight to preferred height]
        SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: PaddingSystem.padding10),
        child: Column(children: [
          TabBar(
            padding: EdgeInsets.zero,
            labelPadding:
                const EdgeInsets.symmetric(horizontal: PaddingSystem.padding0),
            isScrollable: true,
            controller: _tabController,
            indicator: const BoxDecoration(),
            labelColor: ColorSystem.white,
            unselectedLabelColor: ColorSystem.black,
            onTap: (index) {
              setState(() {
                selectedIndex = _tabController.index;
              });
            },
            tabs: [
              getSingleFeatureList(context, 0),
              getSingleFeatureList(context, 1),
              getSingleFeatureList(context, 2),
              getSingleFeatureList(context, 3),
              getSingleFeatureList(context, 4),
              getSingleFeatureList(context, 5),
            ],
          ),

          // tab bar view here
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              OrdersScreen(),
              OrderHistoryList(),
              NotesList(),
              CasesProductList(),
              PromoList(),
            ]),
          )
        ]),
      ),
    );
  }

  Widget getSingleFeatureList(BuildContext context, int index) {
    return Tab(
        height: 100,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: DottedBorder(
                borderType: BorderType.RRect,
                dashPattern: [6, 3],
                radius: Radius.circular(selectedIndex == index ? 12 : 6),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(selectedIndex == index ? 12 : 4),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: PaddingSystem.padding0),
                    padding: EdgeInsets.symmetric(
                      horizontal: (selectedIndex == index)
                          ? PaddingSystem.padding4
                          : PaddingSystem.padding8,
                    ),
                    decoration: const BoxDecoration(),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          _tabController.index = index;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            margin: const EdgeInsets.only(
                              top: PaddingSystem.padding5,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: selectedIndex == index
                                  ? ColorSystem.white
                                  : ColorSystem.culturedGrey,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                (selectedIndex == index)
                                    ? listOfFeatureDarkImages[index]
                                    : listOfFeatureImages[index],
                              ),
                            ),
                          ),
                          // const SizedBox(
                          //   height: 5,
                          // ),
                          Text(
                            listOfFeature[index],
                            style: TextStyle(
                                color: (selectedIndex == index)
                                    ? ColorSystem.primary
                                    : ColorSystem.secondary,
                                fontFamily: kRubik,
                                fontSize: SizeSystem.size14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 28,
              top: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                color: Colors.white,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration:const BoxDecoration(
                    color: ColorSystem.complimentary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 100,
                height: 10,
                color:
                    selectedIndex == index ? Colors.white : Colors.transparent,
              ),
            ),
            Positioned(
              left: 0,
              child: Container(
                width: 10,
                height: 98,
                color:
                    selectedIndex == index ? Colors.transparent : Colors.white,
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                width: 10,
                height: 98,
                color:
                    selectedIndex == index ? Colors.transparent : Colors.white,
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                width: 100,
                height: 10,
                color:
                    selectedIndex == index ? Colors.transparent : Colors.white,
              ),
            ),
          ],
        ));
  }
}
