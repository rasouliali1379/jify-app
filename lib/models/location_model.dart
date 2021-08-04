class LocationModel {
  List<double>? coordinates;

  LocationModel({this.coordinates});

  LocationModel.fromJson(dynamic json) {
    coordinates =
        json['coordinates'] != null ? json['coordinates'] as List<double> : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['coordinates'] = coordinates;
    return map;
  }
}
