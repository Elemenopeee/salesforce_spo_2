class CustomerMightLikeModel {
  final String? productName;
  final String? productPrice;
  final String? productImage;

  CustomerMightLikeModel({
    this.productImage,
    this.productPrice,
    this.productName,
  });

  factory CustomerMightLikeModel.fromJson(Map<String, dynamic> json) {
    return CustomerMightLikeModel(
      productName: json['productName'],
      productPrice: json['productPrice'],
      productImage: json['productImage'],
    );
  }
}
