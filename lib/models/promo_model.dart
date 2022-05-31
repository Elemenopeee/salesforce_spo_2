import 'package:salesforce_spo/models/promo_attributes.dart';

class PromoModel {
  final PromoAttributes? promoAttributes;
  final String? createdDate;

  PromoModel._({this.promoAttributes, this.createdDate});

  factory PromoModel.fromJson(Map<String, dynamic> json) {
    return PromoModel._(
      createdDate: json['createdDate'],
      promoAttributes: PromoAttributes.fromJson(
        json['promoAttributes'],
      ),
    );
  }
}
