class AmountModel {
  double? subTotal;
  double? delivery;
  int? promotion;
  double? total;

  AmountModel({this.subTotal, this.delivery, this.promotion, this.total});

  AmountModel.fromJson(dynamic json) {
    subTotal = json['subTotal'] as double;
    delivery = json['delivery'] as double;
    promotion = json['promotion'] as int;
    total = json['total'] as double;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subTotal'] = subTotal;
    map['delivery'] = delivery;
    map['promotion'] = promotion;
    map['total'] = total;
    return map;
  }
}