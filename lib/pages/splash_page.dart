import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: AppColors.blue,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: AppColors.blue,
        systemNavigationBarColor: AppColors.blue));
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Container(
        color: AppColors.blue,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                "assets/images/logo.png",
                width: Get.width * 0.7,
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
