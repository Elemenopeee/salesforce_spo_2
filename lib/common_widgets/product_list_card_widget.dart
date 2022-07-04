import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/design_system/primitives/size_system.dart';
import 'package:salesforce_spo/models/order_item.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';
import 'package:salesforce_spo/utils/constants.dart';
import 'package:salesforce_spo/utils/enums/order_status_enum.dart';

import '../models/order.dart';

class ProductListCard extends StatefulWidget {
  const ProductListCard({
    Key? key,
    required this.order,
    required this.Id,
    required this.Date,
    this.taskType,
  }) : super(key: key);
  final Order order;
  final String Id;
  final String Date;
  final String? taskType;

  @override
  State<ProductListCard> createState() => _ProductListCardState();
}

class _ProductListCardState extends State<ProductListCard> {
  late Future<void> futureOrder;

  List<OrderItem> orderItems = [];

  bool expansionTileExpanded = false;

  String? storeName;
  String? entryType;
  String? storeDirection;
  double? grandTotal;

  Future<void> getFutureOrder() async {
    var response = await HttpService()
        .doGet(path: Endpoints.getSmartTriggerOrder(widget.Id));

    if (response.data != null) {
      for (var order in response.data['OrderList']) {
        storeName = order['StoreName'];
        entryType = order['EntryType'];
        storeDirection = order['StoreDirection'];
        grandTotal = order['GrandTotal'];
        for (var item in order['Items']) {
          try {
            orderItems.add(OrderItem.fromTaskJson(item));
          } on Exception catch (e) {
            print(e);
          }
        }
      }
    }
  }

  @override
  initState() {
    super.initState();
    futureOrder = getFutureOrder();
  }

  String dateFormatter(String date) {
    var dateTime = DateTime.parse(date);
    return DateFormat('MMM dd, yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size10),
      child: Container(
        padding: const EdgeInsets.only(
          top: SizeSystem.size14,
        ),
        decoration: BoxDecoration(
            color: ColorSystem.lavender3.withOpacity(0.08),
            borderRadius: BorderRadius.circular(SizeSystem.size14)),
        child: Column(children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
            child: Row(
              children: [
                Text(
                  widget.Id,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeSystem.size14,
                    fontFamily: kRubik,
                  ),
                ),
                const Spacer(),
                Text(
                  '${widget.order.brand ?? '--'} | ${dateFormatter(widget.order.createdDate ?? '--')}',
                  style: const TextStyle(
                    color: ColorSystem.primary,
                    fontWeight: FontWeight.normal,
                    fontSize: SizeSystem.size14,
                    fontFamily: kRubik,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: SizeSystem.size6,
          ),
          Divider(
            height: 1.0,
            color: ColorSystem.primary.withOpacity(0.2),
          ),
          FutureBuilder(
            future: futureOrder,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                case ConnectionState.active:
                  return const Center(
                    child: SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: ColorSystem.primary,
                        ),
                      ),
                    ),
                  );
                case ConnectionState.done:
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return TaskOrderWidget(
                        item: widget.order.orderLines![index],
                        taskType: widget.taskType,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 1,
                        color: ColorSystem.primary.withOpacity(0.1),
                      );
                    },
                    itemCount: widget.order.orderLines?.length ?? 0,
                  );
              }
            },
          ),
          Container(
            height: 1,
            color: ColorSystem.primary.withOpacity(0.1),
          ),
          RotatedBox(
            quarterTurns: 2,
            child: Theme(
              data: ThemeData().copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                onExpansionChanged: (expanded) {
                  setState(() {
                    expansionTileExpanded = expanded;
                  });
                },
                trailing: SizedBox(),
                leading: SizedBox(),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 2,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            expansionTileExpanded
                                ? 'Less Details'
                                : 'More Details',
                            style: const TextStyle(
                              color: ColorSystem.lavender2,
                              fontSize: SizeSystem.size14,
                              fontFamily: kRubik,
                            ),
                          ),
                          Icon(
                            expansionTileExpanded
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            color: ColorSystem.lavender2,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                children: [
                  RotatedBox(
                    quarterTurns: 2,
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: SizeSystem.size20,
                        vertical: SizeSystem.size16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (storeName != null)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      IconSystem.market,
                                      width: 20,
                                    ),
                                    const SizedBox(
                                      width: SizeSystem.size16,
                                    ),
                                    Text(
                                      storeName!,
                                      style: const TextStyle(
                                        color: ColorSystem.primary,
                                        fontSize: SizeSystem.size14,
                                      ),
                                    ),
                                  ],
                                ),
                              if (storeName != null)
                                const SizedBox(
                                  width: SizeSystem.size50,
                                ),
                              if (entryType != null)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      IconSystem.storeType,
                                      width: 20,
                                    ),
                                    const SizedBox(
                                      width: SizeSystem.size16,
                                    ),
                                    Text(
                                      entryType!,
                                      style: const TextStyle(
                                        color: ColorSystem.primary,
                                        fontSize: SizeSystem.size14,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          if (storeName != null || entryType != null)
                            const SizedBox(
                              height: SizeSystem.size16,
                            ),
                          if (storeDirection != null)
                            Row(
                              children: [
                                SvgPicture.asset(
                                  IconSystem.locationPin,
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: SizeSystem.size16,
                                ),
                                Text(
                                  '$storeDirection',
                                  style: const TextStyle(
                                    color: ColorSystem.primary,
                                    fontSize: SizeSystem.size14,
                                  ),
                                ),
                              ],
                            ),
                          const SizedBox(
                            height: SizeSystem.size16,
                          ),
                          const Text(
                            'Total:',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: kRubik,
                              color: ColorSystem.primary,
                            ),
                          ),
                          Text(
                            '\$${grandTotal ?? 0.0}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: ColorSystem.primary,
                              fontFamily: kRubik,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 1,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  RotatedBox(
                    quarterTurns: 2,
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(
                            width: SizeSystem.size20,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return TaskOrderLineWidget(
                                imageUrl: orderItems[index].imageUrl,
                                itemPrice:
                                    orderItems[index].itemPrice.toString(),
                                status: orderItems[index].status,
                                description: orderItems[index].description,
                                quantity: '${orderItems[index].orderedQuantity}',
                                trackingId: orderItems[index].trackingNumber ?? '--',
                                taskType: widget.taskType ?? '--',
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                width: 20,
                              );
                            },
                            itemCount: orderItems.length,
                          ),
                          const SizedBox(
                            width: SizeSystem.size20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class TaskOrderWidget extends StatelessWidget {
  const TaskOrderWidget({Key? key, required this.item, this.taskType})
      : super(key: key);
  final OrderItem item;
  final String? taskType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _OrderItem(
        product_price: item.itemPrice.toString(),
        product_qty: item.orderedQuantity.toString(),
        product_disc: item.description ?? '--',
        product_status: taskType ?? '--',
        delivery_date: '--',
        track_id: item.trackingNumber ?? '--',
        item_image: item.imageUrl,
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  const _OrderItem(
      {Key? key,
      required this.product_price,
      required this.product_qty,
      required this.product_disc,
      required this.product_status,
      required this.delivery_date,
      required this.track_id,
      this.item_image})
      : super(key: key);

  final String product_price;
  final String product_qty;
  final String product_disc;
  final String product_status;
  final String delivery_date;
  final String track_id;
  final String? item_image;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
          child: Column(
            children: [
              Container(
                height: 116,
                width: 104,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (item_image != null)
                      Expanded(
                          child: CachedNetworkImage(imageUrl: item_image!)),
                    Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          color: Color(0xff9C9EB9)),
                      child: Center(
                        child: Text(
                          '\$ ${product_price}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: SizeSystem.size12,
                              fontFamily: kRubik,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 14.0,
              ),
              RichText(
                text: TextSpan(
                  text: 'Qty. ',
                  style: const TextStyle(
                    fontSize: SizeSystem.size14,
                    color: Color(0xff2D3142),
                    fontFamily: kRubik,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: product_qty,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: kRubik,
                            fontSize: SizeSystem.size16)),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Flexible(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product_disc,
                    style: const TextStyle(
                      fontSize: SizeSystem.size14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff2D3142),
                      fontFamily: kRubik,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Color(0xff9C9EB9)),
                    ),
                    child: Text(product_status,
                        style: const TextStyle(
                            color: Color(0xff8C80F8),
                            fontWeight: FontWeight.w400,
                            fontSize: SizeSystem.size12,
                            fontFamily: kRubik),
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  if(product_status == 'SPO Delivery')
                  RichText(
                    text: TextSpan(
                      text: 'Deilvered on:',
                      style: const TextStyle(
                        fontSize: SizeSystem.size12,
                        color: Color(0xff2D3142),
                        fontFamily: kRubik,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' ' + delivery_date,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: kRubik,
                                fontSize: SizeSystem.size14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class TaskOrderLineWidget extends StatelessWidget {
  final String? imageUrl;
  final String? itemPrice;
  final String? status;
  final String? description;
  final String? quantity;
  final String? trackingId;
  final String? deliveredOn;
  final String? taskType;

  const TaskOrderLineWidget({
    Key? key,
    this.imageUrl,
    this.itemPrice,
    this.status,
    this.description,
    this.quantity,
    this.trackingId,
    this.deliveredOn,
    this.taskType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.all(SizeSystem.size32),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 116,
                          width: 104,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (imageUrl != null)
                                Expanded(
                                    child: CachedNetworkImage(imageUrl: imageUrl!)),
                              Container(
                                width: double.maxFinite,
                                padding: const EdgeInsets.symmetric(vertical: 3),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight: Radius.circular(10.0)),
                                    color: Color(0xff9C9EB9)),
                                child: Center(
                                  child: Text(
                                    '\$ $itemPrice',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: SizeSystem.size12,
                                        fontFamily: kRubik,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 14.0,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Qty. ',
                            style: const TextStyle(
                              fontSize: SizeSystem.size14,
                              color: Color(0xff2D3142),
                              fontFamily: kRubik,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: quantity,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: kRubik,
                                      fontSize: SizeSystem.size16)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: SizeSystem.size16,
                    ),
                    Container(
                      child: Flexible(
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                description ?? '--',
                                style: const TextStyle(
                                  fontSize: SizeSystem.size14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff2D3142),
                                  fontFamily: kRubik,
                                ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Container(
                                padding:
                                const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Color(0xff9C9EB9)),
                                ),
                                child: Text(taskType ?? '--',
                                    style: const TextStyle(
                                        color: Color(0xff8C80F8),
                                        fontWeight: FontWeight.w400,
                                        fontSize: SizeSystem.size12,
                                        fontFamily: kRubik),
                                    textAlign: TextAlign.center),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              if(taskType == 'SPO Delivery')
                              RichText(
                                text: TextSpan(
                                  text: 'Deilvered on:',
                                  style: const TextStyle(
                                    fontSize: SizeSystem.size12,
                                    color: Color(0xff2D3142),
                                    fontFamily: kRubik,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '  ${deliveredOn ?? '--'}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: kRubik,
                                            fontSize: SizeSystem.size14)),
                                  ],
                                ),
                              ),
                              if(taskType == 'SPO Delivery')
                              const SizedBox(
                                height: 8.0,
                              ),
                              if(taskType == 'SPO Delivery')
                              RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: 'Tracking ID: ',
                                  style: const TextStyle(
                                    fontSize: SizeSystem.size12,
                                    color: Color(0xff2D3142),
                                    fontFamily: kRubik,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: trackingId ?? '--',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: kRubik,
                                            fontSize: SizeSystem.size14)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 136,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 116,
                      width: 104,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (imageUrl != null)
                            Expanded(
                              child: CachedNetworkImage(
                                imageUrl: imageUrl!,
                              ),
                            ),
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)),
                                color: Color(0xff9C9EB9)),
                            child: Center(
                              child: Text(
                                '\$ $itemPrice',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: SizeSystem.size12,
                                    fontFamily: kRubik,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: PaddingSystem.padding6,
                        vertical: PaddingSystem.padding2,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SizeSystem.size6),
                          color: ColorSystem.lavender2.withOpacity(0.1)),
                      child: Text(
                        '${getOrderStatusToDisplay(getOrderStatus(status))?.toUpperCase()}',
                        style: const TextStyle(
                            fontFamily: kRubik,
                            fontSize: SizeSystem.size12,
                            color: ColorSystem.lavender2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 100,
              child: Text(
                description ?? '--',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: ColorSystem.primary,
                  fontSize: SizeSystem.size12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
