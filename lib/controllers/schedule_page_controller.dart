import 'package:get/get.dart';

class SchedulePageController extends GetxController {
  final _selectedTime = 0.obs;
  final _selectedDay = 0.obs;

  final days = ["Saturday", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

  int get selectedDay => _selectedDay.value;

  set selectedDay(int value) {
    _selectedDay.value = value;
  }

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

  void onSelectClickHandler() {
    Get.back(result: "${days[selectedDay]} / ${getTime(selectedTime)}");
  }

  String getTime(int index) {
    switch (index) {
      case 0:
        return "5pm";
      case 1:
        return "6pm";
      case 2:
        return "7pm";
    }

    return "8pm";
  }

  void previousDay() {
    if (selectedDay == 0) {
      selectedDay = 6;
    } else {
      selectedDay = selectedDay - 1;
    }
  }

  void nexDay() {
    if (selectedDay == 6) {
      selectedDay = 0;
    } else {
      selectedDay = selectedDay + 1;
    }
  }
}
