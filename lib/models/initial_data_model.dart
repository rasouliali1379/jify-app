import 'category_model.dart';
import 'user_model.dart';

class InitialDataModel {
  List<CategoryModel>? categories;
  UserModel? user;
  double? supportedDistance;
  String? msg;
  double? delivery;

  InitialDataModel(
      {this.categories,
      this.user,
      this.supportedDistance,
      this.msg,
      this.delivery});

  InitialDataModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <CategoryModel>[];
      json['categories'].forEach((v) {
        categories?.add(CategoryModel.fromJson(v));
      });
    }
    user = json['user'] != null
        ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
        : null;
    if (json['supportedDistance'] is double) {
      supportedDistance = json['supportedDistance'] as double;
    } else {
      supportedDistance = (json['supportedDistance'] as int).toDouble();
    }
    msg = json['msg'] as String;
    delivery = json['delivery'] as double;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['supportedDistance'] = supportedDistance;
    map['msg'] = msg;
    map['delivery'] = delivery;
    return map;
  }
}
