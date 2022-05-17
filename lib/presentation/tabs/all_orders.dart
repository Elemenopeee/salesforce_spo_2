import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/models/order.dart';
import 'package:salesforce_spo/presentation/tabs/open_orders.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';

class AllOrderTab extends StatefulWidget {
  const AllOrderTab({Key? key}) : super(key: key);

  @override
  _AllOrderTabState createState() => _AllOrderTabState();
}

class _AllOrderTabState extends State<AllOrderTab>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  int currentIndexForInnerTab = 0;

  late Future<void> _futureAllOrders;

  List<Order> allOrders = [];

  Future<void> _getAllOrders() async {
    var response =
        await HttpService().doGet(path: Endpoints.getCustomerAllOrders());
    try {
      for (var order in response.data['records']) {
        allOrders.add(Order.fromJson(order));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _futureAllOrders = _getAllOrders();
  }

  String formattedDate(String date) {
    var dateTime = DateTime.parse(date);
    return DateFormat('dd-MMM-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: _futureAllOrders,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
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
                itemCount: allOrders.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return OrderWidget(
                    name:
                        '${allOrders[index].customerFirstName ?? '--'} ${allOrders[index].customerLastName ?? '--'}',
                    amount: allOrders[index].orderAmount.toString(),
                    date: formattedDate(allOrders[index].createdDate ??
                        DateTime.now().toString()),
                    items: '${allOrders[index].items} items',
                    orderId: allOrders[index].id,
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
