class PaymentModel {
  String? code;

  PaymentModel({this.code});

  PaymentModel.fromJson(dynamic json) {
    code = json['code'] as String;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['code'] = code;
    return map;
  }
}