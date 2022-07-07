class OrderItem {
  final double? itemPrice;
  final String? trackingNumber;
  final String? orderLineKey;
  final int? orderedQuantity;
  final int? lineItem;
  final String? status;
  final String? itemId;
  final String? description;
  final String? imageUrl;
  final String? deliveredDate;

  OrderItem._({
    this.status,
    this.itemPrice,
    this.imageUrl,
    this.description,
    this.itemId,
    this.lineItem,
    this.orderedQuantity,
    this.orderLineKey,
    this.trackingNumber,
    this.deliveredDate,
  });

  factory OrderItem.fromTaskJson(Map<String, dynamic> json){
    return OrderItem._(
      itemPrice: double.tryParse(json['UnitPrice']),
      trackingNumber: json['TrackingNo'],
      orderLineKey: json['OrderLineKey'],
      orderedQuantity: json['OrderedQuantity'],
      lineItem: json['LineItem'],
      status: json['ItemStatus'],
      itemId: json['ItemID'],
      description: json['ItemDesc'],
      imageUrl: json['ImageUrl'],
    );
  }

  factory OrderItem.fromTaskOrderLineJson(Map<String, dynamic> json){
    return OrderItem._(
      itemPrice: double.tryParse(json['UnitPrice']),
      orderedQuantity: int.tryParse(json['OrderedQty']),
      description: json['ItemShortDesc'],
      itemId: json['ItemID'],
      imageUrl: json['ImageUrl'],
      deliveredDate: json['deliveredDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ItemId': itemId,
      'ItemShortDesc': description,
      'UnitPrice': itemPrice,
      'OrderedQty': orderedQuantity,
    };
  }
}