import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/phone_verification_page_controller.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneVerificationPage extends GetView<PhoneVerificationPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar('Phone Verification'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.032, horizontal: Get.width * 0.0453),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Verifiy your phone Number',
                style: AppTextStyles.extraDarkCyan17Normal500,
              ),
              SizedBox(height: Get.height * 0.0135),
              const Text(
                'We’ve sent a verification code to +1412345678900'
                'please enter the code below',
                style: AppTextStyles.grayishBlack12Normal300,
              ),
              SizedBox(height: Get.height * 0.15),
              PinCodeTextField(
                appContext: context,
                length: 5,
                onChanged: (value) {},
                textStyle: AppTextStyles.extraDarkCyan38Normal200,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                cursorColor: Colors.transparent,
                pinTheme: PinTheme(
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    inactiveColor: AppColors.lightGrey,
                    activeColor: AppColors.blue),
              ),
              SizedBox(
                height: Get.height * 0.0566,
              ),
              SizedBox(
                  width: double.maxFinite,
                  child: Obx(() => Text(
                        'Resend code in ${controller.time[0].toString()}:${controller.time[1].toString()}',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.darkGrey13Normal300,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
