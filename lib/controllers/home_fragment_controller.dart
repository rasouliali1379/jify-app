import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jify_app/controllers/category_fragment_controller.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/models/category_model.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/repositories/product_repository.dart';
import 'package:jify_app/utilities/utilities.dart';

class HomeFragmentController extends GetxController {
  final _mainController = Get.find<MainPageController>();
  final _globalController = Get.find<GlobalController>();
  final productRepository = ProductRepository();
  final searchTextController = TextEditingController();

  final _categoryItems = <CategoryModel>[].obs;
  final _searchedProducts = <ProductModel>[].obs;
  final _searchMode = false.obs;
  final _searchLoading = false.obs;

  @override
  void onInit() {
    categoryItems = _globalController.initialDataModel.categories!;
    super.onInit();
  }

  bool get searchLoading => _searchLoading.value;

  set searchLoading(bool value) {
    _searchLoading.value = value;
  }

  bool get searchMode => _searchMode.value;

  set searchMode(bool value) {
    _searchMode.value = value;
  }

  List<ProductModel> get searchedProducts => _searchedProducts.value;

  set searchedProducts(List<ProductModel> value) {
    _searchedProducts.value = value;
  }

  List<CategoryModel> get categoryItems => _categoryItems.value;

  set categoryItems(List<CategoryModel> value) {
    _categoryItems.value = value;
  }

  Function() onCategoryItemClickHandler(int index) {
    return () {
      Get.find<CategoryFragmentController>().populateData(index);
      _mainController.pageStack.add(3);
      _mainController.pageController.jumpToPage(3);
      _mainController.backBtnVisibility = true;
    };
  }

  void searchChangeHandler(String value) {
    if (value.isNotEmpty) {
      searchMode = true;
      _mainController.backBtnVisibility = true;
      if (value.length % 3 == 0) {
        searchLoading = true;
        searchedProducts.clear();
        update();
        productRepository.searchProducts(value, 1).then((value) =>
            value.fold((l) => attemptFailed(l), (r) => attemptSucceed(r)));
      }
    } else {
      _mainController.backBtnVisibility = false;
      searchMode = false;
    }
    update();
  }

  void attemptFailed(String message) {
    searchLoading = false;
    Utilities.makeCustomToast(message);
  }

  void attemptSucceed(List<ProductModel> products) {
    searchLoading = false;
    searchedProducts = products;
    update();
  }

  void addProductToBasket(ProductModel product, {int count = 1}) {
    for (int i = 0; i < count; i++) {
      _globalController.basket.add(product);
    }
    update();
    Get.find<CheckoutFragmentController>().populateOrders();
  }

  void removeFromBasket(String id) {
    productRepository.removeProductFromBasket(id);
    update();
    Get.find<CheckoutFragmentController>().populateOrders();
  }

  void browseProduct(ProductModel product) {
    Get.toNamed(Routes.product,
        preventDuplicates: true, arguments: product.toJson());
  }

  void onAppBarBackPressed() {
    searchedProducts.clear();
    searchTextController.text = "";
    _mainController.backBtnVisibility = false;
    searchMode = false;
    update();
  }
}
