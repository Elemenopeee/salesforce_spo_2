class Attributes {
  final String type;
  final String url;

  Attributes._({required this.type, required this.url});

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes._(type: json['type'], url: json['url']);
  }
}