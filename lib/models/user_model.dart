import 'package:jify_app/navigation/pages.dart';

import 'address_model.dart';

class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? mobileNumber;
  String? email;
  String? date;
  List<AddressModel>? addresses;
  String? fcmToken;
  String? status;

  UserModel(
      {this.id,
      this.firstname,
      this.lastname,
      this.mobileNumber,
      this.email,
      this.date,
      this.addresses,
      this.fcmToken,
      this.status});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String;
    firstname = json['firstname'] as String;
    lastname = json['lastname'] as String;
    mobileNumber = json['mobileNumber'] as String;
    email = json['email'] as String;
    date = json['date'] as String;
    if (json['addresses'] != null) {
      addresses = [];
      json['addresses'].forEach((v) {
        addresses?.add(AddressModel.fromJson(v as Map<String, dynamic>));
      });
    }
    fcmToken = json['fcmToken'] as String;
    if (json.containsKey("status")) {
      status = json['status'] as String;
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['_id'] = id;
    map['firstname'] = firstname;
    map['lastname'] = lastname;
    map['mobileNumber'] = mobileNumber;
    map['email'] = email;
    map['date'] = date;
    if (addresses != null) {
      map['addresses'] = addresses?.map((v) => v.toJson()).toList();
    }
    map['fcmToken'] = fcmToken;

    if (status != null) {
      map['status'] = status;
    }
    return map;
  }
}
