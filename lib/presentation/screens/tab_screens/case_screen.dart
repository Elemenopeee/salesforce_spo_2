import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salesforce_spo/common_widgets/no_data_found.dart';
import 'package:salesforce_spo/design_system/primitives/icon_system.dart';
import 'package:salesforce_spo/design_system/primitives/padding_system.dart';
import 'package:salesforce_spo/design_system/primitives/size_system.dart';
import 'package:salesforce_spo/utils/constants.dart';

import '../../../design_system/primitives/color_system.dart';
import '../../../models/cases.dart';
import '../../../services/networking/endpoints.dart';
import '../../../services/networking/networking_service.dart';

class CasesProductList extends StatefulWidget {
  const CasesProductList({Key? key}) : super(key: key);

  @override
  _CasesProductListState createState() => _CasesProductListState();
}

class _CasesProductListState extends State<CasesProductList> {
  List<Cases> casesList = [];
  bool isLoading = true;
  @override
  void initState() {
    getCasesList();
    super.initState();
  }

  Future<void> getCasesList() async {
    var response =
        await HttpService().doGet(path: Endpoints.getClientCases(''));
    if (response.data != null && response.data['records'].length > 0) {
      response.data['records'].forEach((record) {
        casesList.add(Cases.fromJson(record));
      });
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Column(children: const [
            SizedBox(
              height: PaddingSystem.padding20,
            ),
            CircularProgressIndicator()
          ])
        : casesList.isEmpty
            ? const Center(
                child: NoDataFound(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: PaddingSystem.padding10,
                    vertical: PaddingSystem.padding20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.83,
                  width: double.infinity,
                  child: GridView.builder(
                      itemCount: casesList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: SizeSystem.size8,
                        mainAxisSpacing: SizeSystem.size0,
                      ),
                      itemBuilder: (context, index) {
                        return getSingleCasesList(context, index);
                      }),
                ),
              );
  }

  Widget getSingleCasesList(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.20,
          width: MediaQuery.of(context).size.height * 0.20,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(SizeSystem.size15),
            color: ColorSystem.secondaryGreyBg,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: SizeSystem.size5),
            child: SvgPicture.asset(casesList[index].attributes.url,
                color: Colors.black87),
          ),
        ),
        const SizedBox(
          height: SizeSystem.size10,
        ),
        Text(
          casesList[index].reason.toString(),
          style:
              const TextStyle(fontSize: SizeSystem.size16, fontFamily: kRubik),
        ),
        const SizedBox(
          height: SizeSystem.size10,
        ),
        Text(
          casesList[index].status,
          style:
              const TextStyle(fontSize: SizeSystem.size12, fontFamily: kRubik),
        ),
        const SizedBox(
          height: SizeSystem.size10,
        ),
      ],
    );
  }
}
