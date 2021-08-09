import 'package:dartz/dartz.dart';
import 'package:jify_app/models/order_model.dart';
import 'package:jify_app/network/api_requests.dart';

class OrderRepository {
  final _apiRequests = ApiRequests();

  Future<Either<String, List<OrderModel>>> getOrdersList() async {
    final result = await _apiRequests.getOrders();
    String error = "";
    List<OrderModel>? ordersList;

    result.fold((l) => error = l, (r) {
      final rawJson = r.data["data"]["orders"] as List<dynamic>;
      ordersList =
          List<OrderModel>.from(rawJson.map((e) => OrderModel.fromJson(e)));
    });

    if (ordersList != null) {
      return Right(ordersList!);
    } else {
      return Left(error);
    }
  }
}
