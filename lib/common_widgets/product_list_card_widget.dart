import 'package:flutter/material.dart';
import 'package:salesforce_spo/design_system/primitives/size_system.dart';
import 'package:salesforce_spo/utils/constants.dart';
//  ProductListCard(
//           Id: 'GC19692557',
//           Date: 'GC  |  Jun 01,2022',
//           items:
          var itemS = [
            ItemModel(
                product_price: "24,500",
                product_qty: '02/300',
                product_disc:
                    "Gibson Les Paul Standard '60s Electric Guitar Iced Tea",
                product_status: 'Ready for Pickup',
                delivery_date: 'Jun 08,2022',
                track_id: '1ZA3R3310397339934'

                ),
                ItemModel(
                product_price: "24,500",
                product_qty: '02/300',
                product_disc:
                    "Gibson Les Paul Standard '60s Electric Guitar Iced Tea",
                product_status: 'Ready for Pickup',
                delivery_date: 'Jun 08,2022',
                track_id: '1ZA3R3310397339934'

                ),
          ];
//         )

class ProductListCard extends StatelessWidget {
  const ProductListCard(
      {Key? key, required this.items, required this.Id, required this.Date})
      : super(key: key);
  final List<ItemModel> items;
  final String Id;
  final String Date;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        padding: EdgeInsets.only(top: 14.0, bottom: 18.0),
        decoration: BoxDecoration(
            color: Color(0xff8C80F8).withOpacity(0.08),
            borderRadius: BorderRadius.circular(14.0)),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
            child: Row(
              children: [
                Text(Id,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeSystem.size14,
                        fontFamily: kRubik)),
                Spacer(),
                Text(Date,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: SizeSystem.size14,
                        fontFamily: kRubik)),
              ],
            ),
          ),
          SizedBox(
            height: 6.0,
          ),
          Divider(
            height: 1.0,
          ),
          _ProductListWidget(
            item_model: itemS,
          )
        ]),
      ),
    );
  }
}

class _ProductListWidget extends StatelessWidget {
  const _ProductListWidget({Key? key, required this.item_model})
      : super(key: key);
  final List<ItemModel> item_model;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: item_model.length,
        shrinkWrap: true,
        separatorBuilder: (contex, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(),
        ),
        itemBuilder: ((context, index) => Container(
            child: ItemModel(
                product_price: item_model[index].product_price,
                product_qty: item_model[index].product_qty,
                product_disc: item_model[index].product_disc,
                product_status: item_model[index].product_status,
                delivery_date: item_model[index].delivery_date,
                track_id: item_model[index].track_id)
                ._getItemWidget)));
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
          // color: Colors.amber,

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
                        fontSize: SizeSystem.size14,
                        color: Color(0xff2D3142),
                        fontFamily: kRubik,
                      ),
                      children:   <TextSpan>[
                        TextSpan(
                            text: ' ' + delivery_date,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: kRubik,
                                fontSize: SizeSystem.size16)),
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
                        fontSize: SizeSystem.size14,
                        color: Color(0xff2D3142),
                        fontFamily: kRubik,
                      ),
                      children:   <TextSpan>[
                        TextSpan(
                            text: track_id,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: kRubik,
                                fontSize: SizeSystem.size16)),
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

class ItemModel {
  final String product_price;
  final String product_qty;
  final String product_disc;
  final String product_status;
  final String delivery_date;
  final String track_id;
  final String? item_image;

  ItemModel(
      {required this.product_price,
        required this.product_qty,
        required this.product_disc,
        required this.product_status,
        required this.delivery_date,
        required this.track_id,
        this.item_image});

  get _getItemWidget => _OrderItem(
    product_price: this.product_price,
    product_qty: this.product_qty,
    product_disc: this.product_disc,
    product_status: this.product_status,
    delivery_date: this.delivery_date,
    track_id: this.track_id,
    item_image: this.item_image,
  );
}