class PaymentModel {
  String? nonce;
  String? deviceData;
  String? description;
  int? status;

  PaymentModel({this.nonce, this.deviceData, this.description, this.status});

  PaymentModel.fromJson(dynamic json) {
    nonce = json['nonce'] == null ? null : json['nonce'] as String;
    if (json['device-data'] == null) {
      deviceData = null;
    } else {
      deviceData = json['device-data'].toString();
    }
    description =
        json['description'] == null ? null : json['description'] as String;
    status = json['status'] == null ? null : json['status'] as int;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nonce'] = nonce;
    map['device-data'] = deviceData;
    map['description'] = description;
    map['status'] = status;
    return map;
  }
}
