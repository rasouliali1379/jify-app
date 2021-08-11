import 'package:get/get.dart';
import 'package:jify_app/controllers/account_fragment_controller.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/home_fragment_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/controllers/orders_fragment_controller.dart';

class MainPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainPageController());
    Get.lazyPut(() => HomeFragmentController());
    Get.lazyPut(() => AccountFragmentController());
    Get.lazyPut(() => OrdersFragmentController());
    Get.lazyPut(() => CheckoutFragmentController());
  }
}
