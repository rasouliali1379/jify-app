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

  ProductModel(
      {this.title,
      this.image,
      this.imageThumbnail,
      this.price,
      this.description,
      this.stock,
      this.id,
      this.category,
      this.qty});

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
    map['qty'] = qty;
    return map;
  }
}
