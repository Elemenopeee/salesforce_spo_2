import 'package:salesforce_spo/models/attributes.dart';

class NoteModel {
  final Attributes? attributes;
  final String? title;
  final String? fileType;
  final String? textPreview;
  final String? content;

  NoteModel._({
    this.attributes,
    this.title,
    this.fileType,
    this.textPreview,
    this.content,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel._(
      attributes: Attributes.fromJson(json['attributes']),
      title: json['title'],
      fileType: json['fileType'],
      textPreview: json['textPreview'],
      content: json["content"],
    );
  }
}
// class NoteModel {
//   final String note;
//   final String tag1;
//   final String tag2;
//   final String date;
//   final bool expanded;
//   NoteModel(
//       {required this.note,
//       required this.tag1,
//       required this.tag2,
//       required this.date,
//       required this.expanded});
//
//   factory NoteModel.fromJson(Map<String, dynamic> json) {
//     return NoteModel(
//         note: json['note'],
//         tag1: json['tag1'],
//         tag2: json['tag2'],
//         date: json['date'],
//         expanded: false);
//   }
// }
