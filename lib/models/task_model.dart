import 'package:flutter/cupertino.dart';

class TaskModel {
  final String? title;
  final String? userName;
  final String? taskName;
  final String? timeStatus;
  final String? subTitle;
  final String? iconImage;

  TaskModel({
    this.title,
    this.userName,
    this.taskName,
    this.timeStatus,
    this.subTitle,
    this.iconImage,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      title: json['title'],
      userName: json['userName'],
      taskName: json['taskName'],
      timeStatus: json['timeStatus'],
      subTitle: json['subTitle'],
      iconImage: json['iconImage'],
    );
  }
}
