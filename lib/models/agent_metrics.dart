import 'dart:developer';

class AgentMetrics {
  final int todayTasks;
  final List<double> perDaySale;
  final List<double> perDayCommission;
  final int pastOpenTasks;
  final bool isManager;
  final int futureTasks;
  final int completedTasks;
  final int allUnassignedTasks;
  final int allTasks;
  final double yesterdaySale;
  final double yesterdayCommission;

  AgentMetrics._({
    this.todayTasks = 0,
    this.perDaySale = const [],
    this.perDayCommission = const [],
    this.pastOpenTasks = 0,
    this.isManager = false,
    this.futureTasks = 0,
    this.completedTasks = 0,
    this.allUnassignedTasks = 0,
    this.allTasks = 0,
    this.yesterdaySale = 0,
    this.yesterdayCommission = 0,
  });

  factory AgentMetrics.fromJson(Map<String, dynamic> json) {
    var perDaySales = <double>[];
    var perDayCommissions = <double>[];

    if (json['PerDaySale'] != null) {
      perDaySales.add(json['PerDaySale']['Day1__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day2__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day3__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day4__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day5__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day6__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day7__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day8__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day9__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day10__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day11__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day12__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day13__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day14__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day15__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day16__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day17__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day18__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day19__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day20__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day21__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day22__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day23__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day24__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day25__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day26__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day27__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day28__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day29__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day30__c'] ?? 0);
      perDaySales.add(json['PerDaySale']['Day31__c'] ?? 0);
    }

    if (json['PerDayCommission'] != null) {
      perDayCommissions.add(json['PerDayCommission']['Day1__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day2__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day3__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day4__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day5__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day6__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day7__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day8__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day9__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day10__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day11__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day12__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day13__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day14__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day15__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day16__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day17__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day18__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day19__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day20__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day21__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day22__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day23__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day24__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day25__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day26__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day27__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day28__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day29__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day30__c'] ?? 0);
      perDayCommissions.add(json['PerDayCommission']['Day31__c'] ?? 0);
    }

    return AgentMetrics._(
      todayTasks: json['TodayOpenTasks'] ?? 0,
      perDaySale: perDaySales,
      perDayCommission: perDayCommissions,
      pastOpenTasks: json['PastOpenTasks'] ?? 0,
      isManager: json['IsManager'] ?? false,
      futureTasks: json['FutureOpenTasks'] ?? 0,
      completedTasks: json['CompletedTasks'] ?? 0,
      allUnassignedTasks: json['UnassignedOpenTasks'] ?? 0,
      allTasks: json['AllOpenTasks'] ?? 0,
      yesterdaySale: json['YesterdaySale'],
      yesterdayCommission: json['YesterdayCommission'],
    );
  }
}
