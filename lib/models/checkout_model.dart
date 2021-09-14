import 'package:jify_app/models/address_model.dart';
import 'package:jify_app/models/amount_model.dart';
import 'package:jify_app/models/product_model.dart';

class CheckoutModel {
  Checkout? checkout;

  CheckoutModel({this.checkout});

  CheckoutModel.fromJson(dynamic json) {
    checkout = json['checkout'] != null ? Checkout.fromJson(json['checkout']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (checkout != null) {
      map['checkout'] = checkout?.toJson();
    }
    return map;
  }
}

class Checkout {
  String? id;
  List<ProductModel>? products;
  String? promotion;
  AmountModel? amount;

  Checkout({this.id, this.products, this.promotion, this.amount});

  Checkout.fromJson(dynamic json) {
    id = json['_id'] as String;
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(ProductModel.fromJson(v));
      });
    }
    promotion = json['promotion'] == null ? null : json['promotion'] as String;
    amount = json['amount'] != null ? AmountModel.fromJson(json['amount']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['promotion'] = promotion;
    if (amount != null) {
      map['amount'] = amount?.toJson();
    }
    return map;
  }
}
