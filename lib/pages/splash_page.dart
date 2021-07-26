import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/splash_page_controller.dart';

class SplashPage extends GetView<SplashPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Container(
        color: AppColors.blue,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
