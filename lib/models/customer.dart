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

  final String? lastTransactionDate;
  final double? lifeTimeNetSalesAmount;
  final String? preferredInstrument;
  final double? lifetimeNetUnits;
  final String? maxLTVNet;
  final String? medianLTVNet;
  final String? averageLTVNet;

  Customer._({
    this.email,
    required this.id,
    required this.firstName,
    required this.lastName,
    this.phone,
    this.lastTransactionDate,
    this.lifeTimeNetSalesAmount,
    this.preferredInstrument,
    this.lifetimeNetUnits,
    this.maxLTVNet,
    this.medianLTVNet,
    this.averageLTVNet,
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
      lifetimeNetUnits: json['Lifetime_Net_Units__c'],
      maxLTVNet: json['Max_ltv_net_dlrs_Formula__c'],
      medianLTVNet: json['Median_ltv_net_dlrs_Formula__c'],
      averageLTVNet: json['Avg_ltv_net_dlrs_Formula__c'],
    );
  }
}
