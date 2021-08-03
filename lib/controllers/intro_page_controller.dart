import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/utilities/storage.dart';

class IntroPageController extends GetxController
    with SingleGetTickerProviderMixin {
  final pageController = PageController();
  final _slideIndex = 0.0.obs;

  double get slideIndex => _slideIndex.value;

  set slideIndex(double value) {
    _slideIndex.value = value;
  }

  void slideChangeHandler(int index) {
    slideIndex = index.toDouble();
  }

  Future<bool> onBackPressedHandler() {
    Get.offNamed(Routes.main);
    return Future.value(false);
  }

  void nextPage() {
    pageController.animateTo(200,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  Future<void> getStarted() async {
    await storageWrite(AppKeys.firstTimeLaunch, false);
    Get.offNamed(Routes.main);
  }
}
