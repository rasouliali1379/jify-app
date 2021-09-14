import 'package:get/get.dart';
import 'package:jify_app/bindings/main_page_bindings.dart';
import 'package:jify_app/controllers/account_information_page_controller.dart';
import 'package:jify_app/controllers/addresses_page_controller.dart';
import 'package:jify_app/controllers/confirmation_page_controller.dart';
import 'package:jify_app/controllers/delivery_addresses_controller.dart';
import 'package:jify_app/controllers/help_center_page_controller.dart';
import 'package:jify_app/controllers/intro_page_controller.dart';
import 'package:jify_app/controllers/order_info_controller.dart';
import 'package:jify_app/controllers/orders_fragment_controller.dart';
import 'package:jify_app/controllers/phone_verification_page_controller.dart';
import 'package:jify_app/controllers/product_page_controller.dart';
import 'package:jify_app/controllers/schedule_page_controller.dart';
import 'package:jify_app/controllers/search_address_page_controller.dart';
import 'package:jify_app/controllers/sign_in_page_controller.dart';
import 'package:jify_app/controllers/sign_up_page_controller.dart';
import 'package:jify_app/controllers/splash_page_controller.dart';
import 'package:jify_app/controllers/store_unavailable_page_controller.dart';
import 'package:jify_app/pages/account_information_page.dart';
import 'package:jify_app/pages/addresses_page.dart';
import 'package:jify_app/pages/confirmation_page.dart';
import 'package:jify_app/pages/delivery_addresses_page.dart';
import 'package:jify_app/pages/help_center_page.dart';
import 'package:jify_app/pages/intro_page.dart';
import 'package:jify_app/pages/main_page.dart';
import 'package:jify_app/pages/order_info_page.dart';
import 'package:jify_app/fragments/orders_fragment.dart';
import 'package:jify_app/pages/phone_verification_page.dart';
import 'package:jify_app/pages/product_page.dart';
import 'package:jify_app/pages/schedule_page.dart';
import 'package:jify_app/pages/search_address_page.dart';
import 'package:jify_app/pages/sign_in_page.dart';
import 'package:jify_app/pages/sign_up_page.dart';
import 'package:jify_app/pages/splash_page.dart';
import 'package:jify_app/pages/store_unavailable_page.dart';

import 'routes.dart';

class Pages {
  static final routes = [
    GetPage(name: Routes.main, page: () => MainPage(), binding: MainPageBinding()),
    GetPage(
        name: Routes.accountInformation,
        page: () => AccountInformationPage(),
        binding: BindingsBuilder(() => {Get.put(AccountInformationPageController())})),
    GetPage(
        name: Routes.addresses,
        page: () => AddressesPage(),
        binding: BindingsBuilder(() => {Get.put(AddressesPageController())})),
    GetPage(
        name: Routes.confirmation,
        page: () => ConfirmationPage(),
        binding: BindingsBuilder(() => {Get.put(ConfirmationPageController())})),
    GetPage(
        name: Routes.deliveryAddresses,
        page: () => DeliveryAddressesPage(),
        binding: BindingsBuilder(() => {Get.put(DeliveryAddressesPageController())})),
    GetPage(
        name: Routes.intro, page: () => IntroPage(), binding: BindingsBuilder(() => {Get.put(IntroPageController())})),
    GetPage(
        name: Routes.orderInfo,
        page: () => OrderInfoPage(),
        binding: BindingsBuilder(() => {Get.put(OrderInfoPageController())})),
    GetPage(
        name: Routes.orders,
        page: () => OrdersFragment(),
        binding: BindingsBuilder(() => {Get.put(OrdersFragmentController())})),
    GetPage(
        name: Routes.phoneVerification,
        page: () => PhoneVerificationPage(),
        binding: BindingsBuilder(() => {Get.put(PhoneVerificationPageController())})),
    GetPage(
        name: Routes.product,
        page: () => ProductPage(),
        binding: BindingsBuilder(() => {Get.put(ProductPageController())})),
    GetPage(
        name: Routes.schedule,
        page: () => SchedulePage(),
        binding: BindingsBuilder(() => {Get.put(SchedulePageController())})),
    GetPage(
        name: Routes.signIn,
        page: () => SignInPage(),
        binding: BindingsBuilder(() => {Get.put(SignInPageController())})),
    GetPage(
        name: Routes.signUp,
        page: () => SignUpPage(),
        binding: BindingsBuilder(() => {Get.put(SignUpPageController())})),
    GetPage(
        name: Routes.splash,
        page: () => SplashPage(),
        binding: BindingsBuilder(() => {Get.put(SplashPageController())})),
    GetPage(
        name: Routes.helpCenter,
        page: () => HelpCenterPage(),
        binding: BindingsBuilder(() => {Get.put(HelpCenterPageController())})),
    GetPage(
        name: Routes.searchAddress,
        page: () => SearchAddressPage(),
        binding: BindingsBuilder(() => {Get.put(SearchAddressPageController())})),
    GetPage(
        name: Routes.storeUnavailable,
        page: () => StoreUnavailablePage(),
        binding: BindingsBuilder(() => {Get.put(StoreUnavailablePageController())})),
  ];
}
