import 'package:jify_app/models/checkout_order_model.dart';

class BasketModel {
  List<CheckoutOrderModel>? products;
  Promotion? promotion;
  Address? address;

  BasketModel({this.products, this.promotion, this.address});

  BasketModel.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(CheckoutOrderModel.fromJson(v));
      });
    }
    promotion = json['promotion'] != null ? Promotion.fromJson(json['promotion']) : null;
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    if (promotion != null) {
      map['promotion'] = promotion?.toJson();
    }
    if (address != null) {
      map['address'] = address?.toJson();
    }
    return map;
  }
}

class Address {
  String? id;

  Address({this.id});

  Address.fromJson(dynamic json) {
    id = json['_id'] as String;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    return map;
  }
}

class Promotion {
  String? code;

  Promotion({this.code});

  Promotion.fromJson(dynamic json) {
    code = json['code'] as String;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = code;
    return map;
  }
}

class Products {
  String? id;
  int? qty;

  Products({this.id, this.qty});

  Products.fromJson(dynamic json) {
    id = json['_id'] as String;
    qty = json['qty'] as int;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['qty'] = qty;
    return map;
  }
}
