import 'package:get/get.dart';
import 'package:jify_app/bindings/main_page_bindings.dart';
import 'package:jify_app/controllers/account_information_page_controller.dart';
import 'package:jify_app/controllers/addresses_page_controller.dart';
import 'package:jify_app/controllers/checkout_page_controller.dart';
import 'package:jify_app/controllers/confirmation_page_controller.dart';
import 'package:jify_app/controllers/delivery_addresses_controller.dart';
import 'package:jify_app/controllers/intro_page_controller.dart';
import 'package:jify_app/controllers/order_info_controller.dart';
import 'package:jify_app/controllers/orders_page_controller.dart';
import 'package:jify_app/controllers/phone_verification_page_controller.dart';
import 'package:jify_app/controllers/product_page_controller.dart';
import 'package:jify_app/controllers/schedule_page_controller.dart';
import 'package:jify_app/controllers/sign_in_page_controller.dart';
import 'package:jify_app/controllers/sign_up_page_controller.dart';
import 'package:jify_app/controllers/splash_page_controller.dart';
import 'package:jify_app/pages/account_information_page.dart';
import 'package:jify_app/pages/addresses_page.dart';
import 'package:jify_app/pages/checkout_page.dart';
import 'package:jify_app/pages/confirmation_page.dart';
import 'package:jify_app/pages/delivery_addresses_page.dart';
import 'package:jify_app/pages/intro_page.dart';
import 'package:jify_app/pages/main_page.dart';
import 'package:jify_app/pages/order_info.page.dart';
import 'package:jify_app/pages/orders_page.dart';
import 'package:jify_app/pages/phone_verification_page.dart';
import 'package:jify_app/pages/product_page.dart';
import 'package:jify_app/pages/schedule_page.dart';
import 'package:jify_app/pages/sign_in_page.dart';
import 'package:jify_app/pages/sign_up_page.dart';
import 'package:jify_app/pages/splash_page.dart';

import 'routes.dart';

class Pages {
  static final routes = [
    GetPage(
        name: Routes.MAIN, page: () => MainPage(), binding: MainPageBinding()),
    GetPage(
        name: Routes.ACCOUNT_INFORMATION,
        page: () => AccountInformationPage(),
        binding: BindingsBuilder(
            () => {Get.put(AccountInformationPageController())})),
    GetPage(
        name: Routes.ADDRESSES,
        page: () => AddressesPage(),
        binding: BindingsBuilder(() => {Get.put(AddressesPageController())})),
    GetPage(
        name: Routes.CHECKOUT,
        page: () => CheckoutPage(),
        binding: BindingsBuilder(() => {Get.put(CheckoutPageController())})),
    GetPage(
        name: Routes.CONFIRMATION,
        page: () => ConfirmationPage(),
        binding:
            BindingsBuilder(() => {Get.put(ConfirmationPageController())})),
    GetPage(
        name: Routes.DELIVERY_ADDRESSES,
        page: () => DeliveryAddressesPage(),
        binding: BindingsBuilder(
            () => {Get.put(DeliveryAddressesPageController())})),
    GetPage(
        name: Routes.INTRO,
        page: () => IntroPage(),
        binding: BindingsBuilder(() => {Get.put(IntroPageController())})),
    GetPage(
        name: Routes.ORDER_INFO,
        page: () => OrderInfoPage(),
        binding: BindingsBuilder(() => {Get.put(OrderInfoPageController())})),
    GetPage(
        name: Routes.ORDERS,
        page: () => OrdersPage(),
        binding: BindingsBuilder(() => {Get.put(OrdersPageController())})),
    GetPage(
        name: Routes.PHONE_VERIFICATION,
        page: () => PhoneVerificationPage(),
        binding: BindingsBuilder(
            () => {Get.put(PhoneVerificationPageController())})),
    GetPage(
        name: Routes.PRODUCT,
        page: () => ProductPage(),
        binding: BindingsBuilder(() => {Get.put(ProductPageController())})),
    GetPage(
        name: Routes.SCHEDULE,
        page: () => SchedulePage(),
        binding: BindingsBuilder(() => {Get.put(SchedulePageController())})),
    GetPage(
        name: Routes.SIGN_IN,
        page: () => SignInPage(),
        binding: BindingsBuilder(() => {Get.put(SignInPageController())})),
    GetPage(
        name: Routes.SIGN_UP,
        page: () => SignUpPage(),
        binding: BindingsBuilder(() => {Get.put(SignUpPageController())})),
    GetPage(
        name: Routes.SPLASH,
        page: () => SplashPage(),
        binding: BindingsBuilder(() => {Get.put(SplashPageController())})),
  ];
}
