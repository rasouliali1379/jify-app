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
        backgroundColor: AppColors.blue,
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
                  dotsCount: 2,
                  decorator: DotsDecorator(
                      size: const Size(9.0, 9.0),
                      activeSize: const Size(9.0, 9.0),
                      color: AppColors.lightBlue,
                      activeColor: AppColors.white))),
              SizedBox(
                height: Get.height * 0.048,
              )
            ],
          ),
        ),
      ),
    );
  }
}
