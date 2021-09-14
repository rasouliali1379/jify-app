import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/phone_verification_page_controller.dart';
import 'package:jify_app/widgets/clickable_text.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneVerificationPage extends GetView<PhoneVerificationPageController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        // statusBarColor: AppColors.blue,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: AppColors.white,
        systemNavigationBarColor: AppColors.white));
    return Scaffold(
      appBar: CustomToolBar('Phone Verification'),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.032, horizontal: Get.width * 0.0453),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Verifiy your phone Number',
              style: AppTextStyles.extraDarkCyan17Normal500,
            ),
            SizedBox(height: Get.height * 0.0135),
            Text(
              'We’ve sent a verification code to +61${controller.phoneNumber}'
              ' please enter the code below',
              style: AppTextStyles.grayishBlack12Normal300,
            ),
            SizedBox(height: Get.height * 0.15),
            Obx(
              () => PinCodeTextField(
                appContext: context,
                length: 5,
                onChanged: (value) {},
                controller: controller.pinCodeController,
                errorAnimationController: controller.errorController,
                focusNode: controller.pinCodeFieldFocus,
                textStyle: AppTextStyles.extraDarkCyan38Normal200,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                cursorColor: Colors.transparent,
                onCompleted: controller.onPinCodeCompleteHandler,
                errorAnimationDuration: 300,
                pinTheme: PinTheme(
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    inactiveColor: controller.pinCodeFieldError ? AppColors.red : AppColors.lightGrey,
                    activeColor: controller.pinCodeFieldError ? AppColors.red : AppColors.blue),
              ),
            ),
            SizedBox(
              height: Get.height * 0.0566,
            ),
            SizedBox(
                width: double.maxFinite,
                child: Obx(() {
                  switch (controller.resendStatus) {
                    case "resend":
                      return Center(child: ClickableText('Resend Code', controller.resendCode));

                    case "countdown":
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Resend code in ',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.darkGrey13Normal300,
                          ),
                          CountdownTimer(
                            controller: controller.countdownController,
                            widgetBuilder: (context, time) => Text(
                              '${time!.min ?? 0}:'
                              '${(time.sec! < 10 ? '0${time.sec}' : time.sec) ?? 0}',
                              style: AppTextStyles.darkGrey13Normal300,
                            ),
                            onEnd: controller.onCountdownFinished,
                          )
                        ],
                      );
                    case "try_again":
                      return Center(child: ClickableText('Try Again', controller.resendCode));
                    case "loading":
                      return const Center(
                          child: SpinKitThreeBounce(
                        color: AppColors.blue,
                        size: 15,
                      ));
                    default:
                      return const SizedBox();
                  }
                }))
          ],
        ),
      ),
    );
  }
}
