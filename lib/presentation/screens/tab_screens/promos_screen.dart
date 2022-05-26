import 'package:flutter/material.dart';
import 'package:salesforce_spo/common_widgets/promo.dart';
import 'package:salesforce_spo/design_system/primitives/padding_system.dart';
import '../../../common_widgets/no_data_found.dart';
import '../../../models/promo_model.dart';
import '../../../services/networking/endpoints.dart';
import '../../../services/networking/networking_service.dart';

class PromoList extends StatefulWidget {
  const PromoList({Key? key}) : super(key: key);

  @override
  _PromoListState createState() => _PromoListState();
}

class _PromoListState extends State<PromoList> {
  List<PromoModel> promosList = [];
  bool isLoading = true;
  @override
  void initState() {
    getPromosList();
    super.initState();
  }

  Future<void> getPromosList() async {
    var response =
        await HttpService().doGet(path: Endpoints.getClientPromos(''));
    if (response.data != null && response.data['records'].length > 0) {
      response.data['records'].forEach((record) {
        promosList.add(PromoModel.fromJson(record));
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
        : promosList.isEmpty
            ? const Center(
                child: NoDataFound(),
              )
            : Container(
                margin: const EdgeInsets.only(top: PaddingSystem.padding20),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: promosList.length,
                    itemBuilder: (context, index) {
                      return Promo(
                          title: promosList[index].title,
                          date: promosList[index].date);
                    }));
  }
}
