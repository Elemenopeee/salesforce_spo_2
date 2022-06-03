class CartIdModel {
  final String? id;
  final String? customerId;

  CartIdModel._({
    this.id,
    this.customerId,
  });

  factory CartIdModel.fromJson(Map<String, dynamic> json) {
    return CartIdModel._(
      id: json['id'],
      customerId: json['Cart_Sku_1__c'],
    );
  }
}
