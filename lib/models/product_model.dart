class ProductModel {
  String? title;
  String? image;
  String? imageThumbnail;
  double? price;
  String? description;
  int? stock;
  String? id;
  String? category;

  ProductModel(
      {this.title,
      this.image,
      this.imageThumbnail,
      this.price,
      this.description,
      this.stock,
      this.id,
      this.category});

  ProductModel.fromJson(dynamic json) {
    title = json['title'] as String;
    image = json['image'] as String;
    imageThumbnail = json['imageThumbnail'] as String;
    price = double.parse(json['price'].toString());
    description = json['description'] as String;
    stock = json['stock'] as int;
    id = json['_id'] as String;
    category = json['category'] as String;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['title'] = title;
    map['image'] = image;
    map['imageThumbnail'] = imageThumbnail;
    map['price'] = price;
    map['description'] = description;
    map['stock'] = stock;
    map['_id'] = id;
    map['category'] = category;
    return map;
  }
}
