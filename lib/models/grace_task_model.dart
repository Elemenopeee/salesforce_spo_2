import 'package:flutter/cupertino.dart';

class GraceTaskModel {
  final String? title;
  final String? userName;
  final String? taskName;
  final String? timeStatus;
  final String? subTitle;
  final IconData? iconImage;

  GraceTaskModel({
    this.title,
    this.userName,
    this.taskName,
    this.timeStatus,
    this.subTitle,
    this.iconImage,
  });

  factory GraceTaskModel.fromJson(Map<String, dynamic> json) {
    return GraceTaskModel(
      title: json['title'],
      userName: json['userName'],
      taskName: json['taskName'],
      timeStatus: json['timeStatus'],
      subTitle: json['subTitle'],
      iconImage: json['iconImage'],
    );
  }
}
