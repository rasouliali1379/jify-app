import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/sign_in_page_controller.dart';
import 'package:jify_app/widgets/clickable_text.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/long_button.dart';
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
            TitledTextField(
              'Email address',
              controller.emailController,
              inputType: TextInputType.emailAddress,
              errorText: 'Wrong username or password',
            ),
            SizedBox(
              height: Get.height * 0.0197,
            ),
            TitledTextField(
              'Password',
              controller.passwordController,
              inputType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            SizedBox(
              height: Get.height * 0.0258,
            ),
            LongButton(
                () => {}, 'Sign In', double.maxFinite, Get.height * 0.064),
            SizedBox(
              height: Get.height * 0.0332,
            ),
            ClickableText('Dont have an account?', controller.openSignUpPage),
            SizedBox(
              height: Get.height * 0.0295,
            ),
            ClickableText('Forget Password', () => {})
          ],
        ),
      ),
    );
  }
}
