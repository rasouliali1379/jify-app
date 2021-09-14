class LocationModel {
  List<dynamic>? coordinates;

  LocationModel({this.coordinates});

  LocationModel.fromJson(dynamic json) {
    coordinates = json['coordinates'] != null ? json['coordinates'] as List<dynamic> : [];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coordinates'] = coordinates;
    return map;
  }
}
