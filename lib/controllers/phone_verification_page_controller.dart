import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/controllers/account_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/models/user_model.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/repositories/user_repository.dart';
import 'package:jify_app/utilities/storage.dart';
import 'package:jify_app/utilities/utilities.dart';

class PhoneVerificationPageController extends GetxController {
  final globalController = Get.find<GlobalController>();
  final _userRepository = UserRepository();
  late CountdownTimerController countdownController;
  final pinCodeFieldFocus = FocusNode();
  final _resendStatus = "countdown".obs;
  final _phoneNumber = "".obs;

  @override
  void onInit() {
    final endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    countdownController =
        CountdownTimerController(endTime: endTime, onEnd: onCountdownFinished);
    phoneNumber = Get.parameters["phone_number"]!;
    super.onInit();
  }

  @override
  void onReady() {
    pinCodeFieldFocus.requestFocus();
    super.onReady();
  }

  String get resendStatus => _resendStatus.value;

  set resendStatus(String value) {
    _resendStatus.value = value;
  }

  String get phoneNumber => _phoneNumber.value;

  set phoneNumber(String value) {
    _phoneNumber.value = value;
  }

  void onCountdownFinished() {
    countdownController.disposeTimer();
    resendStatus = "resend";
  }

  void resendCode() {
    resendStatus = "loading";
    final phoneNumber = Get.parameters["phone_number"];
    _userRepository.singInWithPhoneNumber(phoneNumber!).then((value) {
      value.fold((l) {
        resendStatus = "try_again";
        attemptFailed(l);
      }, (r) {
        Utilities.makeCustomToast('Code has been sent again');
        final endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
        countdownController = CountdownTimerController(
            endTime: endTime, onEnd: onCountdownFinished);
        resendStatus = "countdown";
      });
    });
  }

  void onPinCodeCompleteHandler(String code) {
    final phoneNumber = Get.parameters["phone_number"];
    _userRepository.validateCode(phoneNumber!, code).then((value) =>
        value.fold((l) => attemptFailed(l), (r) => attemptSucceed(r)));
  }

  void attemptFailed(String message) {
    Utilities.makeCustomToast(message);
  }

  void attemptSucceed(Map<String, dynamic> loginData) {
    final token = loginData["token"] as String;
    if (token.isNotEmpty) {
      storageWrite(AppKeys.token, token).then((_) {
        final userData =
            UserModel.fromJson(loginData["user"] as Map<String, dynamic>);
        Get.find<AccountFragmentController>().checkLoginStatus();
        globalController.initialDataModel.user = userData;
        if (userData.firstname == null && userData.lastname == null) {
          Get.offNamed(Routes.signUp);
        } else {
          Utilities.makeCustomToast(
              "You're successfully signed in."
              " Welcome ${userData.firstname}",
              length: Toast.LENGTH_LONG);
          Get.back();
        }
      });
    }
  }

  @override
  void onClose() {
    countdownController.dispose();
    super.onClose();
  }
}
