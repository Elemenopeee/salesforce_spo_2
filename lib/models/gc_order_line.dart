import 'package:salesforce_spo/models/gc_order_line_record.dart';

// class GcOrderLine {
//   GcOrderLineRecord? records;
//
//
//   GcOrderLine._({
//     this.records,
//   });
//
//   GcOrderLine.fromJson(Map<String, dynamic> json) {
//     records = json['records'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['records'] = records;
//     return data;
//   }
// }

class GcOrderLine {

  final List<GcOrderLineRecord>? records;

  GcOrderLine({this.records});
}

class GcOrderLineRecord {
  String? productDescription;
  double? productPrice;
  String? productImage;

  GcOrderLineRecord({
    required this.productDescription,
    required this.productPrice,
    required this.productImage,
  });

  GcOrderLineRecord.fromJson(Map<String, dynamic> json) {
    productDescription = json['Description__c'];
    productImage = json['Image_URL__c'];
    productPrice = json['Item_Price__c'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['Description__c'] = productDescription;
    data['Image_URL__c'] = productImage;
    data['Item_Price__c'] = productPrice;

    return data;
  }
}

