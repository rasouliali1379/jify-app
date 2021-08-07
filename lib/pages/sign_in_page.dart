import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/controllers/sign_in_page_controller.dart';
import 'package:jify_app/widgets/clickable_text.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/long_button.dart';
import 'package:jify_app/widgets/phone_number_textfield.dart';
import 'package:jify_app/widgets/titled_textfield.dart';

class SignInPage extends GetView<SignInPageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar('Sign In'),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.0453, vertical: Get.height * 0.0467),
        child: Column(
          children: [
            Obx(
              () => TitledTextField(
                'Mobile number',
                controller.mobileTextController,
                customTextField: PhoneNumberTextField(
                  controller.mobileTextController,
                  errorText: controller.phoneNumberError,
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.0197,
            ),
            Obx(() => LongButton(
                  controller.signInButtonClickHandler,
                  "Send Code",
                  double.maxFinite,
                  Get.height * 0.064,
                  customText: controller.loadingStatus
                      ? SpinKitThreeBounce(
                          color: AppColors.white,
                          size: Get.width * 0.0453,
                        )
                      : null,
                ))
          ],
        ),
      ),
    );
  }
}
