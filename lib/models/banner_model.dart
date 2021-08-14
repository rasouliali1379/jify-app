class BannerModel {
  String? image;
  String? thumbnail;
  String? linkTo;
  String? object;
  bool? available;
  String? id;
  int? v;

  BannerModel(
      {this.image,
      this.thumbnail,
      this.linkTo,
      this.object,
      this.available,
      this.id,
      this.v});

  BannerModel.fromJson(dynamic json) {
    image = json['image'] as String;
    thumbnail = json['thumbnail'] as String;
    linkTo = json['linkTo'] != null ? json['linkTo'] as String : null;
    object = json['object'] != null ? json['object'] as String : null;
    available = json['available'] as bool;
    id = json['_id'] as String;
    v = json['__v'] as int;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['image'] = image;
    map['thumbnail'] = thumbnail;
    map['linkTo'] = linkTo;
    map['object'] = object;
    map['available'] = available;
    map['_id'] = id;
    map['__v'] = v;
    return map;
  }
}
