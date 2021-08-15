class PaymentModel {
  String? code;

  PaymentModel({this.code});

  PaymentModel.fromJson(dynamic json) {
    code = json['code'] as String;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    return map;
  }
}