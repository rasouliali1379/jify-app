import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';

bool messagePermitted = true;

void makeCustomToast(String message,
    {Toast length = Toast.LENGTH_SHORT,
    Color bgColor = Colors.white,
    Color textColor = Colors.black,
    ToastGravity gravity = ToastGravity.BOTTOM}) {
  if (messagePermitted) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: length,
        gravity: gravity,
        timeInSecForIosWeb: 3,
        backgroundColor: bgColor,
        textColor: textColor,
        fontSize: 16.0);
    messagePermitted = false;
    Future.delayed(const Duration(seconds: 5)).then((value) {
      messagePermitted = true;
    });
  }
}

void showCustomSnackBar(String text) {
  if (messagePermitted) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: AppColors.black,
        margin: EdgeInsets.only(
            bottom: Get.height * 0.075,
            left: Get.width * 0.0453,
            right: Get.width * 0.0453),
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.01, horizontal: Get.width * 0.0426),
        content: Row(
          children: [
            const Icon(
              Icons.info,
              color: AppColors.white,
            ),
            SizedBox(
              width: Get.width * 0.032,
            ),
            Text(text),
          ],
        )));
    messagePermitted = false;
    Future.delayed(const Duration(seconds: 5)).then((value) {
      messagePermitted = true;
    });
  }
}
