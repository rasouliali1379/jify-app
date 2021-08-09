class PredictedLatLongModel {
  String? formattedAddress;
  String? name;
  Geometry? geometry;

  PredictedLatLongModel({this.formattedAddress, this.name, this.geometry});

  PredictedLatLongModel.fromJson(dynamic json) {
    formattedAddress = json['formatted_address'] as String;
    name = json['name'] as String;
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['formatted_address'] = formattedAddress;
    map['name'] = name;
    if (geometry != null) {
      map['geometry'] = geometry?.toJson();
    }
    return map;
  }
}

class Geometry {
  Location? location;

  Geometry({this.location});

  Geometry.fromJson(dynamic json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }

    return map;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(dynamic json) {
    lat = json['lat'] as double;
    lng = json['lng'] as double;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }
}
