class DeliveryModel {
  String? options;
  String? time;
  String? note;

  DeliveryModel({this.options, this.time, this.note});

  DeliveryModel.fromJson(dynamic json) {
    options = json['options'] as String;
    time = json['time'] as String;
    note = json['note'] as String;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['options'] = options;
    map['time'] = time;
    map['note'] = note;
    return map;
  }
}
