import 'package:flutter/material.dart';
import 'package:salesforce_spo/common_widgets/customer_might_like_list.dart';
import 'package:salesforce_spo/design_system/design_system.dart';

import '../../../utils/constants.dart';
import '../../tabs/browsing_history_list_tab.dart';
import '../../tabs/cart_list_tab.dart';
import '../../tabs/buy_again_list_tab.dart';
import '../../tabs/custom_tab_bar.dart';

class RecommendationScreen extends StatefulWidget {
  const RecommendationScreen({Key? key}) : super(key: key);

  @override
  _RecommendationScreenState createState() => _RecommendationScreenState();
}

class _RecommendationScreenState extends State<RecommendationScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  int currentIndex = 0;
  int currentIndexForInnerTab = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          CustomTabBarExtended(
            padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size15),
            height: 45,
            containerColor: Colors.grey.withOpacity(0.1),
            containerBorderRadius: 10.0,
            tabBorderRadius: 10.0,
            tabOneName: "Browser History",
            tabTwoName: "Buy Again",
            tabThreeName: "Cart",
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(
                  0.0,
                  1.0,
                ),
                blurRadius: 2,
                spreadRadius: 2,
              )
            ],
            tabController: _tabController,
            tabColor: Colors.white,
            labelColor: Colors.black,
            unSelectLabelColor: Colors.grey,
            labelTextStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SizedBox(
              height: 200,
              child: TabBarView(
                controller: _tabController,
                children: [
                  BrowsingHistoryListTab(),
                  BuyAgainListTab(),
                  CartListTab(),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Customer might also like",
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
                        fontSize: SizeSystem.size14,
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
            height: 20,
          ),
          CustomerMightLikeList(),
        ],
      ),
    );
  }
}
