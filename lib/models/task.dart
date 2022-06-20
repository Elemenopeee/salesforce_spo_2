class TaskModel {
  final String? id;
  final String? status;
  final String? subject;
  final String? taskType;
  final String? taskDate;
  final String? phone;
  final String? email;
  final String? lastModifiedDate;
  final String? modifiedBy;
  final String? assignedTo;
  final String? description;

  const TaskModel({
    this.id,
    this.status,
    this.subject,
    this.taskType,
    this.taskDate,
    this.phone,
    this.email,
    this.lastModifiedDate,
    this.modifiedBy,
    this.assignedTo,
    this.description,
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
      lastModifiedDate: json['LastModifiedDate'],
      modifiedBy: json['LastModifiedBy']['Name'],
      assignedTo: json['Owner']['Name'],
      description: json['Description'],
    );
  }
}

