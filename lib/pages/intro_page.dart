import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/controllers/intro_page_controller.dart';
import 'package:jify_app/widgets/intro_slider_item.dart';

class IntroPage extends GetView<IntroPageController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onBackPressedHandler,
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.109,
              ),
              Expanded(
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: controller.pageController,
                  onPageChanged: controller.slideChangeHandler,
                  children: [
                    const IntroSliderItem(
                        'assets/images/delivery_man.png',
                        'Delivery in your location',
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
                            ' sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                            ' Ut enim ad minim veniam'),
                    const IntroSliderItem(
                        'assets/images/customer.png',
                        'Fast Delivery',
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
                            ' sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                            ' Ut enim ad minim veniam'),
                    const IntroSliderItem(
                        'assets/images/rocketman.png',
                        'Order everything quickly',
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit,'
                            ' sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                            ' Ut enim ad minim veniam')
                  ],
                ),
              ),
              Obx(() => DotsIndicator(
                  position: controller.slideIndex,
                  dotsCount: 3,
                  decorator: DotsDecorator(
                      size: const Size(9.0, 9.0),
                      activeSize: const Size(9.0, 9.0),
                      activeColor: AppColors.blue))),
              SizedBox(
                height: Get.height * 0.07,
              )
            ],
          ),
        ),
      ),
    );
  }
}
