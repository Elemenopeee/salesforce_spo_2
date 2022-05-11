import 'package:flutter/material.dart';

import '../../common_widgets/customer_details_card.dart';
import '../../design_system/design_system.dart';
import '../../models/customer.dart';
import '../../services/networking/endpoints.dart';
import '../../services/networking/networking_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String name = '';

  List<Customer> customers = [];

  Future<void>? futureCustomers;

  Future<void> getCustomer() async {
    var data = await HttpService().doGet(
      path: Endpoints.getCustomerSearchByName(name),
      tokenRequired: true,
    );

    customers.clear();

    try {
      for (var record in data.data['records']) {
        customers.add(Customer.fromJson(json: record));
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              onChanged: (name){
                this.name = name;
                if(this.name.length >= 3){
                  setState(() {
                    futureCustomers = getCustomer();
                  });
                }
              },
              decoration: const InputDecoration(
                hintText: 'Search Name',
                hintStyle: TextStyle(
                  color: ColorSystem.secondary,
                  fontSize: SizeSystem.size18,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorSystem.primary,
                    width: 1,
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: futureCustomers,
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  return ListView.builder(
                    // padding: const EdgeInsets.symmetric(
                    //   horizontal: PaddingSystem.padding20,
                    // ),
                    shrinkWrap: true,
                    itemCount: customers.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomerDetailsCard(
                        customerId: customers[index].id,
                        firstName: customers[index].firstName,
                        lastName: customers[index].lastName,
                        email: customers[index].email,
                        phone: customers[index].phone,
                        preferredInstrument:
                            customers[index].preferredInstrument,
                        lastTransactionDate: customers[index].lastTransactionDate,
                        ltv: customers[index].lifetimeNetUnits,
                        averageProductValue: customers[index].lifeTimeNetSalesAmount,
                        customerLevel: customers[index].medianLTVNet,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
