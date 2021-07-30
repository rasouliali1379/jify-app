import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/utilities/utilities.dart';

class SignUpPageController extends GetxController {
  final nameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final mobileTextController = TextEditingController();
  final passTextController = TextEditingController();
  final confirmPassTextController = TextEditingController();

  final _termsCheck = false.obs;
  final _receiveOffersCheck = false.obs;

  bool get termsCheck => _termsCheck.value;

  set termsCheck(bool value) {
    _termsCheck.value = value;
  }

  bool get receiveOffersCheck => _receiveOffersCheck.value;

  set receiveOffersCheck(bool value) {
    _receiveOffersCheck.value = value;
  }

  void termsCheckHandler(bool value) {
    termsCheck = value;
  }

  void receiveOffersCheckHandler(bool value) {
    receiveOffersCheck = value;
  }

  void closePage() {
    Get.back();
  }

  void registerButtonClickHandler() {
    if (termsCheck) {
      Get.toNamed(Routes.phoneVerification);
    } else {
      Utilities.makeCustomToast('You need to agree to our terms and conditions',
          textColor: AppTextColors.white, bgColor: AppColors.red);
    }
  }

  @override
  void onClose() {
    nameTextController.dispose();
    lastNameTextController.dispose();
    emailTextController.dispose();
    mobileTextController.dispose();
    passTextController.dispose();
    confirmPassTextController.dispose();
    super.onClose();
  }
}
