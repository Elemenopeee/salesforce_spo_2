class CasesProductModel {
  final String productName;
  final String productStatus;
  final String productImgUrl;

  CasesProductModel({
    required this.productName,
    required this.productStatus,
    required this.productImgUrl,
  });

  factory CasesProductModel.fromJson(Map<String, dynamic> json) {
    return CasesProductModel(
        productName: json['productName'],
        productStatus: json['productStatus'],
        productImgUrl: json['productImgUrl']);
  }
}
