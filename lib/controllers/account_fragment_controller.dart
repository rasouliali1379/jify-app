import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/orders_fragment_controller.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/utilities/storage.dart';
import 'package:jify_app/utilities/utilities.dart';

class AccountFragmentController extends GetxController {
  final globalController = Get.find<GlobalController>();
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
    if (loggedIn) {
      Get.toNamed(Routes.accountInformation);
    } else {
      Utilities.makeCustomToast('You need to sign in/up first');
    }
  }

  void openHelpCenter() {
    Get.toNamed(Routes.helpCenter);
  }

  void openPrivacyAndTerms() {}

  void openTermsAndConditions() {}

  void logout() {
    storageRemove(AppKeys.token).then((value) {
      globalController.initialDataModel.user = null;
      final ordersController = Get.find<OrdersFragmentController>();
      ordersController.ordersList.clear();
      ordersController.previousOrdersList.clear();
      ordersController.checkUserLogStatus();
      Get.find<CheckoutFragmentController>().populateOrders();
      checkLoginStatus();
    });
  }

  void login() {
    Get.toNamed(Routes.signIn);
  }

  void checkLoginStatus() {
    loggedIn = storageExists(AppKeys.token);
  }
}
