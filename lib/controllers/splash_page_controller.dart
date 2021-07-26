import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/utilities/storage.dart';

class SplashPageController extends GetxController {
  @override
  void onReady() {
    startTimer();
    super.onReady();
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 3)).then((value) => leavePage());
  }

  Future<void> leavePage() async {
    String route = Routes.MAIN;
    final firstTimeKeyExist = Storage.exists(AppKeys.firstTimeLaunch);

    if (!firstTimeKeyExist) {
      route = Routes.INTRO;
    }

    Get.offNamed(route);
  }
}
