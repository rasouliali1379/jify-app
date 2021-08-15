import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/models/order_model.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/repositories/order_repository.dart';
import 'package:jify_app/utilities/storage.dart';
import 'package:jify_app/utilities/utilities.dart';

class OrdersFragmentController extends GetxController {
  final _ordersList = <OrderModel>[].obs;
  final _previousOrdersList = <OrderModel>[].obs;
  final _loggedIn = false.obs;
  final _ordersRepository = OrderRepository();

  @override
  void onInit() {
    checkUserLogStatus();
    super.onInit();
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
    print(storageRead(AppKeys.token));
    result.fold((l) => attemptFailed(l), (r) => attemptSucceed(r));
  }

  void attemptFailed(String message) {
    makeCustomToast(message);
  }

  void attemptSucceed(List<OrderModel> orders) {
    ordersList.clear();
    previousOrdersList.clear();
    print(orders.toString());
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
        getOrderList();
        return;
      }
    }
    loggedIn = false;
  }

  void openSignInPage() {
    Get.toNamed(Routes.signIn);
  }

  void reorder(OrderModel orderModel) {
    final basket = <ProductModel>[];

    for (final product in orderModel.products!) {
      for (int i = 0; i < product.qty!; i++) {
        basket.add(product);
      }
    }
    final globalController = Get.find<GlobalController>();
    globalController.basket.clear();
    globalController.basket.addAll(basket);
    Get.find<CheckoutFragmentController>().populateOrders();
    Get.find<MainPageController>().onBottomNavClickHandler(3);
  }

  void startOrdering() {
    Get.find<MainPageController>().onBottomNavClickHandler(0);
  }
}
