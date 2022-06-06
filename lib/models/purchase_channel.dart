class PurchaseChannel {
  final double? cc;
  final double? retail;

  PurchaseChannel._({
    this.cc,
    this.retail,
  });

  factory PurchaseChannel.fromJson(Map<String, dynamic> json){
    return PurchaseChannel._(
      cc: double.tryParse(json['CC']),
      retail: double.tryParse(json['Retail']),
    );
  }

}
