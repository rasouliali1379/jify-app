import 'package:get/get.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/home_fragment_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/repositories/product_repository.dart';

class ProductPageController extends GetxController {
  final productRepository = ProductRepository();

  final _variants = 0.obs;

  final _count = 1.obs;

  final _product = ProductModel().obs;

  @override
  void onInit() {
    getProduct();
    variants = productRepository.getProductVariantsCount();
    super.onInit();
  }

  int get variants => _variants.value;

  set variants(int value) {
    _variants.value = value;
  }

  ProductModel get product => _product.value;

  set product(ProductModel value) {
    _product.value = value;
  }

  int get count => _count.value;

  set count(int value) {
    _count.value = value;
  }

  void getProduct() {
    product = ProductModel.fromJson(Get.arguments);
  }

  void increaseCount() {
    count++;
  }

  void decreaseCount() {
    if (count != 1) {
      count--;
    }
  }

  void addToBasket() {
    Get.find<HomeFragmentController>()
        .addProductToBasket(product, count: count);
    Get.find<CheckoutFragmentController>().populateOrders();
    variants = productRepository.getProductVariantsCount();
  }

  void openBasket() {
    Get.back();
    Get.find<MainPageController>().onBottomNavClickHandler(3);
  }
}
