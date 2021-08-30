import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/controllers/account_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/models/user_model.dart';
import 'package:jify_app/repositories/user_repository.dart';
import 'package:jify_app/utilities/utilities.dart';

class SignUpPageController extends GetxController {
  final globalController = Get.find<GlobalController>();
  final _userRepository = UserRepository();
  final nameTextController = TextEditingController();
  final lastNameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  // final mobileTextController = TextEditingController();
  // final passTextController = TextEditingController();
  // final confirmPassTextController = TextEditingController();

  final _termsCheck = false.obs;
  final _receiveOffersCheck = false.obs;
  final _loadingStatus = false.obs;
  final _phoneNumber = "".obs;
  final _nameError = "".obs;
  final _lastNameError = "".obs;
  final _emailError = "".obs;

  @override
  void onReady() {
    getUserData();
    super.onReady();
  }

  String get nameError => _nameError.value;

  set nameError(String value) {
    _nameError.value = value;
  }

  String get lastNameError => _lastNameError.value;

  set lastNameError(String value) {
    _lastNameError.value = value;
  }

  String get emailError => _emailError.value;

  set emailError(String value) {
    _emailError.value = value;
  }

  String get phoneNumber => _phoneNumber.value;

  set phoneNumber(String value) {
    _phoneNumber.value = value;
  }

  bool get termsCheck => _termsCheck.value;

  set termsCheck(bool value) {
    _termsCheck.value = value;
  }

  bool get receiveOffersCheck => _receiveOffersCheck.value;

  set receiveOffersCheck(bool value) {
    _receiveOffersCheck.value = value;
  }

  bool get loadingStatus => _loadingStatus.value;

  set loadingStatus(bool value) {
    _loadingStatus.value = value;
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
      if (nameTextController.text.isEmpty) {
        nameError = "You need to fill this Field";
        return;
      }
      nameError = "";

      if (lastNameTextController.text.isEmpty) {
        lastNameError = "You need to fill this Field";
        return;
      }
      lastNameError = "";

      if (emailTextController.text.isEmpty) {
        emailError = "You need to fill this Field";
        return;
      }

      if (!emailTextController.text.isEmail) {
        emailError = "You need to enter a valid email";
        return;
      }
      emailError = "";
      final userModel = globalController.initialDataModel.user;

      userModel!.firstname = nameTextController.text;
      userModel.lastname = lastNameTextController.text;
      userModel.email = emailTextController.text;

      loadingStatus = true;
      _userRepository.updateUser(userModel).then((value) =>
          value.fold((l) => attemptFailed(l), (r) => attemptSucceed(r)));
    } else {
      showCustomSnackBar('You need to agree to our terms and conditions',
          textColor: AppTextColors.white, bgColor: AppColors.red);
    }
  }

  void attemptFailed(String message) {
    loadingStatus = false;
    showCustomSnackBar(message);
  }

  void attemptSucceed(UserModel user) {
    loadingStatus = false;
    globalController.initialDataModel.user = user;
    showCustomSnackBar("You're successfully signed in. Welcome ${user.firstname}");
    Get.find<AccountFragmentController>().checkLoginStatus();
    Get.back();
  }

  @override
  void onClose() {
    nameTextController.dispose();
    lastNameTextController.dispose();
    emailTextController.dispose();
    // mobileTextController.dispose();
    // passTextController.dispose();
    // confirmPassTextController.dispose();
    super.onClose();
  }

  void getUserData() {
    final userInfo = globalController.initialDataModel.user;
    phoneNumber = userInfo!.mobileNumber!;
  }
}
