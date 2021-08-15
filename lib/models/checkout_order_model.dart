class CheckoutOrderModel {
  String? id;
  int? qty;

  CheckoutOrderModel({this.id, this.qty});

  CheckoutOrderModel.fromJson(dynamic json) {
    id = json['_id'] as String;
    qty = json['qty'] as int;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['qty'] = qty;
    return map;
  }
}
