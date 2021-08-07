import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';

class PhoneVerificationPageController extends GetxController {
  late CountdownTimerController countdownController;
  final pinCodeFieldFocus = FocusNode();
  final _resendAvailable = false.obs;
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

  String get phoneNumber => _phoneNumber.value;

  set phoneNumber(String value) {
    _phoneNumber.value = value;
  }

  bool get resendAvailable => _resendAvailable.value;

  set resendAvailable(bool value) {
    _resendAvailable.value = value;
  }

  void onCountdownFinished() {
    countdownController.disposeTimer();
    resendAvailable = true;
  }

  void resendCode() {
    final endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    countdownController =
        CountdownTimerController(endTime: endTime, onEnd: onCountdownFinished);
    resendAvailable = false;
  }

  @override
  void onClose() {
    countdownController.dispose();
    super.onClose();
  }
}
