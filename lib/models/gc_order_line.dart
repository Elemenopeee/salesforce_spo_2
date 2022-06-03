class GcOrderLine {
  final String? productDescription;
  final int? productPrice;
  final String? productImage;

  GcOrderLine._({
    this.productImage,
    this.productPrice,
    this.productDescription,
  });

  factory GcOrderLine.fromJson(Map<String, dynamic> json) {
    return GcOrderLine._(
      productDescription: json['Description__c'],
      productPrice: json['Item_Price__c'],
      productImage: json['Image_URL__c'],
    );
  }
}
