import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesforce_spo/common_widgets/promo.dart';
import 'package:salesforce_spo/design_system/primitives/padding_system.dart';
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

  late Future<void> _futurePromo;

  int offset = 0;
  bool isLoadingData = false;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getPromosList(offset);
    _futurePromo = getPromosList(offset);
    super.initState();
  }

  Future<void> getPromosList(int offset) async {
    var relatedToId = ('0014M00001g0fPMQAY');
    var response =
        await HttpService().doGet(path: Endpoints.getClientPromos(relatedToId));
    isLoadingData = false;
    try {
      for (var promos in response.data['records']) {
        promosList.add(PromoModel.fromJson(promos));
      }
    } catch (e) {
      print(e);
    }
  }

  String formattedDate(String date) {
    var dateTime = DateTime.parse(date);
    return DateFormat('MM-dd-yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _futurePromo,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              promosList.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(
              margin: const EdgeInsets.only(top: PaddingSystem.padding20),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: promosList.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var item = promosList[index];
                  return Promo(
                    title: item.subject ?? "--",
                    date: item.createdDate == null ? '--' : formattedDate(item.createdDate!),
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
        _futurePromo = getPromosList(offset);
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
