import 'package:get/get.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/home_fragment_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/models/order_model.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/navigation/routes.dart';

class OrderInfoPageController extends GetxController {
  final _orderDetail = OrderModel().obs;

  final month = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  @override
  void onInit() {
    getData();
    super.onInit();
  }

  OrderModel get orderDetail => _orderDetail.value;

  set orderDetail(OrderModel value) {
    _orderDetail.value = value;
  }

  void getData() {
    orderDetail = Get.arguments as OrderModel;
  }

  String getFormattedDate(String date) {
    final timeZone = DateTime.now().timeZoneOffset;

    final dateTime = DateTime.parse(date).add(timeZone);

    return "${month[dateTime.month - 1]} ${dateTime.day} ,"
        " ${dateTime.year} - ${dateTime.hour}:${dateTime.minute}";
  }

  void reorder() {
    final basket = <ProductModel>[];

    for (final product in orderDetail.products!) {
      for (int i = 0; i < product.qty!; i++) {
        basket.add(product);
      }
    }
    final globalController = Get.find<GlobalController>();
    globalController.basket.clear();
    globalController.basket.addAll(basket);
    Get.find<CheckoutFragmentController>().populateOrders();
    Get.find<MainPageController>().onBottomNavClickHandler(3);
    Get.find<HomeFragmentController>().update();
    Get.back();
  }


  void openHelpCenter(){
    Get.toNamed(Routes.helpCenter);
  }
}
