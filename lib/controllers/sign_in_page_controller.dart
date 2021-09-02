import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/repositories/user_repository.dart';
import 'package:jify_app/utilities/utilities.dart';

class SignInPageController extends GetxController {
  final mobileTextController = TextEditingController();
  final _userRepository = UserRepository();

  final _phoneNumberError = "".obs;

  final _loadingStatus = false.obs;

  bool get loadingStatus => _loadingStatus.value;

  set loadingStatus(bool value) {
    _loadingStatus.value = value;
  }

  String get phoneNumberError => _phoneNumberError.value;

  set phoneNumberError(String value) {
    _phoneNumberError.value = value;
  }

  void signInButtonClickHandler() {
    if (mobileTextController.text.isNotEmpty) {
      phoneNumberError = "";
    } else {
      phoneNumberError = "You need to enter your phone number";
      return;
    }
    if (mobileTextController.text.isPhoneNumber) {
      phoneNumberError = "";
    } else {
      phoneNumberError = "You need to enter a valid phone number";
      return;
    }
    loadingStatus = true;
    _userRepository.singInWithPhoneNumber(mobileTextController.text).then(
        (value) => value.fold(
            (l) => attemptFailed(l), (r) => attemptSucceed(codeSent: r)));
  }

  void attemptFailed(String message) {
    loadingStatus = false;
    showCustomSnackBar(message);
  }

  void attemptSucceed({bool codeSent = false}) {
    loadingStatus = false;

    if (codeSent) {
      Get.toNamed(Routes.phoneVerification,
          parameters: {"phone_number": mobileTextController.text});
    }
  }
}
