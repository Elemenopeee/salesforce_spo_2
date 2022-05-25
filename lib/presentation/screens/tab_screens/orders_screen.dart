import 'package:flutter/material.dart';

import '../../../common_widgets/open_order_list.dart';
import '../../../common_widgets/recommendation_list.dart';
import '../../../common_widgets/related_offer_list.dart';
import '../../../design_system/primitives/color_system.dart';
import '../../../design_system/primitives/padding_system.dart';
import '../../../design_system/primitives/size_system.dart';
import '../../../utils/constants.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: PaddingSystem.padding20),
        child: Column(children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Open Orders",
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
          OpenOrderList(),
          const SizedBox(
            height: SizeSystem.size30,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
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
            padding: EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
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
          )
        ]));
  }
}
