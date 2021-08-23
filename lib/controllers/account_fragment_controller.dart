import 'package:get/get.dart';
import 'package:jify_app/constants/app_keys.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/global_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/controllers/orders_fragment_controller.dart';
import 'package:jify_app/modals/custom_alert_dialog.dart';
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
      makeCustomToast('You need to sign in/up first');
    }
  }

  void openHelpCenter() {
    Get.toNamed(Routes.helpCenter);
  }

  void openPrivacyAndTerms() {}

  void openTermsAndConditions() {}

  void openLogoutModal() {
    Get.bottomSheet(
      CustomAlertDialog(
          "Log Out from Jify",
          "Are you sure you would like to log out of your Jify account?",
          "Logout",
          "Cancel",
          logout,
          closeModal),
      enableDrag: false,
    );
  }

  void closeModal() {
    Get.back();
  }

  void logout() {
    storageDelete().then(
        (value) => storageWrite(AppKeys.firstTimeLaunch, true).then((value) {
              globalController.initialDataModel.user = null;
              globalController.basket.clear();
              final ordersController = Get.find<OrdersFragmentController>();
              ordersController.ordersList.clear();
              ordersController.previousOrdersList.clear();
              ordersController.checkUserLogStatus();
              // Get.find<CheckoutFragmentController>().checkSelectedAddress();
              Get.find<CheckoutFragmentController>().populateOrders();
              final mainController = Get.find<MainPageController>();
              mainController.onBottomNavClickHandler(0);
              Get.back();
              checkLoginStatus();
              mainController.openDeliveryAddressModal();
            }));
  }

  void login() {
    Get.toNamed(Routes.signIn);
  }

  void checkLoginStatus() {
    loggedIn = storageExists(AppKeys.token);
  }
}
