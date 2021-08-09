import 'package:get/get.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/network/api_requests.dart';

class ProductRepository {
  final _apiRequests = ApiRequests();
  final globalController = Get.find<GlobalController>();

  int countInBasket(String id) {
    final items = <ProductModel>[];
    for (final item in globalController.basket) {
      if (item.id == id) {
        items.add(item);
      }
    }
    return items.length;
  }

  void removeProductFromBasket(String id) {
    for (int i = 0; i < globalController.basket.length; i++) {
      if (globalController.basket[i].id == id) {
        globalController.basket.removeAt(i);
        break;
      }
    }
  }

  int getProductVariantsCount() {
    final variants = <String>{};
    for (final item in globalController.basket) {
      variants.add(item.id!);
    }

    return variants.length;
  }
}
