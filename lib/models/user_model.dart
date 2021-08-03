import 'address_model.dart';

class UserModel {
  String? id;
  String? firstname;
  String? lastname;
  String? mobileNumber;
  String? email;
  String? date;
  List<AddressModel>? addresses;
  dynamic? fcmToken;

  UserModel(
      {this.id,
      this.firstname,
      this.lastname,
      this.mobileNumber,
      this.email,
      this.date,
      this.addresses,
      this.fcmToken});

  UserModel.fromJson(dynamic json) {
    id = json["_id"] as String;
    firstname = json["firstname"] as String;
    lastname = json["lastname"] as String;
    mobileNumber = json["mobileNumber"] as String;
    email = json["email"] as String;
    date = json["date"] as String;
    if (json["addresses"] != null) {
      addresses = [];
      json["addresses"].forEach((v) {
        addresses?.add(AddressModel.fromJson(v));
      });
    }
    fcmToken = json["fcmToken"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = id;
    map["firstname"] = firstname;
    map["lastname"] = lastname;
    map["mobileNumber"] = mobileNumber;
    map["email"] = email;
    map["date"] = date;
    if (addresses != null) {
      map["addresses"] = addresses?.map((v) => v.toJson()).toList();
    }
    map["fcmToken"] = fcmToken;
    return map;
  }
}
