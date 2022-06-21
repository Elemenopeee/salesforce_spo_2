abstract class RequestBody {
  static Map<String, dynamic> getSmartTriggersBody(
      String tabName, String userId) {
    return {
      'TabName': tabName,
      'UserId': userId,
    };
  }

  static Map<String, dynamic> getUpdateTaskBody({
    required String taskId,
    String? status,
    String? comment,
    String? dueDate,
    String? assignee,
  }) {
    return {
      'recordId': taskId,
      'status': status ?? '',
      'comment': comment ?? '',
      'assignee': assignee ?? '',
      'dueDate': dueDate ?? '',
    };
  }
}
