import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/constants/app_status.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/models/address_model.dart';
import 'package:jify_app/models/banner_model.dart';
import 'package:jify_app/models/category_model.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/repositories/address_repository.dart';
import 'package:jify_app/repositories/product_repository.dart';
import 'package:jify_app/utilities/storage.dart';
import 'package:jify_app/utilities/utilities.dart';

class HomeFragmentController extends GetxController {
  final mainController = Get.find<MainPageController>();
  final _globalController = Get.find<GlobalController>();
  final scrollController = ScrollController();
  final productRepository = ProductRepository();
  final addressRepository = AddressRepository();
  final searchTextController = TextEditingController();
  final searchFocusNode = FocusNode();

  final _selectedSubcategory = (-1).obs;
  final _subCategories = <CategoryModel>[].obs;
  final _searchedProducts = <ProductModel>[].obs;
  final _products = <ProductModel>[].obs;
  final _pageMode = "category".obs;
  final _searchLoading = false.obs;
  final _productStatus = (AppStatus.loading).obs;
  final _carouselIndex = 0.0.obs;

  late List<CategoryModel> categoryItems;
  late List<BannerModel> banners;
  String selectedCategoryId = "";
  String lastPage = "category";
  bool searchMode = false;

  @override
  void onInit() {
    banners = _globalController.initialDataModel.banners!;
    categoryItems = _globalController.initialDataModel.categories!;
    super.onInit();
  }

  double get carouselIndex => _carouselIndex.value;

  set carouselIndex(double value) {
    _carouselIndex.value = value;
  }

  String get productStatus => _productStatus.value;

  set productStatus(String value) {
    _productStatus.value = value;
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

  List<CategoryModel> get subCategories => _subCategories.value;

  set subCategories(List<CategoryModel> value) {
    _subCategories.value = value;
  }

  int get selectedSubcategory => _selectedSubcategory.value;

  set selectedSubcategory(int value) {
    _selectedSubcategory.value = value;
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
      pageMode = "category";
    }
    update();
  }

  void attemptFailed(String message) {
    searchLoading = false;
    showCustomSnackBar(message);
  }

  void attemptSucceed(List<ProductModel> products) {
    searchLoading = false;
    searchedProducts = products;
    update();
  }

  void addProduct(ProductModel product) {
    addProductToBasket(product);
    final countInBasket = productRepository.countInBasket(product.id!);
    showCustomSnackBar(
        "$countInBasket ${countInBasket > 1 ? 'items' : 'item'} added to basket",
        duration: 1);
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
      showCustomSnackBar("Only ${product.stock} ${product.title} available");
    }
    vibrateWithDuration(50);
  }

  void removeFromBasket(String id) {
    productRepository.removeProductFromBasket(id);
    update();
    Get.find<CheckoutFragmentController>().populateOrders();
    Get.find<GlobalController>().updateTotalCost();
    vibrateWithDuration(50);
  }

  void browseProduct(ProductModel product) {
    if (product.stock! > 0) {
      searchFocusNode.unfocus();
      Get.toNamed(Routes.product,
          preventDuplicates: true, arguments: product.toJson());
    }
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
    } else {
      selectedSubcategory = categoryIndex;
      lastPage = pageMode;
      pageMode = "subcategory_products";
      productStatus = AppStatus.loading;
      requestProducts();
    }
    update();
  }

  void requestProducts() {
    productRepository
        .getProductsBySubCategoryId(
            subCategories[selectedSubcategory].id!, "", 1)
        .then((value) => value.fold(
            (l) => attemptFailed(l), (r) => productsAttemptSucceed(r)));
  }

  void productsAttemptSucceed(List<ProductModel> productList) {
    if (productList.isNotEmpty) {
      products = productList;
      productStatus = AppStatus.done;
    } else {
      productStatus = AppStatus.nothingFound;
    }
    update();
  }

  void onCarouselChangeHandler(int index, CarouselPageChangedReason reason) {
    carouselIndex = index.toDouble();
  }

  void carouselButtonClickHandler(String destination, String object) {
    switch (destination) {
      case "/category":
        onCategoryItemClickHandler(findCategoryIndex(object));
        break;
      case "/subcategory":
        onCategoryItemClickHandler(findCategorySubcategoryIndex(object));
        onSubcategoryItemClickHandler(findSubcategoryIndex(object));
        break;
      case "/product":
        final foundProduct = findProduct(object);
        if (foundProduct != null) {
          browseProduct(foundProduct);
        } else {
          showCustomSnackBar("Couldn't find the product!");
        }
        break;
    }
  }

  int findCategoryIndex(String id) {
    for (int i = 0; i < categoryItems.length; i++) {
      if (categoryItems[i].id == id) {
        return i;
      }
    }
    return 0;
  }

  int findSubcategoryIndex(String id) {
    for (int i = 0; i < subCategories.length; i++) {
      if (subCategories[i].id == id) {
        return i;
      }
    }
    return 0;
  }

  int findCategorySubcategoryIndex(String id) {
    for (int i = 0; i < categoryItems.length; i++) {
      final subs = categoryItems[i].subCategories;
      for (int j = 0; j < subs!.length; j++) {
        if (subs[j].id == id) {
          return i;
        }
      }
    }
    return 0;
  }

  ProductModel? findProduct(String id) {
    for (int i = 0; i < categoryItems.length; i++) {
      final subs = categoryItems[i].subCategories;
      for (int j = 0; j < subs!.length; j++) {
        final goods = subs[j].products;
        for (int k = 0; j < goods!.length; k++) {
          if (goods[k].id == id) {
            return goods[k];
          }
        }
      }
    }
    return null;
  }

  String getDeliveryAddress() {
    if (_globalController.initialDataModel.user != null) {
      final address = addressRepository.findAddress(
          _globalController.initialDataModel.user!.addresses!,
          storageRead(AppKeys.address) as String);
      if (address.address!.length > 30) {
        return '${address.address!.substring(0, 30)}...';
      }
      return address.address!;
    }

    final rawAddress = storageRead(AppKeys.unsavedAddress) as String;
    final addressModel = AddressModel.fromJson(jsonDecode(rawAddress));

    if (addressModel.address!.length > 30) {
      return '${addressModel.address!.substring(0, 30)}...';
    }

    return addressModel.address!;
  }
}
