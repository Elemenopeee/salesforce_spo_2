import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:salesforce_spo/common_widgets/open_order_list.dart';
import 'package:salesforce_spo/design_system/primitives/padding_system.dart';
import 'package:salesforce_spo/presentation/screens/tab_screens/case_screen.dart';
import 'package:salesforce_spo/presentation/screens/tab_screens/notes_screen.dart';
import 'package:salesforce_spo/presentation/screens/tab_screens/promos_screen.dart';

import '../design_system/primitives/color_system.dart';
import '../design_system/primitives/landing_images.dart';
import '../design_system/primitives/size_system.dart';
import '../presentation/screens/tab_screens/activity_screen.dart';
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
    "Activity",
    "Orders",
    "History",
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
            indicator: BoxDecoration(
              border: RDottedLineBorder(
                  top: const BorderSide(
                    color: ColorSystem.black,
                  ),
                  left: const BorderSide(
                    color: ColorSystem.black,
                  ),
                  right: const BorderSide(
                    color: ColorSystem.black,
                  )),
              // borderRadius: BorderRadius.circular(10)
            ),
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
              ActivityScreen(),
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
        child: Container(
          margin: const EdgeInsets.only(bottom: PaddingSystem.padding0),
          padding: EdgeInsets.symmetric(
            horizontal: (selectedIndex == index)
                ? PaddingSystem.padding4
                : PaddingSystem.padding8,
          ),
          decoration: BoxDecoration(
              border: RDottedLineBorder(
                  bottom: (selectedIndex == index)
                      ? BorderSide.none
                      : const BorderSide(color: Colors.black))),
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
                        : ColorSystem.greyBg,
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
        ));
  }
}
