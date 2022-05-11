class Order {
  final String id;
  final String orderNumber;
  final String? customerFirstName;
  final String? customerLastName;
  final String? lastModifiedDate;
  final String? createdDate;
  final double orderAmount;
  final String? orderStatus;

  Order._({
    required this.id,
    required this.orderNumber,
    this.customerFirstName,
    this.customerLastName,
    this.lastModifiedDate,
    this.createdDate,
    required this.orderAmount,
    this.orderStatus,
  });
}
