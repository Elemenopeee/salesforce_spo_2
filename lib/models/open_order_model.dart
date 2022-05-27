class OpenOrderModel {
  final String orderImgUrl;

  OpenOrderModel({
    required this.orderImgUrl,
  });

  factory OpenOrderModel.fromJson(Map<String, dynamic> json) {
    return OpenOrderModel(orderImgUrl: json['orderImgUrl']);
  }
}
