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
import 'package:salesforce_spo/utils/constants.dart';
import 'package:salesforce_spo/utils/phone_input_formatter.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

  Future? futureCustomers;

  bool showPhoneField = true;
  bool showEmailField = true;

  bool viewFullScreen = false;

  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> getCustomer(bool searchingByPhoneNumber) async {
    if (searchingByPhoneNumber) {
      var data = await HttpService().doGet(
        path: Endpoints.getCustomerSearchByPhone(phone),
        tokenRequired: true,
      );

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
      var data = await HttpService().doGet(
        path: Endpoints.getCustomerSearchByEmail(email),
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
      if (phoneFocusNode.hasFocus) {
        phone = phoneNumberController.text;
        phone = phone.replaceAll('(', '');
        phone = phone.replaceAll(')', '');
        phone = phone.replaceAll('-', '');
        phone = phone.replaceAll(' ', '');
      }
      if (phone.length >= 10) {
        setState(() {
          futureCustomers = getCustomer(true);
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
            futureCustomers = getCustomer(false);
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              // if (!viewFullScreen)
              //   const SizedBox(
              //     height: 100,
              //   ),
              InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    viewFullScreen = true;
                  });
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: ColorSystem.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(SizeSystem.size10),
                  child: Transform.rotate(
                    angle: pi / 2,
                    child: SvgPicture.asset(IconSystem.leftArrow),
                  ),
                ),
              ),
              const SizedBox(
                height: SizeSystem.size24,
              ),
              Container(
                padding: const EdgeInsets.only(top: PaddingSystem.padding48),
                decoration: const BoxDecoration(
                    color: ColorSystem.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(SizeSystem.size32),
                        topRight: Radius.circular(SizeSystem.size32))),
                child: Column(
                  children: [
                    const Text(
                      'Customer',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        fontSize: SizeSystem.size34,
                        fontFamily: kRubik,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: PaddingSystem.padding40),
                      child: Text(
                        'Please enter your phone number to search a customer',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorSystem.primary,
                            fontSize: SizeSystem.size16),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    FutureBuilder(
                      future: futureCustomers,
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (showPhoneField)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: PaddingSystem.padding48),
                                child: GuitarCentreInputField(
                                  focusNode: phoneFocusNode,
                                  textEditingController: phoneNumberController,
                                  label: 'Phone',
                                  hintText: '(123) 456-7890',
                                  textInputType: TextInputType.number,
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: PaddingSystem.padding48),
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
                                  horizontal: PaddingSystem.padding40,
                                ),
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
                                    lastTransactionDate:
                                        customers[index].lastTransactionDate,
                                    ltv: customers[index].lifetimeNetUnits,
                                    averageProductValue:
                                        customers[index].lifeTimeNetSalesAmount,
                                    customerLevel:
                                        customers[index].medianLTVNet,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: PaddingSystem.padding48),
                      child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.resolveWith<
                                  RoundedRectangleBorder>(
                              (states) => RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed) ||
                                  !states.contains(MaterialState.disabled)) {
                                return ColorSystem.primary;
                              } else if (states
                                  .contains(MaterialState.disabled)) {
                                return ColorSystem.primary
                                    .withOpacity(OpacitySystem.opacity01);
                              }
                              return ColorSystem.primary
                                  .withOpacity(OpacitySystem.opacity01);
                            },
                          ),
                        ),
                        onPressed: () async {
                          try{
                            await launchUrlString('salesforce1://sObject/Account/view');
                          } catch (e){
                            print(e);
                          }
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.all(PaddingSystem.padding8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '+ADD NEW CUSTOMER',
                                style: TextStyle(
                                    color: ColorSystem.white,
                                    fontSize: SizeSystem.size18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: PaddingSystem.padding48,
                          vertical: PaddingSystem.padding20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return const SearchScreen();
                          }));
                        },
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        child: TextFormField(
                          enabled: false,
                          decoration: const InputDecoration(
                            hintText: 'Search Name',
                            hintStyle: TextStyle(
                              color: ColorSystem.secondary,
                              fontSize: SizeSystem.size18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        SizedBox(
                          height: 200,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
