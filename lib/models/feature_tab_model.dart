class FeatureTabModel {
  final String selectedImgUrl;
  final String unSelectedImgUrl;
  final String featureTabName;

  FeatureTabModel({
    required this.selectedImgUrl,
    required this.unSelectedImgUrl,
    required this.featureTabName,
  });

  factory FeatureTabModel.fromJson(Map<String, dynamic> json) {
    return FeatureTabModel(
      selectedImgUrl: json['selectedImgUrl'],
      unSelectedImgUrl: json['unSelectedImgUrl'],
      featureTabName: json['featureTabName'],
    );
  }
}
