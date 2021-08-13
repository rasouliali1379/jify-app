import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/sign_up_page_controller.dart';
import 'package:jify_app/widgets/clickable_text.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/long_button.dart';
import 'package:jify_app/widgets/phone_number_text.dart';
import 'package:jify_app/widgets/titled_textfield.dart';

class SignUpPage extends GetView<SignUpPageController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        // statusBarColor: AppColors.blue,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: AppColors.white,
        systemNavigationBarColor: AppColors.white
    ));
    return Scaffold(
      appBar: CustomToolBar('Sign Up'),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.0453,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.0295,
                    ),
                    const Text(
                      'Fill the fields below to create your new account.',
                      style: AppTextStyles.grayishBlack12Normal300,
                    ),
                    SizedBox(
                      height: Get.height * 0.0344,
                    ),
                    Obx(() => TitledTextField(
                          'First Name',
                          controller.nameTextController,
                          errorText: controller.nameError.isNotEmpty
                              ? controller.nameError
                              : null,
                        )),
                    SizedBox(
                      height: Get.height * 0.0221,
                    ),
                    Obx(() => TitledTextField(
                          'Last Name',
                          controller.lastNameTextController,
                          errorText: controller.lastNameError.isNotEmpty
                              ? controller.lastNameError
                              : null,
                        )),
                    SizedBox(
                      height: Get.height * 0.0221,
                    ),
                    Obx(() => TitledTextField(
                          'Email address',
                          controller.emailTextController,
                          errorText: controller.emailError.isNotEmpty
                              ? controller.emailError
                              : null,
                          inputType: TextInputType.emailAddress,
                        )),
                    SizedBox(
                      height: Get.height * 0.0221,
                    ),
                    Obx(() => PhoneNumberText(
                          controller.phoneNumber,
                        )),
                    SizedBox(
                      height: Get.height * 0.0221,
                    ),
                    // TitledTextField(
                    //   'Password',
                    //   controller.passTextController,
                    //   obscureText: true,
                    // ),
                    // SizedBox(
                    //   height: Get.height * 0.0221,
                    // ),
                    // TitledTextField(
                    //     'Confirm password', controller.nameTextController),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.0332,
              ),
              Obx(() => Row(
                    children: [
                      CustomCheckBox(
                        value: controller.termsCheck,
                        onChanged: controller.termsCheckHandler,
                        borderRadius: 4,
                        checkedFillColor: AppColors.green,
                        uncheckedFillColor: AppColors.lightGrey,
                        uncheckedIconColor: AppColors.lightGrey,
                        borderColor: AppColors.lightGrey,
                      ),
                      Flexible(
                        child: Wrap(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                'I agree to the ',
                                style: AppTextStyles.darkGrey13Normal300,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                'Terms & Conditions ',
                                style: AppTextStyles.blue13Normal300.copyWith(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                'and privacy policy',
                                style: AppTextStyles.darkGrey13Normal300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              Obx(() => Row(
                    children: [
                      CustomCheckBox(
                        value: controller.receiveOffersCheck,
                        onChanged: controller.receiveOffersCheckHandler,
                        borderRadius: 4,
                        checkedFillColor: AppColors.green,
                        uncheckedFillColor: AppColors.lightGrey,
                        uncheckedIconColor: AppColors.lightGrey,
                        borderColor: AppColors.lightGrey,
                      ),
                      const Flexible(
                        child: Text(
                          'I want to receive exclusive offers from Tuka',
                          style: AppTextStyles.darkGrey13Normal300,
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: Get.height * 0.035,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
                  child: Obx(() => LongButton(
                      controller.registerButtonClickHandler,
                      'Register',
                      double.infinity,
                      Get.height * 0.064,
                      customText: controller.loadingStatus
                          ? SpinKitThreeBounce(
                              color: AppColors.white,
                              size: Get.width * 0.0453,
                            )
                          : null))),
              SizedBox(
                height: Get.height * 0.0332,
              ),
              // Center(
              //     child: ClickableText(
              //         'Already have an account?', controller.closePage)),
              // SizedBox(
              //   height: Get.height * 0.0332,)
            ],
          ),
        ),
      ),
    );
  }
}
