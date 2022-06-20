abstract class RequestBody {
  static Map<String, dynamic> getSmartTriggersBody(
      String tabName, String userId) {
    return {
      'TabName': tabName,
      'UserId': userId,
    };
  }
}
