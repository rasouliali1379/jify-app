import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utilities {
  static bool toastPermitted = true;

  static void makeCustomToast(String message,
      {Toast length = Toast.LENGTH_SHORT,
      Color bgColor = Colors.white,
      Color textColor = Colors.black,
      ToastGravity gravity = ToastGravity.BOTTOM}) {
    if (toastPermitted) {
      Fluttertoast.showToast(
          msg: message,
          toastLength: length,
          gravity: gravity,
          timeInSecForIosWeb: 3,
          backgroundColor: bgColor,
          textColor: textColor,
          fontSize: 16.0);
    }
  }

  static void toastLimiter() {
    toastPermitted = false;
    Future.delayed(const Duration(seconds: 5))
        .then((value) => toastPermitted = true);
  }
}
