import 'package:flutter/material.dart';
import 'package:salesforce_spo/common_widgets/cases_product_widget.dart';
import 'package:salesforce_spo/design_system/design_system.dart';
import 'package:salesforce_spo/models/cases_product_model.dart';

class CasesProductList extends StatefulWidget {
  const CasesProductList({Key? key}) : super(key: key);

  @override
  _CasesProductListState createState() => _CasesProductListState();
}

class _CasesProductListState extends State<CasesProductList> {
  List<CasesProductModel> casesProductData = [
    CasesProductModel(
      caseNumber: "111212332",
      casesDate: "MM-DD-YYYY",
      casePriorityStatus: "High",
      casesName: "Social Service",
      casesStatus: "New",
      userName: "Ankit",
    ),
    CasesProductModel(
      caseNumber: "111212332",
      casesDate: "MM-DD-YYYY",
      casePriorityStatus: "Medium",
      casesName: "Customer Service",
      casesStatus: "New",
      userName: "Ankit",
    ),
    CasesProductModel(
      caseNumber: "111212332",
      casesDate: "MM-DD-YYYY",
      casePriorityStatus: "Low",
      casesName: "Sales",
      casesStatus: "New",
      userName: "Ankit",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SizeSystem.size10,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.83,
        width: double.infinity,
        child: ListView.builder(
            itemCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var item = casesProductData[index];
              return CasesProductWidget(
                caseNumber: item.caseNumber,
                casePriorityStatus: item.casePriorityStatus,
                casesDate: item.casesDate,
                casesName: item.casesName,
                casesStatus: item.casesStatus,
                statusContainerColor: const Color.fromRGBO(232, 16, 27, 0.1),
                statusFontColor: ColorSystem.complimentary,
                userName: item.userName,
              );
            }),
      ),
    );
  }
}
