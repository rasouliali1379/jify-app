import 'dart:math';
import 'dart:ui';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/intro_page_controller.dart';
import 'package:jify_app/widgets/long_button.dart';

class IntroPage extends GetView<IntroPageController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.blue,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.blue));
    return WillPopScope(
      onWillPop: controller.onBackPressedHandler,
      child: Scaffold(
        backgroundColor: AppColors.blue,
        body: SafeArea(
          child: Column(
            children: [
              // SizedBox(
              //   height: Get.height * 0.109,
              // ),
              Expanded(
                child: PageView(
                  physics: const BouncingScrollPhysics(),
                  controller: controller.pageController,
                  onPageChanged: controller.slideChangeHandler,
                  children: [
                    firstIntroSlide(),
                    secondIntroSlide(),
                  ],
                ),
              ),
              Obx(() => DotsIndicator(
                  position: controller.slideIndex,
                  dotsCount: 2,
                  decorator: const DotsDecorator(
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

  Widget firstIntroSlide() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Stack(
              children: [
                Positioned(
                  left: Get.width * 0.04,
                  top: Get.height * 0.0875,
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(-25 / 360),
                    child: Container(
                      width: Get.width * 2,
                      height: Get.height * 0.28,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(200)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.083,
                      right: Get.width * 0.083,
                      top: Get.height * 0.10),
                  child: SizedBox(
                      width: Get.width * 0.8346,
                      height: Get.height * 0.4445,
                      child: Image.asset('assets/images/delivery_man.png')),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            const Text(
              'We’ve got your back',
              style: AppTextStyles.white26Normal600,
            ),
            SizedBox(
              height: Get.height * 0.0307,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0746),
              child: Text(
                'From snacks & drinks to cleaning products & home essentials.'
                ' Hundreds of different items are available instantly'
                ' at your fingertips delivered straight to your doorstep.',
                style: AppTextStyles.white14Normal300.copyWith(height: 1.25),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: Get.height * 0.0738,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
              child: LongButton(
                controller.nextPage,
                'Next',
                double.maxFinite,
                Get.height * 0.064,
                color: AppColors.white,
                labelColor: AppColors.blue,
              ),
            ),
            SizedBox(
              height: Get.height * 0.0258,
            ),
          ],
        ),
      ],
    );
  }

  Widget secondIntroSlide() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Stack(
              children: [
                Positioned(
                  left: Get.width * -1.03,
                  top: Get.height * 0.09,
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(205 / 360),
                    child: Container(
                      width: Get.width * 2,
                      height: Get.height * 0.28,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(200)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: Get.width * 0.083,
                      right: Get.width * 0.083,
                      top: Get.height * 0.10),
                  child: SizedBox(
                      width: Get.width * 0.8773,
                      height: Get.height * 0.4273,
                      child: Image.asset('assets/images/rocketman.png')),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            const Text(
              'Super Fast Delivery',
              style: AppTextStyles.white26Normal600,
            ),
            SizedBox(
              height: Get.height * 0.0307,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0746),
              child: Text(
                'We operate our hyperlocal warehouses in neighourhoods'
                ' across Australia and will deliver to you in as'
                ' little as 15 minutes, we’re only ever a Jify away.',
                style: AppTextStyles.white14Normal300.copyWith(height: 1.25),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: Get.height * 0.0738,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
              child: LongButton(
                controller.getStarted,
                'Let’s Start',
                double.maxFinite,
                Get.height * 0.064,
                color: AppColors.white,
                labelColor: AppColors.blue,
              ),
            ),
            SizedBox(
              height: Get.height * 0.0258,
            ),
          ],
        ),
      ],
    );
  }
}
