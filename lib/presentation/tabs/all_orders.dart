import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/common_widgets/order_widget.dart';
import 'package:salesforce_spo/models/order.dart';
import 'package:salesforce_spo/presentation/tabs/open_orders.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';
import 'package:salesforce_spo/services/storage/shared_preferences_service.dart';

class AllOrderTab extends StatefulWidget {
  const AllOrderTab({Key? key}) : super(key: key);

  @override
  _AllOrderTabState createState() => _AllOrderTabState();
}

class _AllOrderTabState extends State<AllOrderTab>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  int currentIndexForInnerTab = 0;

  int offset = 0;
  bool isLoadingData = false;

  ScrollController scrollController = ScrollController();

  late Future<void> _futureAllOrders;

  List<Order> allOrders = [];

  Future<void> _getAllOrders(int offset) async {
    var agentMail = await SharedPreferenceService().getValue('agent_email');
    if(agentMail != null){
      var response =
      await HttpService().doGet(path: Endpoints.getCustomerAllOrders(agentMail,offset));
      isLoadingData = false;
      try {
        for (var order in response.data['records']) {
          allOrders.add(Order.fromJson(order));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
    _futureAllOrders = _getAllOrders(offset);
  }

  String formattedDate(String date) {
    var dateTime = DateTime.parse(date);
    return DateFormat('dd-MMM-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureAllOrders,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting && allOrders.isEmpty){
          return const Center(
            child: SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        } else {
          return ListView.separated(
            controller: scrollController,
            itemCount: allOrders.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return OrderWidget(
                name:
                '${allOrders[index].customerFirstName ?? '--'} ${allOrders[index].customerLastName ?? '--'}',
                amount: '\$ ${allOrders[index].orderAmount.toString()}',
                date: formattedDate(allOrders[index].createdDate ??
                    DateTime.now().toString()),
                items: '${allOrders[index].items} items',
                orderId: allOrders[index].orderNumber ?? '--',
                orderPercentage: '',
                showStatusLabel: true,
                orderStatus: allOrders[index].orderStatus ?? '--',
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
      setState((){
        isLoadingData = true;
        _futureAllOrders = _getAllOrders(offset);
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
