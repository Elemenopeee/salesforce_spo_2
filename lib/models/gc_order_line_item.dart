class GcOrderLineItem {
  final String? productDescription;
  final double? productPrice;
  final String? productImage;

  GcOrderLineItem._({
    this.productImage,
    this.productPrice,
    this.productDescription,
  });

  factory GcOrderLineItem.fromJson(Map<String, dynamic> json) {
    return GcOrderLineItem._(
      productDescription: json['Description__c'],
      productPrice: json['Item_Price__c'],
      productImage: json['Image_URL__c'],
    );
  }
}
