import 'package:get/get.dart';
import 'package:jify_app/navigation/routes.dart';

class AccountFragmentController extends GetxController {
  void openAccountInformation() {
    Get.toNamed(Routes.accountInformation);
  }

  void openHelpCenter() {
    Get.toNamed(Routes.helpCenter);
  }

  void openPrivacyAndTerms() {}

  void openTermsAndConditions() {}

  void logout() {}
}
