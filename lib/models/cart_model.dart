class CartModel {
  final String? productName;
  final double? productPrice;
  final String? productImage;
  final String? id;

  CartModel({
    this.id,
    this.productImage,
    this.productPrice,
    this.productName,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['Id'],
      productName: json['Name'],
      productPrice: json['Standard_Unit_Cost__c'],
      productImage: json['ProductImage__c'],
    );
  }
}
