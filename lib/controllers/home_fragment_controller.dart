import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_status.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/models/category_model.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/repositories/product_repository.dart';
import 'package:jify_app/utilities/utilities.dart';

class HomeFragmentController extends GetxController {
  final mainController = Get.find<MainPageController>();
  final _globalController = Get.find<GlobalController>();
  final scrollController = ScrollController();
  final productRepository = ProductRepository();
  final searchTextController = TextEditingController();
  final searchFocusNode = FocusNode();

  final _selectedSubcategory = (-1).obs;
  final _subCategories = <CategoryModel>[].obs;
  final _categoryItems = <CategoryModel>[].obs;
  final _searchedProducts = <ProductModel>[].obs;
  final _products = <ProductModel>[].obs;
  final _pageMode = "categories".obs;
  final _searchLoading = false.obs;
  final _pagginationStatus = (AppStatus.done).obs;
  final _productStatus = (AppStatus.loading).obs;

  String selectedCategoryId = "";
  String lastPage = "category";
  bool searchMode = false;
  bool requestPermitted = true;
  int page = 1;

  @override
  void onInit() {
    categoryItems = _globalController.initialDataModel.categories!;
    super.onInit();
  }

  String get productStatus => _productStatus.value;

  set productStatus(String value) {
    _productStatus.value = value;
  }

  String get pagginationStatus => _pagginationStatus.value;

  set pagginationStatus(String value) {
    _pagginationStatus.value = value;
  }

  bool get searchLoading => _searchLoading.value;

  set searchLoading(bool value) {
    _searchLoading.value = value;
  }

  String get pageMode => _pageMode.value;

  set pageMode(String value) {
    _pageMode.value = value;
  }

  List<ProductModel> get searchedProducts => _searchedProducts.value;

  set searchedProducts(List<ProductModel> value) {
    _searchedProducts.value = value;
  }

  List<ProductModel> get products => _products.value;

  set products(List<ProductModel> value) {
    _products.value = value;
  }

  List<CategoryModel> get categoryItems => _categoryItems.value;

  set categoryItems(List<CategoryModel> value) {
    _categoryItems.value = value;
  }

  List<CategoryModel> get subCategories => _subCategories.value;

  set subCategories(List<CategoryModel> value) {
    _subCategories.value = value;
  }

  int get selectedSubcategory => _selectedSubcategory.value;

  set selectedSubcategory(int value) {
    _selectedSubcategory.value = value;
  }

  void initScrollListener() {
    scrollController.addListener(() {
      //Reach Bottom
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange &&
          pagginationStatus == AppStatus.loading &&
          requestPermitted) {
        requestPermitted = false;
        requestProducts();
      }
    });
  }

  void onCategoryItemClickHandler(int index) {
    populateData(index);
    pageMode = "subcategory";
    mainController.backBtnVisibility = true;
    selectedCategoryId = categoryItems[index].id!;
    searchFocusNode.unfocus();
    update();
  }

  void searchChangeHandler(String value) {
    if (value.isNotEmpty) {
      if (!searchMode) {
        lastPage = pageMode;
      }
      searchMode = true;
      pageMode = "search";
      mainController.backBtnVisibility = true;
      if (value.length % 3 == 0) {
        searchLoading = true;
        searchedProducts.clear();
        productRepository.searchProducts(value, 1).then((value) =>
            value.fold((l) => attemptFailed(l), (r) => attemptSucceed(r)));
      }
    } else {
      searchMode = false;
      mainController.backBtnVisibility = false;
      pageMode = "categories";
    }
    update();
  }

  void attemptFailed(String message) {
    searchLoading = false;
    makeCustomToast(message);
  }

  void attemptSucceed(List<ProductModel> products) {
    searchLoading = false;
    searchedProducts = products;
    update();
  }

  void addProductToBasket(ProductModel product, {int count = 1}) {
    if (productRepository.countInBasket(product.id!) + count <=
        product.stock!) {
      for (int i = 0; i < count; i++) {
        _globalController.basket.add(product);
      }
      update();
      Get.find<CheckoutFragmentController>().populateOrders();
      Get.find<GlobalController>().updateTotalCost();
    } else {
      showCustomSnackBar("Only ${product.stock} mars bar available");
    }
  }

  void removeFromBasket(String id) {
    productRepository.removeProductFromBasket(id);
    update();
    Get.find<CheckoutFragmentController>().populateOrders();
    Get.find<GlobalController>().updateTotalCost();
  }

  void browseProduct(ProductModel product) {
    searchFocusNode.unfocus();
    Get.toNamed(Routes.product,
        preventDuplicates: true, arguments: product.toJson());
  }

  void clearSearch() {
    searchedProducts.clear();
    searchTextController.text = "";
    update();
  }

  void onAppBarBackPressed() {
    switch (pageMode) {
      case "search":
        clearSearch();
        searchFocusNode.unfocus();
        searchMode = false;
        pageMode = lastPage;
        if (lastPage == "category") {
          mainController.backBtnVisibility = false;
        }
        break;
      case "subcategory":
        pageMode = "category";
        searchTextController.text = "";
        mainController.backBtnVisibility = false;
        break;
      case "subcategory_products":
        pageMode = "subcategory";
        searchTextController.text = "";
        selectedSubcategory = -1;
        products.clear();
        page = 1;
        requestPermitted = false;
        pagginationStatus = AppStatus.done;
        break;
      default:
        SystemNavigator.pop();
        break;
    }
    update();
  }

  void populateData(int index) {
    subCategories =
        _globalController.initialDataModel.categories![index].subCategories!;
  }

  void onSubcategoryItemClickHandler(int categoryIndex) {
    if (categoryIndex == selectedSubcategory) {
      selectedSubcategory = -1;
      lastPage = pageMode;
      pageMode = "subcategory";
      products.clear();
      page = 1;
      pagginationStatus = AppStatus.done;
    } else {
      selectedSubcategory = categoryIndex;
      lastPage = pageMode;
      pageMode = "subcategory_products";
      requestPermitted = true;
      productStatus = AppStatus.loading;
      requestProducts();
    }
    update();
  }

  void requestProducts() {
    if (requestPermitted) {
      productRepository
          .getProductsBySubCategoryId(
              subCategories[selectedSubcategory].id!, "", page)
          .then((value) => value.fold(
              (l) => attemptFailed(l), (r) => productsAttemptSucceed(r)));
    }
  }

  void productsAttemptSucceed(List<ProductModel> productList) {
    if (products.isEmpty && productList.isNotEmpty) {
      productStatus = AppStatus.done;
    }

    if (productList.length < 10) {
      pagginationStatus = AppStatus.done;
      requestPermitted = false;
      if (productList.isNotEmpty) {
        final previousProducts = List<ProductModel>.from(products);
        previousProducts.addAll(productList);
        products = previousProducts;
      } else {
        if (products.isEmpty) {
          productStatus = AppStatus.nothingFound;
        }
      }
    } else {
      final previousProducts = List<ProductModel>.from(products);
      previousProducts.addAll(productList);
      products = previousProducts;
    }
    update();
  }
}
