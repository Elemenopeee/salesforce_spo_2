import 'package:flutter/material.dart';

class AllOrderTab extends StatefulWidget {
  const AllOrderTab({Key? key}) : super(key: key);

  @override
  _AllOrderTabState createState() => _AllOrderTabState();
}

class _AllOrderTabState extends State<AllOrderTab>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  int currentIndexForInnerTab = 0;

  @override
  void initState() {
    super.initState();
  }

  var listOfOrderName = [
    "Vivek Limbani",
    "Jack Sparrow",
    "Trace Allison",
    "Stiles Arron",
    "Stiles Arron",
    "Stiles Arron",
    "Stiles Arron",
  ];
  var listOfOrderAmount = [
    "229.99",
    "229.99",
    "229.99",
    "229.99",
    "229.99",
    "229.99",
    "229.99",
  ];
  var listOfOrderDate = [
    "12-Mar-2022",
    "12-Mar-2022",
    "12-Mar-2022",
    "12-Mar-2022",
    "12-Mar-2022",
    "12-Mar-2022",
    "12-Mar-2022",
  ];
  var listOfOrderItems = [
    "02 Items",
    "12 Items",
    "05 Items",
    "07 Items",
    "07 Items",
    "07 Items",
    "07 Items",
  ];
  var listOfOrderID = [
    "OID: 323992999",
    "OID: 323992999",
    "OID: 323992999",
    "OID: 323992999",
    "OID: 323992999",
    "OID: 323992999",
    "OID: 323992999",
  ];
  var listOfOrderPercentage = [
    "100%",
    "30%",
    "100%",
    "20%",
    "20%",
    "20%",
    "20%",
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: getAllOrder(),
    );
  }

  Widget getAllOrder() {
    return ListView.builder(
        itemCount: listOfOrderName.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              getAllOrderList(context, index),
              Container(
                color: Colors.white,
                child: Divider(
                  color: Colors.grey.withOpacity(0.2),
                  thickness: 1,
                ),
              ),
            ],
          );
        });
  }

  Widget getAllOrderList(BuildContext context, int index) {
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
                listOfOrderName[index],
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 05,
              ),
              Text(
                listOfOrderDate[index],
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 05,
              ),
              Text(
                listOfOrderID[index],
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                listOfOrderAmount[index],
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 05,
              ),
              Text(
                listOfOrderItems[index],
                style:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 05,
              ),
              Text(
                listOfOrderPercentage[index],
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}