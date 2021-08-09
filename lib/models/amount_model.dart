class AmountModel {
  double? subTotal;
  double? delivery;
  double? promotion;
  double? total;

  AmountModel({this.subTotal, this.delivery, this.promotion, this.total});

  AmountModel.fromJson(dynamic json) {
    if (json['subTotal'] is int) {
      subTotal = (json['subTotal'] as int).toDouble();
    } else {
      subTotal = json['subTotal'] as double;
    }

    if (json['delivery'] is int) {
      delivery = (json['delivery'] as int).toDouble();
    } else {

    delivery = json['delivery'] as double;
    }

    if (json['promotion'] is int) {
      promotion = (json['promotion'] as int).toDouble();
    } else {

      promotion = json['promotion'] as double;
    }

    if (json['total'] is int) {
      total = (json['total'] as int).toDouble();
    } else {

      total = json['total'] as double;
    }
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
