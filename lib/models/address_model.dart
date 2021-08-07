import 'location_model.dart';

class AddressModel {
  LocationModel? location;
  String? type;
  String? address;
  String? apt;
  String? building;
  String? note;
  String? options;
  double? distance;
  String? id;

  AddressModel(
      {this.location,
      this.type,
      this.address,
      this.apt,
      this.building,
      this.note,
      this.options,
      this.distance,
      this.id});

  AddressModel.fromJson(Map<String,dynamic> json) {
    location = json['location'] != null
        ? LocationModel.fromJson(json['location'])
        : null;
    type = json['type'] as String;
    address = json['address'] as String;
    apt = json['apt'] as String;
    building = json['building'] as String;
    note = json['note'] as String;
    options = json['options'] as String;
    distance = json['distance'] as double;
    id = json['_id'] as String;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['type'] = type;
    map['address'] = address;
    map['apt'] = apt;
    map['building'] = building;
    map['note'] = note;
    map['options'] = options;
    map['distance'] = distance;
    map['_id'] = id;
    return map;
  }
}
