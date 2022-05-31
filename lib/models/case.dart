import 'account.dart';
import 'attributes.dart';

class Case {
  final Attributes attributes;
  final String? caseNumber;
  final String? caseSubtypeC;
  final String? caseTypeC;
  final String? dAXOrderNumberC;
  final String id;
  final String? priority;
  final String reason;
  final String status;
  final String? createdDate;
  final Account account;
  final Account owner;

  Case._({
    required this.attributes,
    this.caseNumber,
    this.caseSubtypeC,
    this.caseTypeC,
    this.dAXOrderNumberC,
    required this.id,
    this.priority,
    required this.reason,
    required this.status,
    required this.account,
    required this.owner,
    this.createdDate,
  });

  factory Case.fromJson(Map<String, dynamic> json) {
    return Case._(
      createdDate: json['createdDate'],
      attributes: Attributes.fromJson(json['attributes']),
      caseNumber: json['CaseNumber'],
      caseSubtypeC: json['Case_Subtype__c'],
      caseTypeC: json['Case_Type__c'],
      dAXOrderNumberC: json['DAX_Order_Number__c'],
      id: json['Id'],
      priority: json['Priority'],
      reason: json['Reason'],
      status: json['Status'],
      account: Account.fromJson(json['Account']),
      owner: Account.fromJson(json['Owner']),
    );
  }
}
