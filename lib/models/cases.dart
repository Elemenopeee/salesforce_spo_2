class Cases {
  final Attributes attributes;
  final String? caseNumber;
  final String? caseSubtypeC;
  final String? caseTypeC;
  final String? dAXOrderNumberC;
  final String id;
  final String? priority;
  final String reason;
  final String status;
  final Account account;
  final Account owner;

  Cases._(
      {required this.attributes,
      this.caseNumber,
      this.caseSubtypeC,
      this.caseTypeC,
      this.dAXOrderNumberC,
      required this.id,
      this.priority,
      required this.reason,
      required this.status,
      required this.account,
      required this.owner});

  factory Cases.fromJson(Map<String, dynamic> json) {
    return Cases._(
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

class Attributes {
  final String type;
  final String url;

  Attributes._({required this.type, required this.url});

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes._(type: json['type'], url: json['url']);
  }
}

class Account {
  Attributes? attributes;
  String? name;

  Account({this.attributes, this.name});

  Account.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? Attributes.fromJson(json['attributes'])
        : null;
    name = json['Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attributes != null) {
      data['attributes'] = attributes;
    }
    data['Name'] = name;
    return data;
  }
}
