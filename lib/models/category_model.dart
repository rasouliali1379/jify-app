import 'package:jify_app/models/product_model.dart';

class CategoryModel {
  String? id;
  String? image;
  String? imageThumbnail;
  String? title;
  List<ProductModel>? products;
  List<CategoryModel>? subCategories;

  CategoryModel({this.id, this.image, this.imageThumbnail, this.title, this.products, this.subCategories});

  CategoryModel.fromJson(dynamic json) {
    id = json['_id'] as String;
    image = json['image'] as String;
    imageThumbnail = json['imageThumbnail'] as String;
    title = json['title'] as String;

    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(ProductModel.fromJson(v));
      });
    }
    if (json['subCategories'] != null) {
      subCategories = [];
      json['subCategories'].forEach((v) {
        subCategories?.add(CategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['image'] = image;
    map['imageThumbnail'] = imageThumbnail;
    map['title'] = title;
    map['products'] = products;
    if (subCategories != null) {
      map['subCategories'] = subCategories?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
