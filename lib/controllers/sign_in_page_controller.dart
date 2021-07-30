import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jify_app/navigation/routes.dart';

class SignInPageController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void openSignUpPage() {
    Get.toNamed(Routes.signUp);
  }
}
