class ClientActivity {
  final String? id;
  final String? clientId;
  final String? clientName;
  final ClientActivityOwner? clientActivityOwner;
  final String? status;
  final String? subject;
  final String? activityDate;
  final String? taskSubType;
  final String? type;
  final String? completedDateTime;

  ClientActivity._({
    this.id,
    this.clientId,
    this.clientName,
    this.clientActivityOwner,
    this.status,
    this.subject,
    this.activityDate,
    this.taskSubType,
    this.type,
    this.completedDateTime,
  });

  factory ClientActivity.fromJson(Map<String, dynamic> json){
    return ClientActivity._(
      id: json['Id'],
      clientId: json['WhatId'],
      clientName: json['What']['Name'],
      clientActivityOwner: ClientActivityOwner.fromJson(json['Owner']),
      status: json['Status'],
      subject: json['Subject'],
      taskSubType: json['TaskSubtype'],
      type: json['Type'],
      completedDateTime: json['CompletedDateTime'],
      activityDate: json['ActivityDate'],
    );
  }

}

class ClientActivityOwner {

  final String? name;

  ClientActivityOwner._({this.name});

  factory ClientActivityOwner.fromJson(Map<String, dynamic> json){
    return ClientActivityOwner._(
      name: json['Name'],
    );
  }

}
