import 'attributes.dart';

class LastModifiedBy {
  Attributes? attributes;
  String? name;

  LastModifiedBy({this.attributes, this.name});

  LastModifiedBy.fromJson(Map<String, dynamic> json) {
    attributes = (json['attributes'] != null
        ? Attributes.fromJson(json['attributes'])
        : null);
    name = json['Name'];
  }
}
