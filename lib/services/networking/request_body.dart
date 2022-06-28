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
    required String id,
  }) {
    return {
      'userId': id,
    };
  }
}
