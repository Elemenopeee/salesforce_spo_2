import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/design_system/primitives/size_system.dart';
import 'package:salesforce_spo/models/order_item.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';
import 'package:salesforce_spo/utils/constants.dart';

import '../models/order.dart';

class ProductListCard extends StatefulWidget {
  const ProductListCard(
      {Key? key, required this.order, required this.Id, required this.Date})
      : super(key: key);
  final Order order;
  final String Id;
  final String Date;

  @override
  State<ProductListCard> createState() => _ProductListCardState();
}

class _ProductListCardState extends State<ProductListCard> {
  late Future<void> futureOrder;

  List<OrderItem> orderItems = [];

  Future<void> getFutureOrder() async {
    var response = await HttpService()
        .doGet(path: Endpoints.getSmartTriggerOrder(widget.Id));

    if (response.data != null) {
      for (var order in response.data['OrderList']) {
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

  String dateFormatter(String date){
    var dateTime = DateTime.parse(date);
    return DateFormat('MMM dd,yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SizeSystem.size10),
      child: Container(
        padding: const EdgeInsets.only(
            top: SizeSystem.size14, bottom: SizeSystem.size18),
        decoration: BoxDecoration(
            color: ColorSystem.lavender3.withOpacity(0.08),
            borderRadius: BorderRadius.circular(SizeSystem.size14)),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 6.0),
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
                  'GC | ${dateFormatter(widget.order.createdDate ?? '--')}',
                  style: const TextStyle(
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
          const Divider(
            height: 1.0,
          ),
          FutureBuilder(
            future: futureOrder,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch(snapshot.connectionState){
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
                      return TaskOrderWidget(item: orderItems[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox();
                    },
                    itemCount: orderItems.length,
                  );
              }
            },
          ),
        ]),
      ),
    );
  }
}

class TaskOrderWidget extends StatelessWidget {
  const TaskOrderWidget({Key? key, required this.item}) : super(key: key);
  final OrderItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: _OrderItem(
        product_price: item.itemPrice.toString(),
        product_qty: item.orderedQuantity.toString(),
        product_disc: item.description ?? '--',
        product_status: item.status ?? '--',
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
                    if(item_image != null)
                    Expanded(child: CachedNetworkImage(imageUrl: item_image!)),
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          color: Color(0xff9C9EB9)),
                      child: Center(
                        child: Text(
                          '\$ ${product_price}',
                          style: TextStyle(
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
                    style: TextStyle(
                      fontSize: SizeSystem.size14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff2D3142),
                      fontFamily: kRubik,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Color(0xff9C9EB9)),
                    ),
                    child: Text(product_status,
                        style: TextStyle(
                            color: Color(0xff8C80F8),
                            fontWeight: FontWeight.w400,
                            fontSize: SizeSystem.size12,
                            fontFamily: kRubik),
                        textAlign: TextAlign.center),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Deilvered on:',
                      style: TextStyle(
                        fontSize: SizeSystem.size12,
                        color: Color(0xff2D3142),
                        fontFamily: kRubik,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' ' + delivery_date,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: kRubik,
                                fontSize: SizeSystem.size14)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  RichText(
                    maxLines: 3,
                    text: TextSpan(
                      text: 'Tracking ID: ',
                      style: TextStyle(
                        fontSize: SizeSystem.size12,
                        color: Color(0xff2D3142),
                        fontFamily: kRubik,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: track_id,
                            style: TextStyle(
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