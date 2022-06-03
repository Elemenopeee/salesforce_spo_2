class BrowsingHistoryModel {
  final String? productName;
  final String? productPrice;
  final String? productImage;

  BrowsingHistoryModel({
    this.productImage,
    this.productPrice,
    this.productName,
  });

  factory BrowsingHistoryModel.fromJson(Map<String, dynamic> json) {
    return BrowsingHistoryModel(
      productName: json['productName'],
      productPrice: json['productPrice'],
      productImage: json['productImage'],
    );
  }
}
