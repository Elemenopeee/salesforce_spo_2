class TaskModel {
  final String? id;
  final String? status;
  final String? subject;
  final String? taskType;
  final String? taskDate;
  final String? phone;
  final String? email;

  const TaskModel({
    this.id,
    this.status,
    this.subject,
    this.taskType,
    this.taskDate,
    this.phone,
    this.email,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['Id'],
      status: json['Status'],
      subject: json['Subject'],
      taskDate: json['ActivityDate'],
      taskType: json['Store_Task_Type__c'],
      phone: json['Phone__c'],
      email: json['Email__c'],
    );
  }
}

