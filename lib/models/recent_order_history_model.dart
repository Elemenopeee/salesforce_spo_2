class RecentOrderHistoryModel {
  final String orderTitle;
  final String orderDescription;
  final String date;

  RecentOrderHistoryModel({
    required this.orderTitle,
    required this.orderDescription,
    required this.date,
  });

  factory RecentOrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return RecentOrderHistoryModel(
      orderTitle: json['orderTitle'],
      orderDescription: json['orderDescription'],
      date: json['date'],
    );
  }
}
