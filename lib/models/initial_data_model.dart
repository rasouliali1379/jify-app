import 'category_model.dart';
import 'user_model.dart';

class InitialDataModel {
  List<CategoryModel>? categories;
  UserModel? user;
  int? supportedDistance;
  String? msg;

  InitialDataModel(
      {this.categories, this.user, this.supportedDistance, this.msg});

  InitialDataModel.fromJson(dynamic json) {
    if (json['categories'] != null) {
      categories = <CategoryModel>[];
      json['categories'].forEach((v) {
        categories?.add(CategoryModel.fromJson(v));
      });
    }
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    supportedDistance = json['supportedDistance'] as int;
    msg = json['msg'] as String;
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
    return map;
  }
}
