import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/utilities/storage.dart';

class AccountFragmentController extends GetxController {
  final _loggedIn = false.obs;

  @override
  void onInit() {
    checkLoginStatus();
    super.onInit();
  }

  bool get loggedIn => _loggedIn.value;

  set loggedIn(bool value) {
    _loggedIn.value = value;
  }

  void openAccountInformation() {
    Get.toNamed(Routes.accountInformation);
  }

  void openHelpCenter() {
    Get.toNamed(Routes.helpCenter);
  }

  void openPrivacyAndTerms() {}

  void openTermsAndConditions() {}

  void logout() {}

  void login() {
    Get.toNamed(Routes.signIn);
  }

  void checkLoginStatus() {
    loggedIn = storageExists(AppKeys.token);
  }
}
