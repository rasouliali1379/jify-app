class PromotionCodeModel {
  int? value;
  String? end;
  String? id;
  String? title;
  String? code;
  String? type;
  String? start;
  int? v;

  PromotionCodeModel({this.value, this.end, this.id, this.title, this.code, this.type, this.start, this.v});

  PromotionCodeModel.fromJson(Map<String, dynamic> json) {
    value = json['value'] as int;
    end = json['end'] as String;
    id = json['_id'] as String;
    title = json['title'] as String;
    code = json['code'] as String;
    type = json['type'] as String;
    start = json['start'] as String;
    v = json['__v'] as int;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = value;
    map['end'] = end;
    map['_id'] = id;
    map['title'] = title;
    map['code'] = code;
    map['type'] = type;
    map['start'] = start;
    map['__v'] = v;
    return map;
  }
}
