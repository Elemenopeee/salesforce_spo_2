import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salesforce_spo/common_widgets/buy_again_product_widget.dart';
import 'package:salesforce_spo/design_system/primitives/color_system.dart';
import 'package:salesforce_spo/design_system/primitives/icon_system.dart';
import 'package:salesforce_spo/utils/constants.dart';

import '../../design_system/primitives/size_system.dart';
import '../../models/buy_again_model.dart';
import '../../services/networking/endpoints.dart';
import '../../services/networking/networking_service.dart';

class BuyAgainListTab extends StatefulWidget {
  @override
  State<BuyAgainListTab> createState() => _BuyAgainListTabState();
}

class _BuyAgainListTabState extends State<BuyAgainListTab> {
  List<BuyAgainModel> buyAgainData = [];

  bool isLoading = true;

  late Future<void> _futureBuyAgain;

  int offset = 0;

  bool isLoadingData = false;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    _futureBuyAgain = getByNowList(offset);
    super.initState();
  }

  Future<void> getByNowList(int offset) async {
    var customerId = ('0014M00001nv3BwQAI');
    var response =
        await HttpService().doGet(path: Endpoints.getClientByNow(customerId));
    isLoadingData = false;
    try {
      for (var byAgain in response.data['records']) {
        buyAgainData.add(BuyAgainModel.fromJson(byAgain));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureBuyAgain,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              buyAgainData.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              children: [
                const SizedBox(
                  height: SizeSystem.size50,
                ),
                SvgPicture.asset(IconSystem.noDataFound),
                const SizedBox(
                  height: SizeSystem.size24,
                ),
                const Text(
                  'NO DATA FOUND!',
                  style: TextStyle(
                    color: ColorSystem.primary,
                    fontWeight: FontWeight.bold,
                    fontFamily: kRubik,
                    fontSize: SizeSystem.size20,
                  ),
                )
              ],
            );
          }
        });
  }

  void scrollListener() {
    var maxExtent = scrollController.position.maxScrollExtent;
    var loadingPosition = maxExtent - (maxExtent * 0.4);
    if (scrollController.position.extentAfter < loadingPosition &&
        !isLoadingData) {
      offset = offset + 20;
      setState(() {
        isLoadingData = true;
        _futureBuyAgain = getByNowList(offset);
      });
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }
}
