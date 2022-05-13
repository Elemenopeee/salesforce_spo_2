import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/models/order.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';

class OpenOrderTab extends StatefulWidget {
  const OpenOrderTab({Key? key}) : super(key: key);

  @override
  _OpenOrderTabState createState() => _OpenOrderTabState();
}

class _OpenOrderTabState extends State<OpenOrderTab>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  int currentIndexForInnerTab = 0;

  late Future<void> _futureOpenOrders;

  List<Order> openOrders = [];

  Future<void> _getOpenOrders() async {
    var response = await HttpService().doGet(path: Endpoints.getCustomerOpenOrders());
    try{
      for(var order in response.data['records']){
        openOrders.add(Order.fromJson(order));
      }
    }catch (e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _futureOpenOrders = _getOpenOrders();
  }

  String formattedDate(String date) {
    var dateTime = DateTime.parse(date);
    return DateFormat('dd-MMM-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: _futureOpenOrders,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
            return const Center(
              child: SizedBox(
                height: 100,
                child: Center(child: CircularProgressIndicator()),
              ),
            );
            case ConnectionState.done:
              return ListView.separated(
                itemCount: openOrders.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return OrderWidget(
                    name:
                    '${openOrders[index].customerFirstName} ${openOrders[index].customerLastName}',
                    amount: openOrders[index].orderAmount.toString(),
                    date: formattedDate(
                        openOrders[index].createdDate ?? DateTime.now().toString()),
                    items: '${openOrders[index].items} items',
                    orderId: openOrders[index].id,
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
      ),
    );
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
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 05,
              ),
              Text(
                date,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 05,
              ),
              Text(
                'OID: $orderId',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 05,
              ),
              Text(
                items,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 05,
              ),
              Text(
                orderPercentage,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
