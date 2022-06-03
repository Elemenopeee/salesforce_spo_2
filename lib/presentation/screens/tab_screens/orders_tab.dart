import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/design_system/primitives/icon_system.dart';
import 'package:salesforce_spo/models/client_order.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';

import '../../../design_system/primitives/color_system.dart';
import '../../../design_system/primitives/padding_system.dart';
import '../../../design_system/primitives/size_system.dart';
import '../../../utils/constants.dart';

class OrdersTab extends StatefulWidget {

  final String customerId;

  const OrdersTab({required this.customerId, Key? key}) : super(key: key);

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {

  late Future<void> _futureOpenOrders;
  late Future<void> _futureOrderHistory;

  List<ClientOrder> openOrders = [];
  List<ClientOrder> pastOrders = [];

  Future<void> getClientOpenOrders() async {
    var response = await HttpService()
        .doGet(path: Endpoints.getClientOpenOrders(widget.customerId));

    try {
      for (var record in response.data['records']) {
        openOrders.add(ClientOrder.fromJson(record));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getClientOrderHistory() async {
    var response = await HttpService()
        .doGet(path: Endpoints.getClientOrderHistory(widget.customerId));

    try {
      for (var record in response.data['records']) {
        pastOrders.add(ClientOrder.fromJson(record));
      }
    } catch (e) {
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
    _futureOrderHistory = getClientOrderHistory();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        _futureOpenOrders,
        _futureOrderHistory,
      ]),
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

            if(openOrders.isEmpty && pastOrders.isEmpty){
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

            return ListView(
              children: [
                if(openOrders.isNotEmpty)
                const Padding(
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
                if(openOrders.isNotEmpty)
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
                            width: SizeSystem.size24,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                openOrders[index].orderNumber ?? '--',
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
                          InstrumentsTile(
                            items: openOrders[index].items ?? [],
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
                if(openOrders.isNotEmpty)
                Container(
                  height: 1,
                  color: ColorSystem.secondary.withOpacity(0.3),
                ),
                if(pastOrders.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.all(SizeSystem.size16),
                  child: Text(
                    'Order History',
                    style: TextStyle(
                      color: ColorSystem.primary,
                      fontSize: SizeSystem.size16,
                      fontFamily: kRubik,
                    ),
                  ),
                ),
                if(pastOrders.isNotEmpty)
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding:
                        const EdgeInsets.only(left: PaddingSystem.padding12),
                    itemCount: pastOrders.length,
                    itemBuilder: (context, index) {
                      return index != 0
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    const DashGenerator(
                                      numberOfDashes: 6,
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: ColorSystem.secondary
                                            .withOpacity(0.3),
                                        height: 0.5,
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 20,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      pastOrders[index].orderStatus ==
                                              'Completed'
                                          ? CupertinoIcons.check_mark_circled
                                          : CupertinoIcons.clear_circled,
                                      color: pastOrders[index].orderStatus ==
                                              'Completed'
                                          ? ColorSystem.additionalGreen
                                          : ColorSystem.complimentary,
                                    ),
                                    const SizedBox(
                                      width: SizeSystem.size20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          pastOrders[index].orderNumber ?? '--',
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
                                          '\$${pastOrders[index].amount}',
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
                                          dateFormatter(
                                              pastOrders[index].createdDate),
                                          style: const TextStyle(
                                            color: ColorSystem.secondary,
                                            fontFamily: kRubik,
                                            fontSize: SizeSystem.size12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    InstrumentsTile(
                                      items: pastOrders[index].items ?? [],
                                    ),
                                    const SizedBox(
                                      width: SizeSystem.size16,
                                    ),
                                  ],
                                )
                              ],
                            )
                          : Row(
                              children: [
                                Icon(
                                  pastOrders[index].orderStatus ==
                                      'Completed'
                                      ? CupertinoIcons.check_mark_circled
                                      : CupertinoIcons.clear_circled,
                                  color: pastOrders[index].orderStatus ==
                                      'Completed'
                                      ? ColorSystem.additionalGreen
                                      : ColorSystem.complimentary,
                                ),
                                const SizedBox(
                                  width: SizeSystem.size20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pastOrders[index].orderNumber ?? '--',
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
                                      '\$${pastOrders[index].amount}',
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
                                      dateFormatter(
                                          pastOrders[index].createdDate),
                                      style: const TextStyle(
                                        color: ColorSystem.secondary,
                                        fontFamily: kRubik,
                                        fontSize: SizeSystem.size12,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                InstrumentsTile(
                                  items: pastOrders[index].items ?? [],
                                ),
                                const SizedBox(
                                  width: SizeSystem.size16,
                                ),
                              ],
                            );
                    }),
                Container(
                  height: 1,
                  margin:
                      const EdgeInsets.symmetric(vertical: PaddingSystem.padding10),
                  color: ColorSystem.secondary.withOpacity(0.3),
                ),
              ],
            );
        }
      },
    );
  }
}

class InstrumentsTile extends StatelessWidget {
  final List<OrderItem> items;

  const InstrumentsTile({
    Key? key,
    required this.items,
  }) : super(key: key);

  CachedNetworkImage _imageContainer(String imageUrl, double width) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: width,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(SizeSystem.size12),
            color: ColorSystem.culturedGrey,
          ),
          child: Image(
            image: imageProvider,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox();
    }
    if (items.length == 1) {
      if (items[0].imageUrl != null) {
        return _imageContainer(
          items[0].imageUrl!,
          64,
        );
      } else {
        return const SizedBox();
      }
    }
    if (items.length == 2) {
      return SizedBox(
        width: SizeSystem.size64,
        height: SizeSystem.size64,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (items[0].imageUrl != null)
              _imageContainer(
                items[0].imageUrl!,
                SizeSystem.size30,
              ),
            const SizedBox(
              width: SizeSystem.size4,
            ),
            if (items[1].imageUrl != null)
              _imageContainer(
                items[1].imageUrl!,
                SizeSystem.size30,
              ),
          ],
        ),
      );
    }
    if (items.length == 3) {
      return SizedBox(
        width: 64,
        height: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (items[0].imageUrl != null)
                  _imageContainer(
                    items[0].imageUrl!,
                    SizeSystem.size30,
                  ),
                const SizedBox(
                  width: SizeSystem.size4,
                ),
                if (items[1].imageUrl != null)
                  _imageContainer(
                    items[1].imageUrl!,
                    SizeSystem.size30,
                  ),
              ],
            ),
            const SizedBox(
              height: SizeSystem.size4,
            ),
            if (items[2].imageUrl != null)
              _imageContainer(
                items[2].imageUrl!,
                SizeSystem.size30,
              ),
          ],
        ),
      );
    }
    if (items.length >= 4) {
      return SizedBox(
        width: 64,
        height: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (items[0].imageUrl != null)
                  _imageContainer(
                    items[0].imageUrl!,
                    SizeSystem.size30,
                  ),
                const SizedBox(
                  width: SizeSystem.size4,
                ),
                if (items[1].imageUrl != null)
                  _imageContainer(
                    items[1].imageUrl!,
                    SizeSystem.size30,
                  ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (items[2].imageUrl != null)
                  _imageContainer(
                    items[2].imageUrl!,
                    SizeSystem.size30,
                  ),
                const SizedBox(
                  width: SizeSystem.size4,
                ),
                Container(
                  width: SizeSystem.size30,
                  height: SizeSystem.size30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(SizeSystem.size12),
                    color: ColorSystem.culturedGrey,
                  ),
                  child: Center(
                    child: Text(
                      '+${items.length - 3}',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        fontFamily: kRubik,
                        fontSize: SizeSystem.size12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}

class DashGenerator extends StatelessWidget {
  final int numberOfDashes;

  const DashGenerator({Key? key, this.numberOfDashes = 4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        numberOfDashes,
        (index) => Container(
          margin: const EdgeInsets.only(
            left: 12,
            right: 10,
            top: 1,
            bottom: 2,
          ),
          height: 4,
          width: 1,
          color: Colors.grey,
        ),
      ),
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
