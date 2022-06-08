import 'account.dart';
import 'attributes.dart';

class Case {
  final Attributes? attributes;
  final String? caseNumber;
  final String? caseSubtypeC;
  final String? caseTypeC;
  final String? dAXOrderNumberC;
  final String? id;
  final String? priority;
  final String? reason;
  final String? subject;
  final String? status;
  final String? createdDate;
  final Account? account;
  final Account? owner;

  Case._({
    this.attributes,
    this.caseNumber,
    this.caseSubtypeC,
    this.caseTypeC,
    this.dAXOrderNumberC,
    this.id,
    this.priority,
    this.reason,
    this.subject,
    this.status,
    this.account,
    this.owner,
    this.createdDate,
  });

  factory Case.fromJson(Map<String, dynamic> json) {
    return Case._(
      createdDate: json['CreatedDate'],
      attributes: Attributes.fromJson(json['attributes']),
      caseNumber: json['CaseNumber'],
      caseSubtypeC: json['Case_Subtype__c'],
      caseTypeC: json['Case_Type__c'],
      dAXOrderNumberC: json['DAX_Order_Number__c'],
      id: json['Id'],
      priority: json['Priority'],
      reason: json['Reason'],
      subject: json['Subject'],
      status: json['Status'],
      account: Account.fromJson(json['Account']),
      owner: Account.fromJson(json['Owner']),
    );
  }
}
