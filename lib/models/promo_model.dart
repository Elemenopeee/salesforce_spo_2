class PromoModel {
  final String title;
  final String imgUrl;
  final String date;

  PromoModel({
    required this.title,
    required this.imgUrl,
    required this.date,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json) {
    return PromoModel(
        title: json['title'], imgUrl: json['imgUrl'], date: json['date']);
  }
}
