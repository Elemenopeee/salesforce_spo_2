import 'package:flutter/material.dart';
import 'package:salesforce_spo/common_widgets/product_widget.dart';
import 'package:salesforce_spo/design_system/primitives/color_system.dart';
import 'package:salesforce_spo/models/cart_id_model.dart';
import 'package:salesforce_spo/models/cart_model.dart';

import '../../design_system/primitives/size_system.dart';
import '../../services/networking/endpoints.dart';
import '../../services/networking/networking_service.dart';

class CartListTab extends StatefulWidget {
  @override
  State<CartListTab> createState() => _CartListTabState();
}

class _CartListTabState extends State<CartListTab> {
  List<CartModel> cartList = [];

  List<CartIdModel> cartIds = [];

  bool isLoading = true;

  late Future<void> _futureCart;

  int offset = 0;

  bool isLoadingData = false;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    _futureCart = getCartList(offset);
    super.initState();
  }

  Future<void> getCartList(int offset) async {
    var customerId = ('0014M00001nv3BwQAI');
    var cartsId = ("'L56575000000000'");

    var response = await HttpService()
        .doGet(path: Endpoints.getClientCartById(customerId));
    var responseCart =
        await HttpService().doGet(path: Endpoints.getClientCart(cartsId));
    isLoadingData = false;
    try {
      for (var cart in response.data['records']) {
        cartIds.add(CartIdModel.fromJson(cart));
      }
      for (var carts in responseCart.data['records']) {
        cartList.add(CartModel.fromJson(carts));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureCart,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              cartList.isEmpty) {
            return const Center(
              child: Center(child: CircularProgressIndicator(
                color: ColorSystem.primary,
              )),
            );
          } else {
            return SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: cartList.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  var item = cartList[index];
                  return Row(
                    children: [
                      const SizedBox(
                        width: SizeSystem.size18,
                      ),
                      ProductWidget(
                        productName: item.productName ?? "",
                        productPrice: item.productPrice ?? 0,
                        productImage: item.productImage ?? "",
                      ),
                    ],
                  );
                },
              ),
            );
          }
        });
  }
}
