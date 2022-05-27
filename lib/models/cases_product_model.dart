class CasesProductModel {
  final String? casesName;
  final String? casesDate;
  final String? casesStatus;
  final String? caseNumber;
  final String? casePriorityStatus;
  final String? userName;

  CasesProductModel(
      {this.casesName,
      this.casesDate,
      this.casesStatus,
      this.caseNumber,
      this.casePriorityStatus,
      this.userName});

  factory CasesProductModel.fromJson(Map<String, dynamic> json) {
    return CasesProductModel(
      casesName: json['casesName'],
      casesDate: json['casesDate'],
      casesStatus: json['casesStatus'],
      caseNumber: json['caseNumber'],
      casePriorityStatus: json['casePriorityStatus'],
      userName: json['userName'],
    );
  }
}
