import 'package:salesforce_spo/models/app_user.dart';
import 'package:salesforce_spo/models/task.dart';

class Agent {
  final String? name;
  final String? id;
  final String? storeId;
  final String? employeeId;
  final List<TaskModel> todayTasks;
  final List<TaskModel> pastOpenTasks;
  final List<TaskModel> futureTasks;
  final List<TaskModel> completedTasks;
  final List<TaskModel> unAssignedTasks;
  final List<TaskModel> allTasks;

  Agent._({
    this.id,
    this.name,
    this.storeId,
    this.employeeId,
    this.todayTasks = const [],
    this.pastOpenTasks = const [],
    this.futureTasks = const [],
    this.completedTasks = const [],
    this.unAssignedTasks = const [],
    this.allTasks = const [],
  });

  factory Agent.fromJson(Map<String, dynamic> json){
    return Agent._(
      id: json['Id'],
      name: json['Name'],
      storeId: json['StoreId__c'],
      employeeId: json['EmployeeNumber'],
    );
  }

  factory Agent.fromTeamTaskListJson(Map<String, dynamic> json){

    var todayTasks = <TaskModel>[];
    var pastOpenTasks = <TaskModel>[];
    var futureTasks = <TaskModel>[];
    var completedTasks = <TaskModel>[];
    var unAssignedTasks = <TaskModel>[];
    var allTasks = <TaskModel>[];

    for (var taskJson in json['TodayTasks']){
      todayTasks.add(TaskModel.fromJson(taskJson));
    }
    for (var taskJson in json['PastOpenTasks']){
      pastOpenTasks.add(TaskModel.fromJson(taskJson));
    }
    for (var taskJson in json['FutureTasks']){
      futureTasks.add(TaskModel.fromJson(taskJson));
    }
    for (var taskJson in json['CompletedTasks']){
      completedTasks.add(TaskModel.fromJson(taskJson));
    }
    for (var taskJson in json['AllUnassignedTasks']){
      unAssignedTasks.add(TaskModel.fromJson(taskJson));
    }
    for (var taskJson in json['AllTasks']){
      allTasks.add(TaskModel.fromJson(taskJson));
    }


    return Agent._(
      name: json['Name'],
      todayTasks: todayTasks,
      pastOpenTasks: pastOpenTasks,
      futureTasks: futureTasks,
      completedTasks: completedTasks,
      unAssignedTasks: unAssignedTasks,
      allTasks: allTasks,
    );
  }

}
