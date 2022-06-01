import 'package:salesforce_spo/models/promo_attributes.dart';
import 'package:salesforce_spo/models/promo_attributes.dart';

class PromoModel {
  final PromoAttributes? promoAttributes;
  final String? createdDate;
  final String? subject;

  PromoModel._({this.promoAttributes, this.createdDate, this.subject});

  factory PromoModel.fromJson(Map<String, dynamic> json) {
    return PromoModel._(
      createdDate: json['CreatedDate'],
      promoAttributes: PromoAttributes.fromJson(json['attributes']),
      subject: json['Subject'],
    );
  }
}
