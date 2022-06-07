import 'package:flutter/material.dart';
import 'package:salesforce_spo/common_widgets/buy_again_product_widget.dart';

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
            return SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: buyAgainData.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  var item = buyAgainData[index];
                  print(buyAgainData[index]
                      .gcOrderLineRecord
                      ?.productDescription);
                  print("final status");
                  return Row(
                    children: [
                      const SizedBox(
                        width: SizeSystem.size18,
                      ),
                      BuyAgainProductWidget(
                        productName:
                            item.gcOrderLineRecord?.productDescription ?? "--",
                        productPrice: item.gcOrderLineRecord?.productPrice ?? 0,
                        productImage:
                            item.gcOrderLineRecord?.productImage ?? "",
                      ),
                    ],
                  );
                },
              ),
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
