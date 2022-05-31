import 'package:flutter/material.dart';
import 'package:salesforce_spo/design_system/primitives/size_system.dart';

import '../../../common_widgets/cases_product_widget.dart';
import '../../../models/case.dart';
import '../../../services/networking/endpoints.dart';
import '../../../services/networking/networking_service.dart';

class CasesProductList extends StatefulWidget {
  const CasesProductList({Key? key}) : super(key: key);

  @override
  _CasesProductListState createState() => _CasesProductListState();
}

class _CasesProductListState extends State<CasesProductList> {
  List<Case> casesList = [];

  bool isLoading = true;

  late Future<void> _futureCase;

  int offset = 0;
  bool isLoadingData = false;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getCasesList(offset);
    _futureCase = getCasesList(offset);
    super.initState();
  }

  Future<void> getCasesList(int offset) async {
    var accountId = ('0018B000002ZDfbQAG');
    if (accountId != null) {
      var response =
          await HttpService().doGet(path: Endpoints.getClientCases(accountId));
      isLoadingData = false;
      try {
        for (var cases in response.data['records']) {
          casesList.add(Case.fromJson(cases));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futureCase,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              casesList.isEmpty) {
            return const Center(
              child: Center(child: CircularProgressIndicator()),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SizeSystem.size10,
                vertical: 20,
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.83,
                width: double.infinity,
                child: ListView.separated(
                  itemCount: casesList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var item = casesList[index];
                    return CasesProductWidget(
                      caseNumber: item.caseNumber,
                      casesDate: item.createdDate ?? DateTime.now().toString(),
                      // casePriorityStatus: item.priority,
                      casePriorityStatus: casesList[index].priority,
                      casesReason: item.reason,
                      casesStatus: item.status,
                      userName: item.account.name,
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
                ),
              ),
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
        _futureCase = getCasesList(offset);
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
