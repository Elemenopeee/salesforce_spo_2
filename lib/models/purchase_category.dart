class PurchaseCategory{

  Map<String, dynamic> purchaseCategory;
  
  PurchaseCategory._({required this.purchaseCategory});
  
  factory PurchaseCategory.fromJson(Map<String, dynamic> json){
    return PurchaseCategory._(purchaseCategory: json['PurchaseCategory']);
  }

}