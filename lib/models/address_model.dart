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
  bool? notify;

  AddressModel(
      {this.location,
      this.type,
      this.address,
      this.apt,
      this.building,
      this.note,
      this.options,
      this.distance,
      this.id,
      this.notify});

  AddressModel.fromJson(dynamic json) {
    location = json['location'] != null ? LocationModel.fromJson(json['location']) : null;
    type = json['type'] as String;
    address = json['address'] as String;
    apt = json['apt'] as String;
    building = json['building'] as String;
    note = json['note'] as String;
    options = json['options'] as String;
    distance = json['distance'] == null ? null : json['distance'] as double;
    id = json['_id'] == null ? null : json['_id'] as String;
    notify = json['notify'] == null ? null : json['notify'] as bool;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    map['notify'] = notify;
    return map;
  }
}
