import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/models/order.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';
import 'package:salesforce_spo/utils/constants.dart';

class OpenOrderTab extends StatefulWidget {
  const OpenOrderTab({Key? key}) : super(key: key);

  @override
  _OpenOrderTabState createState() => _OpenOrderTabState();
}

class _OpenOrderTabState extends State<OpenOrderTab>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  int currentIndexForInnerTab = 0;

  int offset = 0;
  bool isLoadingData = false;

  ScrollController scrollController = ScrollController();

  late Future<void> _futureOpenOrders;

  List<Order> openOrders = [];

  Future<void> _getOpenOrders(int offset) async {
    var response =
        await HttpService().doGet(path: Endpoints.getCustomerOpenOrders(offset));
    isLoadingData = false;
    try {
      for (var order in response.data['records']) {
        openOrders.add(Order.fromJson(order));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    _futureOpenOrders = _getOpenOrders(offset);
  }

  String formattedDate(String date) {
    var dateTime = DateTime.parse(date);
    return DateFormat('dd-MMM-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureOpenOrders,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting && openOrders.isEmpty){
          return const Center(
            child: SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          return ListView.separated(
            controller: scrollController,
            itemCount: openOrders.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return OrderWidget(
                name:
                '${openOrders[index].customerFirstName ?? '--'} ${openOrders[index].customerLastName ?? '--'}',
                amount: '\$ ${openOrders[index].orderAmount.toString()}',
                date: formattedDate(openOrders[index].createdDate ??
                    DateTime.now().toString()),
                items: '${openOrders[index].items} items',
                orderId: openOrders[index].orderNumber ?? '--',
                orderPercentage: '',
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.white,
                child: Divider(
                  color: Colors.grey.withOpacity(0.2),
                  thickness: 1,
                ),
              );
            },
          );
        }
      },
    );
  }

  void scrollListener(){
    var maxExtent = scrollController.position.maxScrollExtent;
    var loadingPosition = maxExtent - (maxExtent * 0.4);
    if(scrollController.position.extentAfter < loadingPosition && !isLoadingData){
      offset = offset + 20;
      print(offset);
      setState((){
        isLoadingData = true;
        _futureOpenOrders = _getOpenOrders(offset);
      });
    }
  }

  @override
  void dispose(){
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

}

class OrderWidget extends StatelessWidget {
  final String name;
  final String amount;
  final String date;
  final String items;
  final String orderId;
  final String orderPercentage;

  const OrderWidget({
    Key? key,
    required this.name,
    required this.amount,
    required this.date,
    required this.items,
    required this.orderId,
    required this.orderPercentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 08),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: kRubik,
                  color: ColorSystem.primary,
                ),
              ),
              const SizedBox(
                height: 04,
              ),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: kRubik,
                  color: ColorSystem.primary,
                ),
              ),
              const SizedBox(
                height: 04,
              ),
              Text(
                'OID: $orderId',
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: kRubik,
                  color: ColorSystem.secondary,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: kRubik,
                  color: ColorSystem.primary,
                ),
              ),
              const SizedBox(
                height: 04,
              ),
              Text(
                items,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: kRubik,
                  color: ColorSystem.primary,
                ),
              ),
              const SizedBox(
                height: 04,
              ),
              Text(
                orderPercentage,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: kRubik,
                  color: ColorSystem.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
