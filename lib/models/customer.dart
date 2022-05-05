import 'package:salesforce_spo/models/app_user.dart';

class Customer extends AppUser {
  @override
  String id;

  @override
  String? email;

  @override
  late String firstName;

  @override
  late String lastName;

  @override
  String? phone;

  final Object? lastTransactionDate;
  final Object? lifeTimeNetSalesAmount;
  final String? preferredInstrument;

  Customer._({
    this.email,
    required this.id,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.lastTransactionDate,
    this.lifeTimeNetSalesAmount,
    this.preferredInstrument,
  });

  factory Customer.fromJson({required Map<String, dynamic> json}) {
    return Customer._(
      id: json['Id'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      email: json['accountEmail__c'],
      phone: json['accountPhone__c'],
      lastTransactionDate: json['Last_Transaction_Date__c'],
      lifeTimeNetSalesAmount: json['Lifetime_Net_Sales_Amount__c'],
      preferredInstrument: json['Preferred_Instrument__c'],
    );
  }
}
