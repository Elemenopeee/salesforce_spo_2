import 'package:flutter/material.dart';

class CasesProductList extends StatefulWidget {
  const CasesProductList({Key? key}) : super(key: key);

  @override
  _CasesProductListState createState() => _CasesProductListState();
}

class _CasesProductListState extends State<CasesProductList> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 2,
    ), itemBuilder: (context, index) => getSingleCasesList(context, index));
  }
 Widget getSingleCasesList(BuildContext context, int index){
    return Column(
      children: const [
        Text(""),
      ],
    );
 }

}
