import 'package:get/get.dart';

class SchedulePageController extends GetxController {
  final _selectedTime = 0.obs;

  int get selectedTime => _selectedTime.value;

  set selectedTime(int value) {
    _selectedTime.value = value;
  }

  Function() onScheduleClickHandler(int index) {
    return () {
      selectedTime = index;
      update();
    };
  }
}
