class ProductModel {
  String? title;
  String? image;
  String? imageThumbnail;
  double? price;
  String? description;
  int? stock;
  String? id;
  String? category;
  int? qty;
  double? off;
  ProductModel(
      {this.title,
      this.image,
      this.imageThumbnail,
      this.price,
      this.description,
      this.stock,
      this.id,
      this.category,
      this.qty,
      this.off});

  ProductModel.fromJson(dynamic json) {
    title = json['title'] as String;
    image = json['image'] as String;
    imageThumbnail = json['imageThumbnail'] as String;
    price = double.parse(json['price'].toString());
    description =
        json['description'] == null ? null : json['description'] as String;
    stock = json['stock'] == null ? null : json['stock'] as int;
    id = json['_id'] as String;
    category = json['category'] == null ? null : json['category'] as String;
    qty = json['qty'] == null ? null : json['qty'] as int;
    if (json["off"] != null) {
      if (json["off"] is int) {
        off = (json["off"] as int).toDouble();
      } else {
        off = json["off"] as double;
      }
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['image'] = image;
    map['imageThumbnail'] = imageThumbnail;
    map['price'] = price;
    map['description'] = description;
    map['stock'] = stock;
    map['_id'] = id;
    map['category'] = category;
    map['qty'] = qty;
    map['off'] = off;
    return map;
  }
}
