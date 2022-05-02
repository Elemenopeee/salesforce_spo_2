import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/common_widgets/customer_details_card.dart';
import 'package:salesforce_spo/common_widgets/input_field_with_validation.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/models/customer.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';
import 'package:salesforce_spo/utils/phone_input_formatter.dart';

import '../screens/search_screen.dart';

class CustomerLookupWidget extends StatefulWidget {
  const CustomerLookupWidget({Key? key}) : super(key: key);

  @override
  State<CustomerLookupWidget> createState() => _CustomerLookupWidgetState();
}

class _CustomerLookupWidgetState extends State<CustomerLookupWidget> {
  String phone = '';
  String email = '';

  List<Customer> customers = [];

  Future? _futureCustomers;

  bool showPhoneField = true;
  bool showEmailField = true;

  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> getCustomer(bool searchingByPhoneNumber) async {
    print(searchingByPhoneNumber);
    if (searchingByPhoneNumber) {
      // var editedPhone = phone.replaceAll(' ', '');
      // editedPhone = editedPhone.replaceAll('(', '');
      // editedPhone = editedPhone.replaceAll(')', '');

      var editedPhone = ') 326-9711';

      var data = await HttpService().doGet(
          path: '$kBaseURL$kCustomerSearchByPhone\'$editedPhone\'',
          tokenRequired: true);

      try {
        for (var record in data.data['records']) {
          customers.add(Customer.fromJson(json: record));
        }

        if (customers.isNotEmpty) {
          showEmailField = false;
        }
      } catch (error) {
        print(error);
      }
    } else {
      print(email);
      var data = await HttpService().doGet(
        path: '$kBaseURL$kCustomerSearchByEmail\'$email\'',
        tokenRequired: true,
      );
      try {
        for (var record in data.data['records']) {
          customers.add(Customer.fromJson(json: record));
        }
        if (customers.isNotEmpty) {
          showPhoneField = false;
        }
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    phoneNumberController.addListener(() {
      if (phoneNumberController.text.length == 10) {
        setState(() {
          _futureCustomers = getCustomer(true);
        });
      }
    });

    emailController.addListener(() {});

    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) {
        if (RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email)) {
          setState(() {
            _futureCustomers = getCustomer(false);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorSystem.white,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(10),
              child: Transform.rotate(
                angle: pi / 2,
                child: SvgPicture.asset(IconSystem.leftArrow),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 48),
                decoration: const BoxDecoration(
                    color: ColorSystem.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32))),
                child: Column(
                  children: [
                    const Text(
                      'Customer',
                      style:
                          TextStyle(color: ColorSystem.primary, fontSize: 34),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Please enter your phone number to search a customer',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: ColorSystem.primary, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    FutureBuilder(
                      future: _futureCustomers,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (showPhoneField)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 48),
                                child: GuitarCentreInputField(
                                  textEditingController: phoneNumberController,
                                  label: 'Phone',
                                  hintText: '+1 (123) 456 7890',
                                  textInputType: TextInputType.number,
                                  onChanged: (phone) {
                                    this.phone = phone;
                                  },
                                  inputFormatters: [
                                    PhoneInputFormatter(
                                      mask: '(###) ###-####',
                                    ),
                                  ],
                                  leadingIcon: IconSystem.phone,
                                ),
                              ),
                            if (showEmailField)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 48),
                                child: GuitarCentreInputField(
                                  focusNode: emailFocusNode,
                                  textEditingController: emailController,
                                  label: 'Email',
                                  hintText: 'abc@xyz.com',
                                  textInputType: TextInputType.emailAddress,
                                  leadingIcon: IconSystem.messageOutline,
                                  onChanged: (email) {
                                    this.email = email;
                                  },
                                ),
                              ),
                            if (customers.isNotEmpty)
                              ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                ),
                                shrinkWrap: true,
                                itemCount: customers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CustomerDetailsCard(
                                    firstName: customers[index].firstName,
                                    lastName: customers[index].lastName,
                                    email: customers[index].email,
                                    phone: customers[index].phone,
                                    preferredInstrument:
                                        customers[index].preferredInstrument,
                                  );
                                },
                              ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48),
                      child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.resolveWith<
                                  RoundedRectangleBorder>(
                              (states) => RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16))),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed) ||
                                  !states.contains(MaterialState.disabled))
                                return ColorSystem.primary;
                              else if (states.contains(MaterialState.disabled))
                                return ColorSystem.primary
                                    .withOpacity(OpacitySystem.opacity01);
                              return ColorSystem.primary
                                  .withOpacity(OpacitySystem.opacity01);
                            },
                          ),
                        ),
                        onPressed: null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '+ADD NEW CUSTOMER',
                                style: TextStyle(
                                    color: ColorSystem.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 48, vertical: 20),
                      child: InkWell(
                        onTap: (){
                          print('Here');
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                            return const SearchScreen();
                          }));
                        },
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: 'Search Name',
                            hintStyle: const TextStyle(
                              color: ColorSystem.secondary,
                              fontSize: SizeSystem.size18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
