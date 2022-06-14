class TaskModel {
  final String? id;
  final String? status;
  final String? subject;
  final String? taskType;
  final String? taskDate;

  const TaskModel({
    this.id,
    this.status,
    this.subject,
    this.taskType,
    this.taskDate,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['Id'],
      status: json['Status'],
      subject: json['Subject'],
      taskDate: json['ActivityDate'],
      taskType: json['Store_Task_Type__c'],
    );
  }
}

