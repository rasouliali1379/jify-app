import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utilities {
  static void makeCustomToast(String message,
      {Toast length = Toast.LENGTH_SHORT,
      Color bgColor = Colors.white,
      Color textColor = Colors.black,
      ToastGravity gravity = ToastGravity.BOTTOM}) {
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
