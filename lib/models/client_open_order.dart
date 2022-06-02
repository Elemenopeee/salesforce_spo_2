class ClientOpenOrder {
  final String? id;
  final String? name;
  final String? createdDate;
  final double? amount;
  final List<OrderItem>? items;

  ClientOpenOrder._({
    this.id,
    this.name,
    this.createdDate,
    this.amount,
    this.items,
  });

  factory ClientOpenOrder.fromJson(Map<String, dynamic> json){
    
    List<OrderItem> items = [];

    // try{
    //   if(json['GC_Order_Line_Items__r'] != null){
    //     for (var record in json['GC_Order_Line_Items__r']['records']){
    //       items.add(OrderItem.fromJson(record['Image_URL1__c']));
    //     }
    //   }
    // }
    // catch (e){
    //   print('here $e');
    // }

    return ClientOpenOrder._(
      id: json['Id'],
      name: json['Name'],
      createdDate: json['CreatedDate'],
      amount: json['Total__c'],
      items: items,
    );
  }

}

class OrderItem {
  final String? imageUrl;

  OrderItem._({this.imageUrl});

  factory OrderItem.fromJson(Map<String, dynamic> json){
    return OrderItem._(
      imageUrl: json['Image_URL1__c'],
    );
  }

}
