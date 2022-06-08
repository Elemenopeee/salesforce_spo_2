class Product {
  final String? productID;
  final String? brand;
  final String? name;
  final String? vendorName;
  final double? standardUnitCost;
  final String? productImageURL;

  Product._({
    this.productID,
    this.brand,
    this.name,
    this.vendorName,
    this.standardUnitCost,
    this.productImageURL,
  });

  factory Product.fromJson(Map<String, dynamic> json){
    return Product._(
      productID: json['Id'],
      brand: json['Brand__c'],
      name: json['Name'],
      vendorName: json['Vender_Name__c'],
      standardUnitCost: json['Standard_Unit_Cost__c'],
      productImageURL: json['ProductImage__c'],
    );
  }

}
