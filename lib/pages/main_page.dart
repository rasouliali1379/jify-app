import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/fragments/account_fragment.dart';
import 'package:jify_app/fragments/checkout_fragment.dart';
import 'package:jify_app/fragments/home_fragment.dart';
import 'package:jify_app/fragments/orders_fragment.dart';
import 'package:jify_app/widgets/custom_bottom_nav.dart';

class MainPage extends GetView<MainPageController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.blue,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: AppColors.white,
        systemNavigationBarColor: AppColors.white));
    return WillPopScope(
      onWillPop: controller.onBackPressedHandler,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    HomeFragment(),
                    AccountFragment(),
                    OrdersFragment(),
                    CheckoutFragment()
                  ],
                ),
              ),
              Obx(() => CustomBottomNav(
                  controller.index, controller.onBottomNavClickHandler))
            ],
          )),
    );
  }
}
