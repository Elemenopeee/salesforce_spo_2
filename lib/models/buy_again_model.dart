import 'package:salesforce_spo/models/gc_order_line.dart';
import 'package:salesforce_spo/models/gc_order_line_record.dart';

class BuyAgainModel {
  final String? orderStatus;
  final GcOrderLineRecord? gcOrderLineRecord;

  BuyAgainModel._({this.orderStatus, this.gcOrderLineRecord});

  factory BuyAgainModel.fromJson(Map<String, dynamic> json) {
    return BuyAgainModel._(
      gcOrderLineRecord:
          GcOrderLineRecord.fromJson(json['GC_Order_Line_Items__r']),
      orderStatus: json['Order_Status__c'],
    );
  }
}
