class DeliveryModel {
  String? options;
  String? time;
  String? note;

  DeliveryModel({this.options, this.time, this.note});

  DeliveryModel.fromJson(dynamic json) {
    options = json['options'] != null ? json['options'] as String : null;
    time = json['time'] != null ? json['time'] as String : null;
    note = json['note'] != null ? json['note'] as String : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['options'] = options;
    map['time'] = time;
    map['note'] = note;
    return map;
  }
}
