import 'attributes.dart';

class Account {
  Attributes? attributes;
  String? name;

  Account({this.attributes, this.name});

  Account.fromJson(Map<String, dynamic> json) {
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