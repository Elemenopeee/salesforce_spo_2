class Order {
  final String id;
  final String? orderNumber;
  final String? customerFirstName;
  final String? customerLastName;
  final String? lastModifiedDate;
  final String? createdDate;
  final double orderAmount;
  final String? orderStatus;
  final double? items;
  final String? taskType;

  Order._({
    required this.id,
    required this.orderNumber,
    this.customerFirstName,
    this.customerLastName,
    this.lastModifiedDate,
    this.createdDate,
    required this.orderAmount,
    this.orderStatus,
    this.items,
    this.taskType,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order._(
      id: json['Id'],
      orderNumber: json['Order_Number__c'],
      customerFirstName: json['First_Name__c'],
      customerLastName: json['Last_Name__c'],
      lastModifiedDate: json['LastModifiedDate'],
      createdDate: json['CreatedDate'],
      orderAmount: json['Total_Amount__c'],
      items: json['Rollup_Count_Order_Line_Items__c'],
      orderStatus: json['Order_Status__c'],
    );
  }

  factory Order.fromOrderInfoJson(Map<String, dynamic> json) {
    return Order._(
      id: json['Id'] ?? '--',
      orderNumber: json['OrderNumber'],
      orderAmount: double.tryParse(json['GrandTotal']) ?? 0.0,
      createdDate: json['OrderDate'],
      taskType: json['TaskType'],
    );
  }
}
