import 'package:jify_app/models/address_model.dart';
import 'package:jify_app/models/amount_model.dart';
import 'package:jify_app/models/delivery_model.dart';
import 'package:jify_app/models/payment_model.dart';
import 'package:jify_app/models/product_model.dart';

class OrderModel {
  AddressModel? address;
  DeliveryModel? delivery;
  AmountModel? amount;
  PaymentModel? payment;
  String? status;
  String? driverId;
  int? driverEarning;
  String? image;
  String? id;
  int? orderNumber;
  String? userId;
  List<ProductModel>? products;
  String? date;
  int? v;

  OrderModel(
      {this.address,
      this.delivery,
      this.amount,
      this.payment,
      this.status,
      this.driverId,
      this.driverEarning,
      this.image,
      this.id,
      this.orderNumber,
      this.userId,
      this.products,
      this.date,
      this.v});

  OrderModel.fromJson(dynamic json) {
    address = json['address'] != null ? AddressModel.fromJson(json['address'] as Map<String, dynamic>) : null;
    delivery = json['delivery'] != null ? DeliveryModel.fromJson(json['delivery']) : null;
    amount = json['amount'] != null ? AmountModel.fromJson(json['amount']) : null;
    payment = json['payment'] != null ? PaymentModel.fromJson(json['payment']) : null;
    status = json['status'] as String;
    driverId = json['driverId'] == null ? null : json['driverId'] as String;

    // driverEarning =
    //     json['driverEarning'] == null ? null : json['driverEarning'] as int;
    image = json['image'] as String;
    id = json['_id'] as String;
    orderNumber = json['orderNumber'] as int;
    userId = json['userId'] as String;
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(ProductModel.fromJson(v));
      });
    }
    date = json['date'] as String;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (address != null) {
      map['address'] = address?.toJson();
    }
    if (delivery != null) {
      map['delivery'] = delivery?.toJson();
    }
    if (amount != null) {
      map['amount'] = amount?.toJson();
    }
    if (payment != null) {
      map['payment'] = payment?.toJson();
    }
    map['status'] = status;
    map['driverId'] = driverId;
    map['driverEarning'] = driverEarning;
    map['image'] = image;
    map['_id'] = id;
    map['orderNumber'] = orderNumber;
    map['userId'] = userId;
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['date'] = date;
    return map;
  }
}
