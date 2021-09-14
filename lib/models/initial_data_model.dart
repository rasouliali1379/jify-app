import 'package:jify_app/models/banner_model.dart';

import 'category_model.dart';
import 'user_model.dart';

class InitialDataModel {
  List<BannerModel>? banners;
  List<CategoryModel>? categories;
  UserModel? user;
  double? supportedDistance;
  double? freeShipping;
  double? delivery;
  bool? isOpen;
  List<double>? storeLocation;

  InitialDataModel(
      {this.banners,
      this.categories,
      this.user,
      this.supportedDistance,
      this.freeShipping,
      this.delivery,
      this.isOpen,
      this.storeLocation});

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
    user = json['user'] != null ? UserModel.fromJson(json['user'] as Map<String, dynamic>) : null;
    if (json['supportedDistance'] is double) {
      supportedDistance = json['supportedDistance'] as double;
    } else {
      supportedDistance = (json['supportedDistance'] as int).toDouble();
    }
    delivery = json['delivery'] as double;
    isOpen = json['isOpen'] as bool;

    if (json['supportedDistance'] is double) {
      freeShipping = json['freeShipping'] as double;
    } else {
      freeShipping = (json['freeShipping'] as int).toDouble();
    }

    if (json['location'] != null) {
      storeLocation = <double>[];
      json['location'].forEach((v) {
        storeLocation?.add(v as double);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

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
    map['delivery'] = delivery;
    map['isOpen'] = isOpen;
    map['freeShipping'] = freeShipping;
    return map;
  }
}
