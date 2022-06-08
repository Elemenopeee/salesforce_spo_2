import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/common_widgets/priority_status_container.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/design_system/primitives/icon_system.dart';

import '../../../models/case.dart';
import '../../../services/networking/endpoints.dart';
import '../../../services/networking/networking_service.dart';
import '../../../utils/constants.dart';
import 'orders_tab.dart';

class CasesProductList extends StatefulWidget {
  final String customerID;

  const CasesProductList({Key? key, required this.customerID})
      : super(key: key);

  @override
  _CasesProductListState createState() => _CasesProductListState();
}

class _CasesProductListState extends State<CasesProductList> {
  List<Case> openCases = [];
  List<Case> closedCases = [];

  bool isLoading = true;

  late Future<void> _futureOpenCases;
  late Future<void> _futureClosedCases;

  int offset = 0;
  bool isLoadingData = false;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getOpenCasesList();
    _futureOpenCases = getOpenCasesList();
    _futureClosedCases = getClosedCasesList();
    super.initState();
  }

  Future<void> getOpenCasesList() async {
    openCases.clear();

    var response = await HttpService()
        .doGet(path: Endpoints.getClientOpenCases(widget.customerID));
    isLoadingData = false;
    try {
      for (var cases in response.data['records']) {
        openCases.add(Case.fromJson(cases));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getClosedCasesList() async {
    closedCases.clear();
    var response = await HttpService()
        .doGet(path: Endpoints.getClientClosedCases(widget.customerID));
    isLoadingData = false;
    try {
      for (var cases in response.data['records']) {
        closedCases.add(Case.fromJson(cases));
      }
    } catch (e) {
      print(e);
    }
  }

  String dateFormatter(String? caseDate) {
    if (caseDate == null) {
      return '--';
    } else {
      return DateFormat('MM-dd-yyyy').format(DateTime.parse(caseDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          _futureOpenCases,
          _futureClosedCases,
        ]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const Center(
                child: CircularProgressIndicator(
                  color: ColorSystem.primary,
                ),
              );
            case ConnectionState.done:
              if (openCases.isEmpty) {
                return Column(
                  children: [
                    const SizedBox(
                      height: SizeSystem.size50,
                    ),
                    SvgPicture.asset(IconSystem.noDataFound),
                    const SizedBox(
                      height: SizeSystem.size24,
                    ),
                    const Text(
                      'NO DATA FOUND!',
                      style: TextStyle(
                        color: ColorSystem.primary,
                        fontWeight: FontWeight.bold,
                        fontFamily: kRubik,
                        fontSize: SizeSystem.size20,
                      ),
                    )
                  ],
                );
              }

              return ListView(
                children: [
                  if (openCases.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Open Orders',
                        style: TextStyle(
                          color: ColorSystem.primary,
                          fontSize: SizeSystem.size16,
                          fontFamily: kRubik,
                        ),
                      ),
                    ),
                  if (openCases.isNotEmpty)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: openCases.length,
                      itemBuilder: (BuildContext context, int index) {
                        return OpenCaseWidget(
                          subject: openCases[index].subject,
                          priority: openCases[index].priority,
                          name: openCases[index].account?.name,
                          createdDate:
                              dateFormatter(openCases[index].createdDate),
                          caseNumber: openCases[index].caseNumber,
                          status: openCases[index].status,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 1,
                          color: ColorSystem.secondary.withOpacity(0.3),
                        );
                      },
                    ),
                  if (openCases.isNotEmpty)
                    Container(
                      height: 1,
                      color: ColorSystem.secondary.withOpacity(0.3),
                    ),
                  if (closedCases.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.all(SizeSystem.size16),
                      child: Text(
                        'Order History',
                        style: TextStyle(
                          color: ColorSystem.primary,
                          fontSize: SizeSystem.size16,
                          fontFamily: kRubik,
                        ),
                      ),
                    ),
                  if (closedCases.isNotEmpty)
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(
                            left: PaddingSystem.padding12),
                        itemCount: closedCases.length,
                        itemBuilder: (context, index) {
                          return index != 0
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        const DashGenerator(
                                          numberOfDashes: 6,
                                        ),
                                        Expanded(
                                          child: Container(
                                            color: ColorSystem.secondary
                                                .withOpacity(0.3),
                                            height: 0.5,
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          closedCases[index]
                                                      .status ==
                                                  'Resolved'
                                              ? CupertinoIcons
                                                  .check_mark_circled
                                              : CupertinoIcons.clear_circled,
                                          color: closedCases[index].status ==
                                                  'Resolved'
                                              ? ColorSystem.additionalGreen
                                              : ColorSystem.complimentary,
                                        ),
                                        const SizedBox(
                                          width: SizeSystem.size20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              closedCases[index].subject ??
                                                  '--',
                                              style: const TextStyle(
                                                color: ColorSystem.primary,
                                                fontFamily: kRubik,
                                                fontWeight: FontWeight.bold,
                                                fontSize: SizeSystem.size12,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: SizeSystem.size4,
                                            ),
                                            Text(
                                              'By: ${closedCases[index].account?.name ?? '--'} | ${dateFormatter(closedCases[index].createdDate)}',
                                              style: const TextStyle(
                                                color: ColorSystem.secondary,
                                                fontFamily: kRubik,
                                                fontSize: SizeSystem.size12,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: SizeSystem.size4,
                                            ),
                                            Text(
                                              closedCases[index].caseNumber ?? '--',
                                              style: const TextStyle(
                                                color: ColorSystem.secondary,
                                                fontFamily: kRubik,
                                                fontSize: SizeSystem.size12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        const SizedBox(
                                          width: SizeSystem.size16,
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              : Row(
                                  children: [
                                    Icon(
                                      closedCases[index].status == 'Resolved'
                                          ? CupertinoIcons.check_mark_circled
                                          : CupertinoIcons.clear_circled,
                                      color: closedCases[index].status ==
                                              'Resolved'
                                          ? ColorSystem.additionalGreen
                                          : ColorSystem.complimentary,
                                    ),
                                    const SizedBox(
                                      width: SizeSystem.size20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          closedCases[index].subject ??
                                              '--',
                                          style: const TextStyle(
                                            color: ColorSystem.primary,
                                            fontFamily: kRubik,
                                            fontWeight: FontWeight.bold,
                                            fontSize: SizeSystem.size12,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: SizeSystem.size4,
                                        ),
                                        Text(
                                          'By: ${closedCases[index].account?.name ?? '--'} | ${dateFormatter(closedCases[index].createdDate)}',
                                          style: const TextStyle(
                                            color: ColorSystem.secondary,
                                            fontFamily: kRubik,
                                            fontSize: SizeSystem.size12,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: SizeSystem.size4,
                                        ),
                                        Text(
                                          closedCases[index].caseNumber ?? '--',
                                          style: const TextStyle(
                                            color: ColorSystem.secondary,
                                            fontFamily: kRubik,
                                            fontSize: SizeSystem.size12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    const SizedBox(
                                      width: SizeSystem.size16,
                                    ),
                                  ],
                                );
                        }),
                  Container(
                    height: 1,
                    margin: const EdgeInsets.symmetric(
                        vertical: PaddingSystem.padding10),
                    color: ColorSystem.secondary.withOpacity(0.3),
                  ),
                ],
              );
          }
        });
  }

  void scrollListener() {
    var maxExtent = scrollController.position.maxScrollExtent;
    var loadingPosition = maxExtent - (maxExtent * 0.4);
    if (scrollController.position.extentAfter < loadingPosition &&
        !isLoadingData) {
      offset = offset + 20;
      setState(() {
        isLoadingData = true;
        _futureOpenCases = getOpenCasesList();
      });
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }
}

class OpenCaseWidget extends StatelessWidget {
  final String? subject;
  final String? priority;
  final String? name;
  final String createdDate;
  final String? caseNumber;
  final String? status;

  const OpenCaseWidget({
    Key? key,
    this.subject,
    this.priority,
    this.name,
    this.createdDate = '--',
    this.caseNumber,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: PaddingSystem.padding16,
        vertical: PaddingSystem.padding10,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            IconSystem.briefCase,
            color: Colors.black,
            width: SizeSystem.size16,
            height: SizeSystem.size16,
          ),
          const SizedBox(
            width: SizeSystem.size24,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      subject ?? '--',
                      style: const TextStyle(
                        color: ColorSystem.primary,
                        fontFamily: kRubik,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeSystem.size12,
                      ),
                    ),
                    PriorityStatusContainer(
                      priorityStatus: priority,
                    )
                  ],
                ),
                const SizedBox(
                  height: SizeSystem.size4,
                ),
                Text(
                  'By: ${name ?? '--'} | $createdDate',
                  style: const TextStyle(
                    color: ColorSystem.secondary,
                    fontFamily: kRubik,
                    fontSize: SizeSystem.size12,
                  ),
                ),
                const SizedBox(
                  height: SizeSystem.size4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      caseNumber ?? '--',
                      style: const TextStyle(
                        color: ColorSystem.secondary,
                        fontFamily: kRubik,
                        fontSize: SizeSystem.size12,
                      ),
                    ),
                    Text(
                      status ?? '--',
                      style: const TextStyle(
                        color: ColorSystem.secondary,
                        fontFamily: kRubik,
                        fontSize: SizeSystem.size12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
