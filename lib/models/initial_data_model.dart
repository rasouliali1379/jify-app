import 'package:jify_app/models/banner_model.dart';

import 'category_model.dart';
import 'user_model.dart';

class InitialDataModel {
  List<BannerModel>? banners;
  List<CategoryModel>? categories;
  UserModel? user;
  double? supportedDistance;
  String? msg;
  double? delivery;
  bool? isOpen;

  InitialDataModel(
      {this.banners,
      this.categories,
      this.user,
      this.supportedDistance,
      this.msg,
      this.delivery,
      this.isOpen});

  InitialDataModel.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <BannerModel>[];
      json['banners'].forEach((v) {
        banners?.add(BannerModel.fromJson(v));
      });
    }

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
    isOpen = json['isOpen'] as bool;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    if (banners != null) {
      map['banners'] = banners?.map((v) => v.toJson()).toList();
    }

    if (categories != null) {
      map['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['supportedDistance'] = supportedDistance;
    map['msg'] = msg;
    map['delivery'] = delivery;
    map['isOpen'] = isOpen;
    return map;
  }
}
