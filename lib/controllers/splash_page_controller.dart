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

  final _tryAgainVisibility = false.obs;

  @override
  void onReady() {
    initApp();
    super.onReady();
  }

  bool get tryAgainVisibility => _tryAgainVisibility.value;

  set tryAgainVisibility(bool value) {
    _tryAgainVisibility.value = value;
  }

  void initApp() {
    tryAgainVisibility = false;
    _appRepository.getInitialData().then((value) {
      value.fold((l) {
        Utilities.makeCustomToast(l);
        tryAgainVisibility = true;
      }, (initialData) {
        _globalController.initialDataModel = initialData;
        Future.delayed(const Duration(seconds: 1)).then((value) => leavePage());
      });
    });
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
