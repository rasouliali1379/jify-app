import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/widgets/long_button.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String positiveText;
  final String negativeText;
  final Function positiveClickHandler;
  final Function negativeClickHandler;

  const CustomAlertDialog(this.title, this.message, this.positiveText, this.negativeText, this.positiveClickHandler,
      this.negativeClickHandler);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: AppColors.white,
        systemNavigationBarColor: AppColors.white));
    return Container(
      width: double.maxFinite,
      height: Get.height * 0.307,
      margin: EdgeInsets.symmetric(vertical: Get.height * 0.0369, horizontal: Get.width * 0.0453),
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.0209, horizontal: Get.width * 0.08),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.0246,
              ),
              Text(
                title,
                style: AppTextStyles.black16Normal500.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: Get.height * 0.0197,
              ),
              Text(
                message,
                style: AppTextStyles.black12Normal400.copyWith(fontSize: 14, color: AppColors.black.withOpacity(0.7)),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                child: LongButton(
                  negativeClickHandler,
                  negativeText,
                  double.maxFinite,
                  Get.height * 0.064,
                  color: AppColors.blue.withOpacity(0.08),
                  labelColor: AppColors.blue,
                  elevation: 0,
                ),
              ),
              SizedBox(
                width: Get.width * 0.064,
              ),
              Expanded(
                child: LongButton(
                  positiveClickHandler,
                  positiveText,
                  double.maxFinite,
                  Get.height * 0.064,
                  elevation: 0,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
