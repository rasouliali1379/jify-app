import 'package:jify_app/models/card_model.dart';

import 'address_model.dart';

class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? mobileNumber;
  String? email;
  String? date;
  List<AddressModel>? addresses;
  CardModel? card;
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
      this.status,
      this.card});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] as String;
    firstname = json['firstname'] != null ? json['firstname'] as String : null;
    lastname = json['lastname'] != null ? json['lastname'] as String : null;
    mobileNumber = json['mobileNumber'] as String;
    email = json['email'] != null ? json['email'] as String : null;
    date = json['date'] as String;
    card = json['card'] != null ? CardModel.fromJson(json['card']) : null;
    if (json['addresses'] != null) {
      addresses = <AddressModel>[];
      json['addresses'].forEach((v) {
        addresses!.add(AddressModel.fromJson(v as Map<String, dynamic>));
      });
    }
    fcmToken = json['fcmToken'] != null ? json['fcmToken'] as String : null;
    if (json.containsKey("status")) {
      status = json['status'] as String;
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
