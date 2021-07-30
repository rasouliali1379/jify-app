import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/modals/choose_delivery_address_modal.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MainPageController extends GetxController {
  final _index = 0.obs;
  final _backBtnVisibility = false.obs;
  final pageController = PageController();
  final pageStack = <int>[0];

  bool get backBtnVisibility => _backBtnVisibility.value;

  set backBtnVisibility(bool value) {
    _backBtnVisibility.value = value;
  }

  int get index => _index.value;

  set index(int value) {
    _index.value = value;
  }

  onBottomNavClickHandler(int value) {
    if (pageStack.last != value) {
      index = value;
      pageStack.add(value);
      pageController.jumpToPage(index);
    }
  }

  void openDeliveryAddressModal() {
    showMaterialModalBottomSheet(
        builder: (BuildContext context) => ChooseDeliveryAddressModal(),
        context: Get.context!);
  }

  void openDeliveryAddressesPage() {
    Get.toNamed(Routes.signIn);
  }

  Future<bool> onBackPressedHandler() {
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
    return Future.value(false);
  }
}
