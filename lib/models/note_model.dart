import 'package:salesforce_spo/models/attributes.dart';

import 'last_modified_by.dart';

class NoteModel {
  final Attributes? attributes;
  final String? title;
  final String? fileType;
  final String? textPreview;
  final String? content;
  final String? createdDate;
  final LastModifiedBy? lastModifiedBy;

  NoteModel._({
    this.attributes,
    this.title,
    this.fileType,
    this.textPreview,
    this.content,
    this.createdDate,
    // this.userName,
    this.lastModifiedBy
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel._(
      attributes: Attributes.fromJson(json['attributes']),
      lastModifiedBy: LastModifiedBy.fromJson(json['LastModifiedBy']),
      title: json['Title'],
      fileType: json['FileType'],
      textPreview: json['TextPreview'],
      content: json["Content"],
      createdDate: json["CreatedDate"],
    );
  }
}
