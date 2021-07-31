import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';

class PhoneVerificationPageController extends GetxController {
  late CountdownTimerController countdownController;
  final _resendAvailable = false.obs;

  @override
  void onInit() {
    final endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    countdownController =
        CountdownTimerController(endTime: endTime, onEnd: onCountdownFinished);
    super.onInit();
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
