class PromoAttributes {
  final String type;
  final String url;

  PromoAttributes._({required this.type, required this.url});

  factory PromoAttributes.fromJson(Map<String, dynamic> json) {
    return PromoAttributes._(
      type: json['type'],
      url: json['url'],
    );
  }
}
