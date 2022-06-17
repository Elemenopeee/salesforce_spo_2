import 'package:salesforce_spo/models/app_user.dart';

class Agent {
  final String? name;
  final String? id;
  final String? storeId;

  Agent._({
    this.id,
    this.name,
    this.storeId,
  });

  factory Agent.fromJson(Map<String, dynamic> json){
    return Agent._(
      id: json['Id'],
      name: json['Name'],
      storeId: json['StoreId__c'],
    );
  }

}
