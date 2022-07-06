import 'dart:convert';
import 'dart:ui';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/common_widgets/subject_widget.dart';
import 'package:salesforce_spo/common_widgets/task_client_profile_widget.dart';
import 'package:salesforce_spo/models/customer.dart';
import 'package:salesforce_spo/utils/constants.dart';
import 'package:salesforce_spo/utils/constant_functions.dart';
import 'package:salesforce_spo/common_widgets/customer_details_card.dart';
import 'package:salesforce_spo/common_widgets/input_field_with_validation.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/services/networking/endpoints.dart';
import 'package:salesforce_spo/services/networking/http_response.dart';
import 'package:salesforce_spo/services/networking/networking_service.dart';
import 'package:salesforce_spo/utils/phone_input_formatter.dart';

import '../../common_widgets/create_task_comment_widget.dart';
import '../../common_widgets/create_task_date_widget.dart';
import '../../services/networking/request_body.dart';
import '../../services/storage/shared_preferences_service.dart';

class CreateNewTaskWidget extends StatefulWidget {
  final String agentName;

  const CreateNewTaskWidget({
    Key? key,
    required this.agentName,
  }) : super(key: key);

  @override
  State<CreateNewTaskWidget> createState() => _CreateNewTaskWidgetState();
}

class _CreateNewTaskWidgetState extends State<CreateNewTaskWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String phone = '';
  String email = '';
  String userName = '';
  String searchedName = '';
  List<Customer> customers = [];
  Future? futureCustomers;
  bool showPhoneField = true;
  bool showEmailField = true;
  bool showuserNameField = false;
  bool showProceedButton = true;
  bool showSearchNameField = true;
  bool viewFullScreen = false;
  bool? hasRecords;
  bool searchingByPhoneNumber = false;
  bool searchingByUserName = false;
  bool secondStepper = false;
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode userNameNode = FocusNode();
  final FocusNode searchedNameNode = FocusNode();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController searchedNamedController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  int offset = 0;
  final Map<String, dynamic> commentBody = {
    'comment': '',
  };
  final Map<String, dynamic> dueDateMap = {
    'dueDate': '',
  };
  final Map<String, dynamic> subjectBody = {
    'subject': 'Call alert',
  };

  String customerFirstName = '';
  String customerLastName = '';

  String agentName = '';

  bool searchingComplete = false;

  get task => null;

  Future<void> getCustomer(bool searchingByPhoneNumber, {offset = 0}) async {
    searchingComplete = false;

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
        if (customers.isEmpty) {
          showuserNameField = true;
        }
        if (customers.isNotEmpty) {
          showEmailField = false;
          showProceedButton = false;
          showSearchNameField = false;
        }
      } catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } else if (searchingByUserName) {
      if (offset == 0) {
        customers.clear();
      }
      var data = await HttpService().doGet(
        path: Endpoints.getCustomerSearchByName(
          searchedName,
          offset!,
        ),
        tokenRequired: true,
      );
      resultSorter(data);
      searchingComplete = true;
    } else {
      var data = await HttpService().doGet(
        path: Endpoints.getCustomerSearchByEmail(email),
        tokenRequired: true,
      );
      try {
        for (var record in data.data['records']) {
          customers.add(Customer.fromJson(json: record));
        }
        if (customers.isEmpty) {
          showuserNameField = true;
        }
        if (customers.isNotEmpty) {
          showPhoneField = false;
          showSearchNameField = false;
          showProceedButton = false;
        }
      } catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    }
    if (customers.isEmpty) {
      hasRecords = false;
      showuserNameField = true;
    } else {
      hasRecords = true;
    }
    formKey.currentState?.validate();
    setState(() {});
  }

  Future<void> createNewTask() async {
    var ownerId = await SharedPreferenceService().getValue(agentId);

    if(customerFirstName.isEmpty){
      customerFirstName = userName.split(' ')[0];
    }

    if(customerLastName.isEmpty){
      customerLastName = userName.split(' ')[1];
    }

    if(phone.isEmpty){
      phone = '0000000000';
    }
    if(email.isEmpty){
      email = 'abc@gmail.com';
    }

    var requestBody = RequestBody.getCreateTaskBody(
      parentTaskId: '',
      subject: subjectBody['subject'],
      dueDate: dueDateMap['dueDate'],
      selectedOrders: [],
      comment: commentBody['comment'],
      whatId: '',
      whoId: '',
      ownerId: ownerId,
      firstName: customerFirstName,
      lastName: customerLastName,
      email: email,
      phone: phone,
    );

    var response = await HttpService()
        .doPost(path: Endpoints.getCreateTask(), body: jsonEncode(requestBody));

    print(response.data);
  }

  void scrollListener() {
    var maxExtent = scrollController.position.maxScrollExtent;
    var loadingPosition = maxExtent - (maxExtent * 0.4);
    if (scrollController.position.extentAfter < loadingPosition) {
      offset = offset + 10;
      setState(() {
        futureCustomers = getCustomer(
          false,
          offset: offset,
        );
      });
    }
  }

  void resultSorter(HttpResponse data) {
    var temporaryCustomersList = <Customer>[];
    try {
      for (var record in data.data['records']) {
        temporaryCustomersList.add(Customer.fromJson(json: record));
      }

      if (temporaryCustomersList.isNotEmpty) {
        temporaryCustomersList.sort((a, b) {
          if (a.name != null && b.name != null) {
            return a.name!.compareTo(b.name!);
          } else {
            return -1;
          }
        });
      }
      customers.addAll(temporaryCustomersList);
      showProceedButton = false;
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    phoneNumberController.addListener(() {
      phone = phoneNumberController.text;
      phone = phone.replaceFirst('(', '');
      phone = phone.replaceFirst(')', '');
      phone = phone.replaceFirst(' ', '');
      phone = phone.replaceFirst('-', '');
      searchingByPhoneNumber = true;
      searchingByUserName = false;
      if (phone.length >= 10) {
        setState(() {
          futureCustomers = getCustomer(searchingByPhoneNumber);
        });
      }
    });
    searchedNamedController.addListener(() {
      searchedName = searchedNamedController.text;
      searchingByPhoneNumber = false;
      searchingByUserName = true;
      if (userName.isNotEmpty) {
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
          searchingByUserName = false;
          showuserNameField = false;
          setState(() {
            futureCustomers = getCustomer(searchingByPhoneNumber);
          });
        }
      }
    });
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
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
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
                    padding: const EdgeInsets.all(
                      SizeSystem.size10,
                    ),
                    child: const Icon(
                      CupertinoIcons.clear,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: SizeSystem.size24,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: PaddingSystem.padding48,
                  ),
                  decoration: const BoxDecoration(
                    color: ColorSystem.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        SizeSystem.size32,
                      ),
                      topRight: Radius.circular(
                        SizeSystem.size32,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(
                          16.0,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              IconSystem.followUpTaskIcon,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Create Task',
                              style: TextStyle(
                                color: ColorSystem.primary,
                                fontSize: SizeSystem.size16,
                                fontWeight: FontWeight.w600,
                                fontFamily: kRubik,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          physics: const ClampingScrollPhysics(),
                          children: [
                            if (!searchingByUserName)
                              const SizedBox(
                                height: 12,
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
                                          if (showPhoneField &&
                                              !searchingByUserName &&
                                              !secondStepper)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal:
                                                    PaddingSystem.padding48,
                                              ),
                                              child: GuitarCentreInputField(
                                                focusNode: phoneFocusNode,
                                                textEditingController:
                                                    phoneNumberController,
                                                label: 'Phone',
                                                hintText: '(123) 456-7890',
                                                textInputType:
                                                    TextInputType.number,
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
                                                suffixIcon: hasRecords !=
                                                            null &&
                                                        searchingByPhoneNumber
                                                    ? hasRecords!
                                                        ? Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
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
                                                        : InkWell(
                                                            onTap: () {
                                                              phoneNumberController
                                                                  .clear();
                                                              setState(() {
                                                                showuserNameField =
                                                                    false;
                                                                hasRecords =
                                                                    null;
                                                                showEmailField =
                                                                    true;
                                                                showProceedButton =
                                                                    true;
                                                                showSearchNameField =
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
                                                    : const SizedBox.shrink(),
                                              ),
                                            ),
                                          if (showEmailField &&
                                              !searchingByUserName &&
                                              !secondStepper)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal:
                                                    PaddingSystem.padding48,
                                              ),
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
                                                                MainAxisSize
                                                                    .min,
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
                                                                    showuserNameField =
                                                                        false;
                                                                    showProceedButton =
                                                                        false;
                                                                    hasRecords =
                                                                        null;
                                                                    showPhoneField =
                                                                        true;
                                                                    showProceedButton =
                                                                        true;
                                                                    showSearchNameField =
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
                                    if (customers.isNotEmpty &&
                                        !secondStepper &&
                                        !searchingByUserName)
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
                                            onTap: () {
                                              userName =
                                                  customers[index].name ?? '--';
                                              customerFirstName =
                                                  customers[index].firstName;
                                              customerLastName =
                                                  customers[index].lastName;
                                              email = customers[index].email ??
                                                  '--';
                                              phone = customers[index].phone ??
                                                  '--';
                                              setState(() {
                                                secondStepper = true;
                                              });
                                            },
                                            customerId: customers[index].id,
                                            name: customers[index].name ?? '--',
                                            email: customers[index].email,
                                            phone: customers[index].phone,
                                            preferredInstrument:
                                                customers[index]
                                                    .primaryInstrument,
                                            lastTransactionDate:
                                                customers[index]
                                                    .lastTransactionDate,
                                            ltv: customers[index]
                                                    .lifeTimeNetSalesAmount ??
                                                0,
                                            averageProductValue: aovCalculator(
                                                customers[index]
                                                    .lifeTimeNetSalesAmount,
                                                customers[index]
                                                    .lifetimeNetTransactions),
                                            customerLevel:
                                                customers[index].medianLTVNet,
                                            epsilonCustomerKey: customers[index]
                                                .epsilonCustomerBrandKey,
                                          );
                                        },
                                      ),
                                  ],
                                );
                              },
                            ),
                            if (!searchingByUserName && !secondStepper)
                              const SizedBox(
                                height: 8,
                              ),
                            if (showuserNameField && !secondStepper)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: PaddingSystem.padding48,
                                ),
                                child: GuitarCentreInputField(
                                  focusNode: userNameNode,
                                  textEditingController: userNameController,
                                  label: 'Customer Name',
                                  hintText: 'Add full name',
                                  textInputType: TextInputType.emailAddress,
                                  onChanged: (userName) {
                                    this.userName = userName;
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
                                  suffixIcon: !searchingByUserName &&
                                          hasRecords != null
                                      ? hasRecords!
                                          ? Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                SvgPicture.asset(
                                                  IconSystem.checkmark,
                                                  color: ColorSystem
                                                      .additionalGreen,
                                                  height: 24,
                                                ),
                                              ],
                                            )
                                          : null
                                      : const SizedBox.shrink(),
                                ),
                              ),
                            if (!searchingByUserName && !secondStepper)
                              const SizedBox(
                                height: 20,
                              ),
                            if (showProceedButton &&
                                !searchingByUserName &&
                                !secondStepper)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: PaddingSystem.padding48,
                                ),
                                child: TextButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.resolveWith<
                                            RoundedRectangleBorder>(
                                        (states) => RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states.contains(
                                                MaterialState.pressed) ||
                                            !states.contains(
                                                MaterialState.disabled)) {
                                          return ColorSystem.primary;
                                        } else if (states
                                            .contains(MaterialState.disabled)) {
                                          return ColorSystem.primary
                                              .withOpacity(
                                                  OpacitySystem.opacity01);
                                        }
                                        return ColorSystem.primary.withOpacity(
                                            OpacitySystem.opacity01);
                                      },
                                    ),
                                  ),
                                  onPressed: hasRecords != null && !hasRecords!
                                      ? () async {
                                          try {
                                            setState(() {
                                              secondStepper = true;
                                            });
                                          } catch (e) {}
                                        }
                                      : null,
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        PaddingSystem.padding8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'PROCEED MANUALLY',
                                          style: TextStyle(
                                            color: ColorSystem.white,
                                            fontSize: SizeSystem.size18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            if (!searchingByUserName && !secondStepper)
                              const SizedBox(
                                height: 8,
                              ),
                            if (showSearchNameField && !secondStepper)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: PaddingSystem.padding40,
                                ),
                                child: Row(
                                  children: [
                                    if (searchingByUserName)
                                      InkWell(
                                          onTap: () {
                                            emailController.clear();
                                            phoneNumberController.clear();
                                            searchedNamedController.clear();
                                            customers.clear();
                                            setState(() {
                                              searchingByUserName = false;
                                            });
                                          },
                                          child: const Icon(Icons.arrow_back)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        focusNode: searchedNameNode,
                                        controller: searchedNamedController,
                                        decoration: InputDecoration(
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
                                                          IconSystem.checkmark,
                                                          color: ColorSystem
                                                              .additionalGreen,
                                                          height: 24,
                                                        ),
                                                      ],
                                                    )
                                                  : null
                                              : const SizedBox.shrink(),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorSystem.primary,
                                              width: 1,
                                            ),
                                          ),
                                          hintText: 'Search by Name',
                                          labelStyle: const TextStyle(
                                            color: ColorSystem.secondary,
                                            fontSize: SizeSystem.size14,
                                            fontFamily: kRubik,
                                          ),
                                          suffixIconConstraints:
                                              const BoxConstraints(
                                            maxWidth: SizeSystem.size24,
                                            maxHeight: SizeSystem.size36,
                                          ),
                                        ),
                                        onTap: () {
                                          setState(() {
                                            searchingByUserName = true;
                                          });
                                          searchedNameNode.requestFocus();
                                        },
                                        onChanged: (searchedName) {
                                          offset = 0;
                                          this.searchedName = searchedName;
                                          EasyDebounce.cancelAll();
                                          if (this.searchedName.length >= 3) {
                                            EasyDebounce.debounce(
                                                'search_name_debounce',
                                                Duration(seconds: 1), () {
                                              setState(() {
                                                futureCustomers = getCustomer(
                                                    false,
                                                    offset: offset);
                                              });
                                            });
                                          }
                                        },
                                        validator: (error) {
                                          if (hasRecords!) {
                                            return 'No data found';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            if (!searchingByUserName && !secondStepper)
                              const SizedBox(
                                height: 24,
                              ),
                            if (searchingByUserName && !secondStepper)
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
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
                                          onTap: () {
                                            userName =
                                                customers[index].name ?? '--';
                                            customerFirstName =
                                                customers[index].firstName;
                                            customerLastName =
                                                customers[index].lastName;
                                            email =
                                                customers[index].email ?? '--';
                                            phone =
                                                customers[index].phone ?? '--';
                                            setState(() {
                                              secondStepper = true;
                                            });
                                          },
                                          customerId: customers[index].id,
                                          name: customers[index].name ?? '--',
                                          email: customers[index].email,
                                          phone: customers[index].phone,
                                          preferredInstrument: customers[index]
                                              .primaryInstrument,
                                          lastTransactionDate: customers[index]
                                              .lastTransactionDate,
                                          ltv: customers[index]
                                                  .lifeTimeNetSalesAmount ??
                                              0,
                                          averageProductValue: aovCalculator(
                                              customers[index]
                                                  .lifeTimeNetSalesAmount,
                                              customers[index]
                                                  .lifetimeNetTransactions),
                                          customerLevel:
                                              customers[index].medianLTVNet,
                                          epsilonCustomerKey: customers[index]
                                              .epsilonCustomerBrandKey,
                                        );
                                      },
                                    ),
                                  if (customers.isEmpty && searchingComplete)
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: SizeSystem.size20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: PaddingSystem.padding48,
                                          ),
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
                                            onChanged: (value) {
                                              phone = value;
                                            },
                                            leadingIcon: IconSystem.phone,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: PaddingSystem.padding48,
                                          ),
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
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: PaddingSystem.padding48,
                                          ),
                                          child: GuitarCentreInputField(
                                            focusNode: userNameNode,
                                            textEditingController:
                                                userNameController,
                                            label: 'Customer Name',
                                            hintText: 'Add full name',
                                            textInputType:
                                                TextInputType.emailAddress,
                                            onChanged: (userName) {
                                              this.userName = userName;
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: SizeSystem.size20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: PaddingSystem.padding48,
                                          ),
                                          child: TextButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty
                                                  .resolveWith<
                                                          RoundedRectangleBorder>(
                                                      (states) =>
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12))),
                                              backgroundColor:
                                                  MaterialStateProperty
                                                      .resolveWith<Color>(
                                                (Set<MaterialState> states) {
                                                  if (states.contains(
                                                          MaterialState
                                                              .pressed) ||
                                                      !states.contains(
                                                          MaterialState
                                                              .disabled)) {
                                                    return ColorSystem.primary;
                                                  } else if (states.contains(
                                                      MaterialState.disabled)) {
                                                    return ColorSystem.primary
                                                        .withOpacity(
                                                            OpacitySystem
                                                                .opacity01);
                                                  }
                                                  return ColorSystem.primary
                                                      .withOpacity(OpacitySystem
                                                          .opacity01);
                                                },
                                              ),
                                            ),
                                            onPressed: hasRecords != null &&
                                                    !hasRecords!
                                                ? () async {
                                                    try {
                                                      setState(() {
                                                        secondStepper = true;
                                                      });
                                                    } catch (e) {
                                                      if (kDebugMode) {
                                                        print(e);
                                                      }
                                                    }
                                                  }
                                                : null,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                  PaddingSystem.padding8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: const [
                                                  Text(
                                                    'PROCEED MANUALLY',
                                                    style: TextStyle(
                                                      color: ColorSystem.white,
                                                      fontSize:
                                                          SizeSystem.size18,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            if (secondStepper)
                              Padding(
                                padding: const EdgeInsets.all(
                                    PaddingSystem.padding8),
                                child: ProfileWidget(
                                  name: userName,
                                  number: phone,
                                  email: email,
                                ),
                              ),
                            if (secondStepper)
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SubjectWidget(
                                  subjectBody: subjectBody,
                                ),
                              ),
                            if (secondStepper)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: PaddingSystem.padding16,
                                ),
                                child: CreateTaskDateWidget(
                                  dueByDate: DateFormat('yyyy-MM-dd').format(
                                      DateTime(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day + 1)),
                                  dueDateMap: dueDateMap,
                                  assigneeName: widget.agentName,
                                ),
                              ),
                            if (secondStepper)
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: CreateTaskCommentWidget(
                                  commentBody: commentBody,
                                ),
                              ),
                            if (secondStepper)
                              Padding(
                                padding: const EdgeInsets.all(
                                  PaddingSystem.padding16,
                                ),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              ColorSystem.primary),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ))),
                                  onPressed: () async {
                                    await createNewTask();
                                    Navigator.of(context).pop();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: PaddingSystem.padding22),
                                        child: Text(
                                          'Create Task',
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: kRubik,
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
