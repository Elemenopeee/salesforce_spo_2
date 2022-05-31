import 'attributes.dart';

class Owner {
  Attributes? attributes;
  String? name;

  Owner({this.attributes, this.name});

  Owner.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null
        ? Attributes.fromJson(json['attributes'])
        : null;
    name = json['Name'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attributes != null) {
      data['attributes'] = attributes;
    }
    data['Name'] = name;
    return data;
  }
}
