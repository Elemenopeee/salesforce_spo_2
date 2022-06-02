import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/design_system/primitives/icon_system.dart';
import 'package:salesforce_spo/models/client_open_order.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';

import '../../../design_system/primitives/color_system.dart';
import '../../../design_system/primitives/padding_system.dart';
import '../../../design_system/primitives/size_system.dart';
import '../../../utils/constants.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  var clientId = '0014M00001ntpzMQAQ';

  late Future<void> _futureOpenOrders;

  List<ClientOpenOrder> openOrders = [];

  Future<void> getClientOpenOrders() async {
    var response = await HttpService()
        .doGet(path: Endpoints.getClientOpenOrders(clientId));

    try{
      for (var record in response.data['records']) {
        openOrders.add(ClientOpenOrder.fromJson(record));
      }
    }
    catch (e) {
      print(e);
    }
  }

  String dateFormatter(String? orderDate) {
    if (orderDate == null) {
      return '--';
    } else {
      return DateFormat('MM-dd-yyyy').format(DateTime.parse(orderDate));
    }
  }

  @override
  initState() {
    super.initState();
    _futureOpenOrders = getClientOpenOrders();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureOpenOrders,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Open Orders',
                    style: TextStyle(
                      color: ColorSystem.primary,
                      fontSize: SizeSystem.size16,
                      fontFamily: kRubik,
                    ),
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: openOrders.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: PaddingSystem.padding16,
                        vertical: PaddingSystem.padding10,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            IconSystem.cart,
                            color: Colors.black,
                            width: SizeSystem.size16,
                            height: SizeSystem.size16,
                          ),
                          const SizedBox(
                            width: SizeSystem.size20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                openOrders[index].name ?? '--',
                                style: const TextStyle(
                                  color: ColorSystem.primary,
                                  fontFamily: kRubik,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeSystem.size12,
                                ),
                              ),
                              const SizedBox(
                                height: SizeSystem.size4,
                              ),
                              Text(
                                '\$${openOrders[index].amount}',
                                style: const TextStyle(
                                  color: ColorSystem.primary,
                                  fontFamily: kRubik,
                                  fontSize: SizeSystem.size12,
                                ),
                              ),
                              const SizedBox(
                                height: SizeSystem.size4,
                              ),
                              Text(
                                dateFormatter(openOrders[index].createdDate),
                                style: const TextStyle(
                                  color: ColorSystem.secondary,
                                  fontFamily: kRubik,
                                  fontSize: SizeSystem.size12,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          CachedNetworkImage(
                            imageUrl:
                            'http://media.musiciansfriend.com/is/image/MMGS7/H96715000001000-00-120x120.jpg',
                            imageBuilder: (context, imageProvider){
                              return Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  color: ColorSystem.greyBg,
                                ),
                                child: Image(
                                  image: imageProvider,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 1,
                      color: ColorSystem.secondary.withOpacity(0.3),
                    );
                  },
                ),
              ],
            );
        }
      },
    );
  }
}

// Container(
// padding: const EdgeInsets.only(top: PaddingSystem.padding20),
// child: Column(children: [
// Padding(
// padding:
// const EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// const Text(
// "Open Orders",
// style: TextStyle(
// fontSize: SizeSystem.size18,
// fontFamily: kRubik,
// ),
// ),
// InkWell(
// onTap: () {},
// child: InkWell(
// onTap: () {},
// child: Text(
// "View All",
// style: TextStyle(
// fontSize: SizeSystem.size16,
// color: ColorSystem.secondary.withOpacity(0.4),
// fontFamily: kRubik,
// ),
// ),
// ),
// ),
// ],
// ),
// ),
// const SizedBox(
// height: SizeSystem.size20,
// ),
// OpenOrderList(),
// const SizedBox(
// height: SizeSystem.size30,
// ),
// Padding(
// padding:
// const EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// const Text(
// "Recommendation",
// style: TextStyle(
// fontSize: SizeSystem.size18,
// fontFamily: kRubik,
// ),
// ),
// InkWell(
// onTap: () {},
// child: InkWell(
// onTap: () {},
// child: Text(
// "View All",
// style: TextStyle(
// fontSize: SizeSystem.size16,
// color: ColorSystem.secondary.withOpacity(0.4),
// fontFamily: kRubik,
// ),
// ),
// ),
// ),
// ],
// ),
// ),
// const SizedBox(
// height: SizeSystem.size20,
// ),
// RecommendationList(),
// const SizedBox(
// height: SizeSystem.size30,
// ),
// Padding(
// padding: EdgeInsets.symmetric(horizontal: PaddingSystem.padding20),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// const Text(
// "Related Offers & Enrolments",
// style: TextStyle(
// fontSize: SizeSystem.size18,
// ),
// ),
// InkWell(
// onTap: () {},
// child: InkWell(
// onTap: () {},
// child: Text(
// "See More",
// style: TextStyle(
// fontSize: SizeSystem.size16,
// color: ColorSystem.secondary.withOpacity(0.4),
// fontFamily: kRubik,
// ),
// ),
// ),
// ),
// ],
// ),
// ),
// const SizedBox(
// height: SizeSystem.size20,
// ),
// RelatedOfferList(),
// const SizedBox(
// height: SizeSystem.size30,
// )
// ]))
