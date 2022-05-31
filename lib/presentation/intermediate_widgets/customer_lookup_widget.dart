import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String phone = '';
  String email = '';

  List<Customer> customers = [];

  Future? futureCustomers;

  bool showPhoneField = true;
  bool showEmailField = true;

  bool viewFullScreen = false;

  bool? hasRecords;

  bool searchingByPhoneNumber = false;

  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final ScrollController scrollController = ScrollController();

  Future<void> getCustomer(bool searchingByPhoneNumber) async {
    customers.clear();

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

    if (customers.isEmpty) {
      hasRecords = false;
    } else {
      hasRecords = true;
    }

    formKey.currentState?.validate();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    phoneNumberController.addListener(() {
      phone = phoneNumberController.text;
      phone = phone.replaceAll('(', '');
      phone = phone.replaceAll(')', '');
      phone = phone.replaceAll('-', '');
      phone = phone.replaceAll(' ', '');
      searchingByPhoneNumber = true;
      if (phone.length >= 10) {
        setState(() {
          futureCustomers = getCustomer(searchingByPhoneNumber);
        });
      }
    });

    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) {
        if (RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email)) {
          searchingByPhoneNumber = false;
          setState(() {
            futureCustomers = getCustomer(searchingByPhoneNumber);
          });
        }
      }
    });
  }

  double aovCalculator(double? ltv, double? lnt) {
    if (ltv != null && lnt != null) {
      return ltv / lnt;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      onPanUpdate: (details) {
        if (details.delta.dy > 0) {
          if (scrollController.offset <=
              scrollController.position.minScrollExtent) {
            Navigator.of(context).pop();
          }
        }
      },
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
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
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: ColorSystem.white,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(SizeSystem.size10),
                    child: Transform.rotate(
                      angle: -pi / 2,
                      child: SvgPicture.asset(IconSystem.leftArrow),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: SizeSystem.size24,
              ),
              Expanded(
                child: Container(
                  padding:
                  const EdgeInsets.only(top: PaddingSystem.padding48),
                  decoration: const BoxDecoration(
                      color: ColorSystem.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(SizeSystem.size32),
                          topRight: Radius.circular(SizeSystem.size32))),
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                      const Center(
                        child: Text(
                          'Customer',
                          style: TextStyle(
                            color: ColorSystem.primary,
                            fontSize: SizeSystem.size34,
                            fontFamily: kRubik,
                          ),
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
                              Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (showPhoneField)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                            PaddingSystem.padding48),
                                        child: GuitarCentreInputField(
                                          focusNode: phoneFocusNode,
                                          textEditingController:
                                          phoneNumberController,
                                          label: 'Phone',
                                          hintText: '(123) 456-7890',
                                          textInputType: TextInputType.number,
                                          inputFormatters: [
                                            PhoneInputFormatter(
                                              mask: '(###) ###-####',
                                            ),
                                          ],
                                          validator: (error) {
                                            if (hasRecords != null) {
                                              if (!hasRecords! &&
                                                  searchingByPhoneNumber) {
                                                return 'No data found';
                                              } else {
                                                return null;
                                              }
                                            } else {
                                              return null;
                                            }
                                          },
                                          leadingIcon: IconSystem.phone,
                                          suffixIcon: hasRecords != null
                                              ? hasRecords!
                                              ? Column(
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            children: [
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              SvgPicture.asset(
                                                IconSystem
                                                    .checkmark,
                                                color: ColorSystem
                                                    .additionalGreen,
                                                height: 24,
                                              ),
                                            ],
                                          )
                                              : searchingByPhoneNumber
                                              ? InkWell(
                                            onTap: () {
                                              phoneNumberController
                                                  .clear();
                                              setState(() {
                                                hasRecords =
                                                null;
                                                showEmailField =
                                                true;
                                              });
                                              formKey
                                                  .currentState
                                                  ?.validate();
                                            },
                                            focusColor: Colors
                                                .transparent,
                                            splashColor: Colors
                                                .transparent,
                                            hoverColor: Colors
                                                .transparent,
                                            highlightColor:
                                            Colors
                                                .transparent,
                                            child: Column(
                                              mainAxisSize:
                                              MainAxisSize
                                                  .min,
                                              children: const [
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Icon(
                                                  CupertinoIcons
                                                      .clear,
                                                  color: ColorSystem
                                                      .complimentary,
                                                ),
                                              ],
                                            ),
                                          )
                                              : const SizedBox
                                              .shrink()
                                              : const SizedBox.shrink(),
                                        ),
                                      ),
                                    if (showEmailField)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal:
                                            PaddingSystem.padding48),
                                        child: GuitarCentreInputField(
                                          focusNode: emailFocusNode,
                                          textEditingController:
                                          emailController,
                                          label: 'Email',
                                          hintText: 'abc@xyz.com',
                                          textInputType:
                                          TextInputType.emailAddress,
                                          leadingIcon:
                                          IconSystem.messageOutline,
                                          onChanged: (email) {
                                            this.email = email;
                                          },
                                          validator: (error) {
                                            if (hasRecords != null) {
                                              if (!hasRecords! &&
                                                  !searchingByPhoneNumber) {
                                                return 'No data found';
                                              } else {
                                                return null;
                                              }
                                            } else {
                                              return null;
                                            }
                                          },
                                          suffixIcon: hasRecords != null
                                              ? hasRecords!
                                              ? Column(
                                            mainAxisSize:
                                            MainAxisSize.min,
                                            children: [
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              SvgPicture.asset(
                                                IconSystem
                                                    .checkmark,
                                                color: ColorSystem
                                                    .additionalGreen,
                                                height: 24,
                                              ),
                                            ],
                                          )
                                              : !searchingByPhoneNumber
                                              ? InkWell(
                                            onTap: () {
                                              emailController
                                                  .clear();
                                              setState(() {
                                                hasRecords =
                                                null;
                                                showPhoneField =
                                                true;
                                              });
                                              formKey
                                                  .currentState
                                                  ?.validate();
                                            },
                                            focusColor: Colors
                                                .transparent,
                                            splashColor: Colors
                                                .transparent,
                                            hoverColor: Colors
                                                .transparent,
                                            highlightColor:
                                            Colors
                                                .transparent,
                                            child: Column(
                                              mainAxisSize:
                                              MainAxisSize
                                                  .min,
                                              children: const [
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Icon(
                                                  CupertinoIcons
                                                      .clear,
                                                  color: ColorSystem
                                                      .complimentary,
                                                ),
                                              ],
                                            ),
                                          )
                                              : const SizedBox
                                              .shrink()
                                              : const SizedBox.shrink(),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (customers.isNotEmpty)
                                ListView.builder(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: PaddingSystem.padding40,
                                  ),
                                  shrinkWrap: true,
                                  physics:
                                  const NeverScrollableScrollPhysics(),
                                  itemCount: customers.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CustomerDetailsCard(
                                      customerId: customers[index].id,
                                      name: customers[index].name ?? '--',
                                      email: customers[index].email,
                                      phone: customers[index].phone,
                                      preferredInstrument:
                                      customers[index].primaryInstrument,
                                      lastTransactionDate: customers[index]
                                          .lastTransactionDate,
                                      ltv: customers[index]
                                          .lifeTimeNetSalesAmount ?? 0,
                                      averageProductValue: aovCalculator(
                                          customers[index]
                                              .lifeTimeNetSalesAmount,
                                          customers[index]
                                              .lifetimeNetTransactions),
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
                                    !states
                                        .contains(MaterialState.disabled)) {
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
                          onPressed: hasRecords != null && !hasRecords!
                              ? () async {
                            try {
                              await launchUrlString(
                                  'salesforce1://sObject/Account/view');
                            } catch (e) {
                              print(e);
                            }
                          }
                              : null,
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
                    ],
                  ),
                ),
              ),],
            ),
          ),
        ),
      );
  }
}
