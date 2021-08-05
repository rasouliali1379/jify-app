import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/splash_page_controller.dart';
import 'package:jify_app/widgets/clickable_text.dart';

class SplashPage extends GetView<SplashPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Container(
        color: AppColors.blue,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/icons/tuka.svg'),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'order everything you need quickly',
                    style: AppTextStyles.white15Normal400,
                  ),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => controller.tryAgainVisibility
                        ? ClickableText(
                            'Try again',
                            controller.initApp,
                            style: AppTextStyles.white14Normal400,
                          )
                        : const SpinKitThreeBounce(
                            color: AppColors.white,
                            size: 15,
                          )),
                    SizedBox(
                      height: Get.height * 0.1,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
