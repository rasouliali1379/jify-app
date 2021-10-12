import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/home_fragment_controller.dart';
import 'package:jify_app/modals/choose_delivery_address_modal.dart';
import 'package:jify_app/modals/store_closed_modal.dart';
import 'package:jify_app/models/product_model.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/repositories/address_repository.dart';
import 'package:jify_app/utilities/storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MainPageController extends GetxController {
  final _globalController = Get.find<GlobalController>();
  final _index = 0.obs;
  final _backBtnVisibility = false.obs;
  final _signInVisibility = false.obs;
  final pageController = PageController();
  final _addressRepository = AddressRepository();
  final pageStack = <int>[0];
  int selectedCategory = -1;

  @override
  void onReady() {
    if (!_globalController.initialDataModel.isOpen!) {
      Get.bottomSheet(StoreClosedModal());
      return;
    }
    checkInitialAddress();
    super.onReady();
  }

  bool get signInVisibility => _signInVisibility.value;

  set signInVisibility(bool value) {
    _signInVisibility.value = value;
  }

  bool get backBtnVisibility => _backBtnVisibility.value;

  set backBtnVisibility(bool value) {
    _backBtnVisibility.value = value;
  }

  int get index => _index.value;

  set index(int value) {
    _index.value = value;
  }

  void onBottomNavClickHandler(int index) {
    final _homeFragmentController = Get.find<HomeFragmentController>();

    _homeFragmentController.lastPage = "category";
    _homeFragmentController.searchMode = false;
    _homeFragmentController.searchTextController.text = "";
    _homeFragmentController.pageMode = "category";
    _homeFragmentController.searchLoading = false;
    _homeFragmentController.selectedSubcategory = -1;
    _homeFragmentController.searchedProducts.clear();
    backBtnVisibility = false;
    _homeFragmentController.update();

    if (pageStack.last != index) {
      if (index == 3 && !storageExists(AppKeys.token)) {
        Get.toNamed(Routes.signIn, preventDuplicates: true);
      } else {
        if (_globalController.initialDataModel.isOpen!) {
          // if (Get.find<GlobalController>().basket.isNotEmpty) {
          //   pageStack.add(index);
          //   pageController.jumpToPage(index);
          // }
          this.index = index;
          pageStack.add(index);
          pageController.jumpToPage(index);
        } else {
          showMaterialModalBottomSheet(
            context: Get.context!,
            builder: (context) => StoreClosedModal(),
          );
          // Get.bottomSheet(StoreClosedModal());
        }
      }
    }
  }

  void openDeliveryAddressModal() {
    showMaterialModalBottomSheet(
        context: Get.context!,
        builder: (context) => ChooseDeliveryAddressModal(),
        enableDrag: false,
        isDismissible: false);
    // Get.bottomSheet(ChooseDeliveryAddressModal(),
    //     isDismissible: false, enableDrag: false, ignoreSafeArea: true);
  }

  void openAddressesPage() {
    if (storageExists(AppKeys.token)) {
      Get.toNamed(Routes.addresses);
    } else {
      storageRemove(AppKeys.unsavedAddress);
      Get.toNamed(Routes.deliveryAddresses);
    }
  }

  Future<bool> onBackPressedHandler() {
    final _homeController = Get.find<HomeFragmentController>();
    if (index == 0 && _homeController.pageMode != "category") {
      _homeController.onAppBarBackPressed();
    } else {
      if (pageStack.length == 1) {
        _globalController.exitApp();
      } else {
        pageStack.removeLast();
        if (pageStack.last >= 0 && pageStack.last <= 2) {
          index = pageStack.last;
          backBtnVisibility = false;
        }
        pageController.jumpToPage(pageStack.last);

        final pageStackCopy = List<int>.from(pageStack.reversed.toList());

        for (int i = 0; i < pageStackCopy.length; i++) {
          if (pageStackCopy[i] >= 0 && pageStackCopy[i] <= 2) {
            index = pageStackCopy[i];
            break;
          }
        }
      }
    }

    return Future.value(false);
  }

  void checkInitialAddress() {
    signInVisibility = !storageExists(AppKeys.token);
    if (!storageExists(AppKeys.token)) {
      if (!storageExists(AppKeys.unsavedAddress)) {
        openDeliveryAddressModal();
      }
    } else {
      if (_globalController.initialDataModel.user!.addresses!.isEmpty) {
        openDeliveryAddressModal();
      } else {
        final address = _addressRepository.findAddress(
            _globalController.initialDataModel.user!.addresses!, storageRead(AppKeys.address) as String);

        _globalController.isAddressInRange = address.distance! <= _globalController.initialDataModel.supportedDistance!;
      }
    }
  }

  void openSignInPage() {
    Get.offNamed(Routes.signIn)!.then((value) {
      if (value != null) {
        if (value as bool) {
          checkInitialAddress();
        }
      }
    });
  }

  void addNewAddressClickHandler() {
    Navigator.of(Get.context!).popAndPushNamed(Routes.deliveryAddresses).then((value) {
      if (value != null) {
        if (value as bool) {
          checkInitialAddress();
        }
      }
    });
  }

  Future<bool> onBackButtonPressed() {
    _globalController.exitApp();
    return Future.value(false);
  }

  @override
  void onInit() {
    loadBasket();
    super.onInit();
  }

  void loadBasket() {
    if (storageExists(AppKeys.orders)) {
      final stringBasket = storageRead(AppKeys.orders) as String;
      final jsonBasket = jsonDecode(stringBasket) as List<dynamic>;
      final products = List<ProductModel>.from(jsonBasket.map((model) => ProductModel.fromJson(model)));
      _globalController.basket.assignAll(products);
      _globalController.updateTotalCost();
    }
  }
}
