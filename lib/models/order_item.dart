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
  });

  factory OrderItem.fromTaskJson(Map<String, dynamic> json){
    return OrderItem._(
      itemPrice: double.tryParse(json['UnitPrice']),
      trackingNumber: json['TrackingNo'] ?? '--',
      orderLineKey: json['OrderLineKey'],
      orderedQuantity: json['OrderedQuantity'],
      lineItem: json['LineItem'],
      status: json['ItemStatus'],
      itemId: json['ItemID'],
      description: json['ItemDesc'],
      imageUrl: json['ImageUrl'],
    );
  }

}

// "UnitPrice": "24.99",
// "TrackingNo": "1ZA2552X0390861225",
// "OrderLineKey": "202108211013419189838126",
// "OrderedQuantity": 5,
// "LineItem": 1,
// "ItemStatus": "delivered",
// "ItemID": "J21161000000000",
// "ItemDesc": "Gator Frameworks Microphone Stand Accessory Tray with Drink Holder and Guitar Pick Tab",
// "ImageUrl": "http://media.musiciansfriend.com/is/image/MMGS7/J21161000000000-00-120x120.jpg"
