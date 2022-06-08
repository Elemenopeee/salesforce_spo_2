import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/models/product.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';

import '../../common_widgets/product_widget.dart';
import '../../design_system/design_system.dart';
import '../../design_system/primitives/icon_system.dart';
import '../../design_system/primitives/size_system.dart';
import '../../services/networking/endpoints.dart';
import '../../utils/constants.dart';

class BrowsingHistoryListTab extends StatefulWidget {
  @override
  State<BrowsingHistoryListTab> createState() => _BrowsingHistoryListTabState();
}

class _BrowsingHistoryListTabState extends State<BrowsingHistoryListTab> {
  late Future<void> futureBrowsingHistory;

  List<String> productIDs = [];
  List<Product> products = [];

  Future<void> getBrowsingHistory() async {
    var response = await HttpService()
        .doGet(path: Endpoints.getClientBrowsingHistoryProductIDs());

    if (response.data != null) {
      for (var record in response.data['records']) {
        productIDs.add(record['Id']);
      }
    }

    if (productIDs.isNotEmpty) {
      var responseProducts = await HttpService()
          .doGet(path: Endpoints.getClientRecentlyViewedProducts(productIDs));

      if (response.data != null) {
        for (var record in responseProducts.data['records']) {
          products.add(Product.fromJson(record));
        }
      }
    }
  }

  @override
  initState(){
    super.initState();
    futureBrowsingHistory = getBrowsingHistory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureBrowsingHistory,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator(
                color: ColorSystem.primary,
              ),
            );
          case ConnectionState.done:
            if (products.isEmpty) {
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

            return SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: products.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  var item = products[index];
                  return SizedBox(
                    width: 180,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: SizeSystem.size18,
                        ),
                        ProductWidget(
                          productName: item.name ?? '',
                          productPrice: item.standardUnitCost ?? 0,
                          productImage: item.productImageURL ?? '',
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
        }
      },
    );
  }
}
