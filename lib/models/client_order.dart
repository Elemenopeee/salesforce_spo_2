class ClientOrder {
  final String? id;
  final String? name;
  final String? createdDate;
  final double? amount;
  final String? orderStatus;
  final String? orderNumber;
  final List<OrderItem>? items;

  ClientOrder._({
    this.id,
    this.name,
    this.createdDate,
    this.amount,
    this.orderStatus,
    this.items,
    this.orderNumber,
  });

  factory ClientOrder.fromJson(Map<String, dynamic> json) {
    List<OrderItem> items = [];
    try {
      if (json['GC_Order_Line_Items__r'] != null) {
        for (var record in json['GC_Order_Line_Items__r']['records']) {
          items.add(OrderItem.fromJson(record));
        }
      }
    } catch (e) {
      print('$e');
    }

    return ClientOrder._(
      id: json['Id'],
      name: json['Name'],
      createdDate: json['CreatedDate'],
      amount: json['Total__c'],
      orderStatus: json['Order_Status__c'],
      orderNumber: json['Order_Number__c'],
      items: items,
    );
  }

  factory ClientOrder.fromOrderHistoryJson(Map<String, dynamic> json) {

    List<OrderItem> items = [];

    try {
      if(json['LineItems'] != null){
        for(var itemRecord in json['LineItems']){
          items.add(OrderItem.fromOrderHistoryJson(itemRecord));
        }
      }
    }
    catch (e) {
      print(e);
    }

    double totalPrice = 0;

    for (var item in items){
      totalPrice += double.parse(item.itemPrice ?? '0');
    }

    return ClientOrder._(
      orderNumber: json['OrderNumber'],
      createdDate: json['OrderDate'],
      amount: totalPrice,
    );
  }
}

class OrderItem {
  final String? imageUrl;
  final String? itemPrice;

  OrderItem._({this.imageUrl, this.itemPrice});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    var imageUrl = json['Image_URL__c'];

    if (json['Image_URL__c'] == null) {
      imageUrl = json['Image_URL1__c'];
    }

    return OrderItem._(
      imageUrl: imageUrl,
    );
  }

  factory OrderItem.fromOrderHistoryJson(Map<String, dynamic> json) {
    return OrderItem._(
      itemPrice: json['PurchasedPrice'],
    );
  }
}
