class OrderHistoryModel {
  final String orderStatus;
  final String orderItemsName;
  final String date;

  OrderHistoryModel({
    required this.orderStatus,
    required this.orderItemsName,
    required this.date,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      orderStatus: json['orderStatus'],
      orderItemsName: json['orderItemsName'],
      date: json['date'],
    );
  }
}
