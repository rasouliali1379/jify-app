import 'package:get/get.dart';
import 'package:jify_app/navigation/routes.dart';

class OrdersFragmentController extends GetxController {
  void openOrderDetailsPage() {
    Get.toNamed(Routes.orderInfo);
  }
}
