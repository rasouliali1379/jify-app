class CategoryModel {
  String? id;
  String? image;
  String? imageThumbnail;
  dynamic? parent;
  String? title;
  dynamic? products;
  List<dynamic>? subCategories;

  CategoryModel({
      this.id, 
      this.image, 
      this.imageThumbnail, 
      this.parent, 
      this.title, 
      this.products, 
      this.subCategories});

  CategoryModel.fromJson(dynamic json) {
    id = json["_id"] as String;
    image = json["image"] as String;
    imageThumbnail = json["imageThumbnail"] as String;
    parent = json["parent"];
    title = json["title"] as String;
    products = json["products"];
    if (json["subCategories"] != null) {
      subCategories = [];
      json["subCategories"].forEach((v) {
        subCategories?.add(CategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["_id"] = id;
    map["image"] = image;
    map["imageThumbnail"] = imageThumbnail;
    map["parent"] = parent;
    map["title"] = title;
    map["products"] = products;
    if (subCategories != null) {
      map["subCategories"] = subCategories?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}