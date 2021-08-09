import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/models/order_model.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/repositories/order_repository.dart';
import 'package:jify_app/utilities/storage.dart';
import 'package:jify_app/utilities/utilities.dart';

class OrdersFragmentController extends GetxController {
  final _ordersList = <OrderModel>[].obs;
  final _previousOrdersList = <OrderModel>[].obs;
  final _loggedIn = false.obs;
  final _ordersRepository = OrderRepository();
  final refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void onInit() {
    checkUserLogStatus();
    super.onInit();
  }

  @override
  void onReady() {
    refreshKey.currentState!.show();
    super.onReady();
  }

  bool get loggedIn => _loggedIn.value;

  set loggedIn(bool value) {
    _loggedIn.value = value;
  }

  List<OrderModel> get ordersList => _ordersList;

  set ordersList(List<OrderModel> value) {
    _ordersList.value = value;
  }

  List<OrderModel> get previousOrdersList => _previousOrdersList.value;

  set previousOrdersList(List<OrderModel> value) {
    _previousOrdersList.value = value;
  }

  void openOrderDetailsPage(OrderModel order) {
    Get.toNamed(Routes.orderInfo, arguments: order);
  }

  Future<void> onRefresh() async {
    return getOrderList().then((value) => 'success');
  }

  Future<void> getOrderList() async {
    final result = await _ordersRepository.getOrdersList();

    result.fold((l) => attemptFailed(l), (r) => attemptSucceed(r));
  }

  void attemptFailed(String message) {
    Utilities.makeCustomToast(message);
  }

  void attemptSucceed(List<OrderModel> orders) {
    for (final order in orders) {
      if (order.status == "unknown") {
        ordersList.add(order);
      } else {
        previousOrdersList.add(order);
      }
    }
    update();
  }

  void checkUserLogStatus() {
    if (storageExists(AppKeys.token)) {
      if ((storageRead(AppKeys.token) as String).isNotEmpty) {
        loggedIn = true;
        return;
      }
    }
    loggedIn = false;
  }
}