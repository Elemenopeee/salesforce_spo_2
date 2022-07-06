import 'dart:convert';

import 'package:salesforce_spo/models/order.dart';

import '../../models/order_item.dart';


abstract class RequestBody {
  static Map<String, dynamic> getMetricsAndSmartTriggersBody(
      String tabName, String userId) {
    return {
      'TabName': tabName,
      'UserId': userId,
    };
  }

  static Map<String, dynamic> getUpdateTaskBody({
    required String recordId,
    String? status,
    String? comment,
    String? dueDate,
    String? assignee,
  }) {
    return {
      'recordId': recordId,
      'status': status ?? '',
      'comment': comment ?? '',
      'assignee': assignee ?? '',
      'dueDate': dueDate ?? '',
    };
  }

  static Map<String, dynamic> getAgentProfileBody({
    String? id,
    String? email,
  }) {
    return {'userId': id ?? '', 'email': email ?? ''};
  }

  static Map<String, dynamic> getCreateTaskBody({
    String? parentTaskId,
    required String subject,
    required String dueDate,
    String? comment,
    String? whoId,
    String? whatId,
    String? ownerId,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    required List<Order> selectedOrders,
  }) {

    var orderDetailsJson = <String>[];

    for(var order in selectedOrders){
      orderDetailsJson.add(jsonEncode(order.toJson()));
    }

    return {
      'parentTaskId': parentTaskId ?? '',
      'subject': subject,
      'dueDate': dueDate,
      'comment': comment ?? '',
      'WhoId': whoId ?? '',
      'WhatId': whatId ?? '',
      'OwnerId': ownerId ?? '',
      'firstName': firstName ?? '',
      'lastName': lastName ?? '',
      'email': email ?? '',
      'phone': phone ?? '',
      'orderDetailsJson': orderDetailsJson,
    };
  }
}

// {
//
// "parentTaskId": "",
//
// "subject": "Alert: Call with client",
//
// "dueDate": "2022-05-05",
//
// "comment": "",
//
// "WhoId": "0034M00001wCkKWQA0",
//
// "WhatId": "1316C00000009ODQAY",
//
// "OwnerId": "0054M000004UMmEQAW",
//
// "firstName": "",
//
// "lastName": "",
//
// "email": "",
//
// "phone": "",
//
// "orderDetailsJson": "{\"Brand\":\"GC\",\"OrderNumber\":\"GC18870695\",\"OrderDate\":\"2021-10-18\",\"CustomerKey\":\"\",\"Email\":\"\",\"OrderLines\":[{\"ItemId\":\"L19002000001001\",\"ItemShortDesc\":\"YamahaP-125DigitalPianoBlack88Key\",\"UnitPrice\":\"563.49\",\"OrderedQty\":1}],\"GrandTotal\":1269.21}"
//
// }
