import 'dart:async';

import 'package:get/get.dart';

class PhoneVerificationPageController extends GetxController {
  final _time = <int>[2, 0].obs;

  Timer? _timer;

  final _resendAvailable = false.obs;

  List<int> get time => _time.value;

  set time(List<int> value) {
    _time.value = value;
  }

  bool get resendAvailable => _resendAvailable.value;

  set resendAvailable(bool value) {
    _resendAvailable.value = value;
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      time[1]--;
      if (time[1] < 0 && time[0] > 0) {
        time[1] = 59;
        time[0]--;
      } else {
        _timer!.cancel();
      }
    });
  }
}
