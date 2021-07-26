import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/controllers/main_page_controller.dart';
import 'package:jify_app/fragments/account_fragment.dart';
import 'package:jify_app/fragments/home_fragment.dart';
import 'package:jify_app/pages/orders_page.dart';
import 'package:jify_app/widgets/custom_bottom_nav.dart';
import 'package:jify_app/widgets/custom_app_bar.dart';

class MainPage extends GetView<MainPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [HomeFragment(), AccountFragment(), OrdersPage()],
              ),
            ),
            Obx(() => CustomBottomNav(controller.index, controller.onBottomNavClickHandle))
          ],
        ));
  }
}
