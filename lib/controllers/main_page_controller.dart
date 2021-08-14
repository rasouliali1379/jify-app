import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/home_fragment_controller.dart';
import 'package:jify_app/modals/choose_delivery_address_modal.dart';
import 'package:jify_app/modals/store_closed_modal.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/utilities/storage.dart';
import 'package:jify_app/utilities/utilities.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MainPageController extends GetxController {
  final _index = 0.obs;
  final _backBtnVisibility = false.obs;
  final pageController = PageController();
  final pageStack = <int>[0];

  int selectedCategory = -1;

  bool get backBtnVisibility => _backBtnVisibility.value;

  set backBtnVisibility(bool value) {
    _backBtnVisibility.value = value;
  }

  int get index => _index.value;

  set index(int value) {
    _index.value = value;
  }

  void onBottomNavClickHandler(int index) {
    if (pageStack.last != index) {
      if (index < 3) {
        this.index = index;
      }

      if (index == 3 && !storageExists(AppKeys.token)) {
        makeCustomToast("You need to sign in first");
      } else {
        if (Get.find<GlobalController>().initialDataModel.isOpen!) {
          pageStack.add(index);
          pageController.jumpToPage(index);
        } else {
          Get.bottomSheet(StoreClosedModal());
        }
      }
    }
  }

  void openDeliveryAddressModal() {
    Get.bottomSheet(ChooseDeliveryAddressModal(),
        isDismissible: false, enableDrag: false);
    Get.find<GlobalController>().isAddAddressModalOpen = true;
  }

  void openDeliveryAddressesPage() {
    Get.toNamed(Routes.deliveryAddresses);
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
    if (index == 0) {
      Get.find<HomeFragmentController>().onAppBarBackPressed();
    } else {
      if (pageStack.length == 1) {
        return Future.value(true);
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

  @override
  void onReady() {
    if (!Get.find<GlobalController>().initialDataModel.isOpen!) {
      Get.bottomSheet(StoreClosedModal());
      return;
    }

    if (!storageExists(AppKeys.token)) {
      if (storageExists(AppKeys.unsavedAddress)) {
      } else {
        openDeliveryAddressModal();
      }
    }
    super.onReady();
  }
}
