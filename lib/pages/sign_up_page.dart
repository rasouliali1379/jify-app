import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/sign_up_page_controller.dart';
import 'package:jify_app/widgets/clickable_text.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/long_button.dart';
import 'package:jify_app/widgets/phone_number_textfield.dart';
import 'package:jify_app/widgets/titled_textfield.dart';

class SignUpPage extends GetView<SignUpPageController> {
  @override
  Widget build(BuildContext context) {
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
                    TitledTextField(
                        'First Name', controller.nameTextController),
                    SizedBox(
                      height: Get.height * 0.0221,
                    ),
                    TitledTextField(
                        'Last Name', controller.lastNameTextController),
                    SizedBox(
                      height: Get.height * 0.0221,
                    ),
                    TitledTextField(
                      'First Name',
                      controller.emailTextController,
                      inputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: Get.height * 0.0221,
                    ),
                    TitledTextField(
                      'Mobile number',
                      controller.mobileTextController,
                      customTextField:
                          PhoneNumberTextField(controller.mobileTextController),
                    ),
                    SizedBox(
                      height: Get.height * 0.0221,
                    ),
                    TitledTextField(
                      'Password',
                      controller.passTextController,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: Get.height * 0.0221,
                    ),
                    TitledTextField(
                        'Confirm password', controller.nameTextController),
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
                child: LongButton(controller.registerButtonClickHandler,
                    'Register', double.infinity, Get.height * 0.064),
              ),
              SizedBox(
                height: Get.height * 0.0332,
              ),
              Center(
                  child: ClickableText(
                      'Already have an account?', controller.closePage)),
              SizedBox(
                height: Get.height * 0.0332,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
