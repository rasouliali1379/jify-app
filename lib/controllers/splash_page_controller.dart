import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/repositories/app_repository.dart';
import 'package:jify_app/utilities/storage.dart';
import 'package:jify_app/utilities/utilities.dart';

class SplashPageController extends GetxController {
  final _appRepository = AppRepository();
  final _globalController = Get.find<GlobalController>();

  @override
  void onReady() {
    // startTimer();
    initApp();
    super.onReady();
  }

  void initApp() {
    _appRepository.getInitialData().then((value) {
      value.fold((l) => Utilities.makeCustomToast(l),
          (r) => print(r));
      leavePage();
    });
  }

  void startTimer() {
    Future.delayed(const Duration(seconds: 3)).then((value) => leavePage());
  }

  Future<void> leavePage() async {
    String route = Routes.main;
    final firstTimeKeyExist = storageExists(AppKeys.firstTimeLaunch);

    if (!firstTimeKeyExist) {
      route = Routes.intro;
    }

    Get.offNamed(route);
  }
}
