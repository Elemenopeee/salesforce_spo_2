import 'package:salesforce_spo/models/gc_order_line.dart';

class BuyAgainModel {
  final String? orderStatus;
  final GcOrderLine? gcOrderLine;

  BuyAgainModel._({
    this.orderStatus,
    this.gcOrderLine,
  });

  factory BuyAgainModel.fromJson(Map<String, dynamic> json) {
    return BuyAgainModel._(
      gcOrderLine: GcOrderLine.fromJson(json['GC_Order_Line_Items__r']),
      orderStatus: json['Order_Status__c'],
    );
  }
}
