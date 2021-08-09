import 'package:dartz/dartz.dart';
import 'package:jify_app/models/basket_model.dart';
import 'package:jify_app/models/checkout_model.dart';
import 'package:jify_app/models/delivery_model.dart';
import 'package:jify_app/models/order_model.dart';
import 'package:jify_app/models/payment_model.dart';
import 'package:jify_app/models/promotion_code_model.dart';
import 'package:jify_app/network/api_requests.dart';

class CheckoutRepository {
  final _apiRequests = ApiRequests();

  Future<Either<String, OrderModel>> completeCheckout(
      String id, DeliveryModel delivery, PaymentModel payment) async {
    final result = await _apiRequests
        .completeCheckout(id, {"delivery": delivery, "payment": payment});
    String error = "";
    OrderModel? checkoutModel;

    result.fold(
        (l) => error = l,
        (r) => checkoutModel = OrderModel.fromJson(
            r.data["data"]["order"] as Map<String, dynamic>));

    if (checkoutModel != null) {
      return Right(checkoutModel!);
    } else {
      return Left(error);
    }
  }

  Future<Either<String, CheckoutModel>> getCheckout(String id) async {
    final result = await _apiRequests.getCheckout(id);
    String error = "";
    CheckoutModel? checkoutModel;

    result.fold(
        (l) => error = l,
        (r) => checkoutModel = CheckoutModel.fromJson(
            r.data["data"]["checkout"] as Map<String, dynamic>));

    if (checkoutModel != null) {
      return Right(checkoutModel!);
    } else {
      return Left(error);
    }
  }

  Future<Either<String, CheckoutModel>> checkout(BasketModel basket) async {
    final result = await _apiRequests.checkout(basket.toJson());
    String error = "";
    CheckoutModel? checkoutModel;

    result.fold(
        (l) => error = l,
        (r) => checkoutModel = CheckoutModel.fromJson(
            r.data["data"] as Map<String, dynamic>));

    if (checkoutModel != null) {
      return Right(checkoutModel!);
    } else {
      return Left(error);
    }
  }

  Future<Either<String, PromotionCodeModel>> checkPromotionCode(
      String code) async {
    final result = await _apiRequests.checkPromotionCode({"code": code});
    String error = "";
    PromotionCodeModel? promotionCode;

    result.fold(
        (l) => error = l,
        (r) => promotionCode = PromotionCodeModel.fromJson(
            r.data["data"]["promotion"] as Map<String, dynamic>));

    if (promotionCode != null) {
      return Right(promotionCode!);
    } else {
      return Left(error);
    }
  }
}
