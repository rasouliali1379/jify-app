import 'package:get/get.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/home_fragment_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/repositories/product_repository.dart';
import 'package:jify_app/utilities/utilities.dart';

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
    count = productRepository.countInBasket(product.id!);
  }

  void increaseCount() {
    if (count < product.stock!) {
      Get.find<HomeFragmentController>().addProductToBasket(product);
      count = productRepository.countInBasket(product.id!);
    } else {
      showCustomSnackBar("Only ${product.stock} ${product.title} available");
    }
  }

  void decreaseCount() {
    if (count != 0) {
      Get.find<HomeFragmentController>().removeFromBasket(product.id!);
      count = productRepository.countInBasket(product.id!);
    }
  }

  void openBasket() {
    Get.back();
    Get.find<MainPageController>().onBottomNavClickHandler(3);
  }

  double calculateDiscountedPrice(double price, double discount) {
    final discountAmount = price * discount / 100;
    return (price - discountAmount).toDouble();
  }

  double getTotalPrice() {
    return productRepository.countInBasket(product.id!) * product.price!;
  }
}
