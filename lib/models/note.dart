import 'attributes.dart';

class Note {
  final Attributes? attributes;
  final String? id;
  final String? contentDocumentId;

  Note._({
    this.attributes,
    this.id,
    this.contentDocumentId,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note._(
      attributes: Attributes.fromJson(json['attributes']),
      id: json['id'],
      contentDocumentId: json['contentDocumentId'],
    );
  }
}
