import 'dart:math';

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
                    IntroSliderItem(
                        'assets/images/delivery_man.png',
                        'We’ve got your back',
                        'From snacks & drinks to cleaning products & home essentials.'
                            ' Hundreds of different items are available instantly'
                            ' at your fingertips delivered straight to your doorstep. ',
                        'Next',
                        controller.nextPage,
                        FirstSlideShapePainter()),
                    IntroSliderItem(
                        'assets/images/rocketman.png',
                        'Super Fast Delivery',
                        'We operate our hyperlocal warehouses in neighourhoods'
                            ' across Australia and will deliver to you in as'
                            ' little as 15 minutes, we’re only ever a Jify away.',
                        'Let’s Start',
                        controller.getStarted,
                        SecondSlideShapePainter())
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

class FirstSlideShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_fill = Paint();
    paint_0_fill.color = Colors.white.withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * 2.012689, size.height * 0.4630771,
                size.width * 1.919444, size.height * 0.4927959),
            bottomRight: Radius.circular(size.width * 0.3018389),
            bottomLeft: Radius.circular(size.width * 0.3018389),
            topLeft: Radius.circular(size.width * 0.3018389),
            topRight: Radius.circular(size.width * 0.3018389)),
        paint_0_fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SecondSlideShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(center, 100, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
