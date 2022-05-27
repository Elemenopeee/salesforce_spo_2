class RecommendationProductModel {
  final String imgUrl;

  RecommendationProductModel({
    required this.imgUrl,
  });

  factory RecommendationProductModel.fromJson(Map<String, dynamic> json) {
    return RecommendationProductModel(imgUrl: json['imgUrl']);
  }
}
