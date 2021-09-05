import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:vibration/vibration.dart';
import 'package:flash/flash.dart' as flash;

bool messagePermitted = true;

void showCustomSnackBar(String message,
    {Toast length = Toast.LENGTH_SHORT,
    Color bgColor = Colors.white,
    Color textColor = Colors.black,
    ToastGravity gravity = ToastGravity.BOTTOM,
    int duration = 4}) {
  if (messagePermitted) {
    flash.showFlash(
      context: Get.context!,
      duration: Duration(seconds: duration),
      builder: (context, controller) {
        return flash.Flash(
          controller: controller,
          // position: flash.FlashPosition.bottom,
          alignment: Alignment.bottomCenter,
          boxShadows: kElevationToShadow[4],
          backgroundColor: AppColors.black,
          borderRadius: BorderRadius.circular(8),
          margin: EdgeInsets.only(
              bottom: Get.height * 0.075,
              left: Get.width * 0.0453,
              right: Get.width * 0.0453),
          horizontalDismissDirection:
              flash.HorizontalDismissDirection.horizontal,
          child: flash.FlashBar(
            content: Row(
              children: [
                const Icon(
                  Icons.info,
                  color: AppColors.white,
                ),
                SizedBox(
                  width: Get.width * 0.032,
                ),
                Flexible(
                    child: Text(
                  message,
                  style: AppTextStyles.white14Normal600,
                )),
              ],
            ),
          ),
        );
      },
    );
    messagePermitted = false;
    Future.delayed(Duration(microseconds: (duration * 1000) + 200))
        .then((value) {
      messagePermitted = true;
    });
  }
}

void vibrateWithDuration(int duration) {
  Vibration.hasCustomVibrationsSupport()
      .then((value) => value! ? Vibration.vibrate(duration: duration) : null);
}

// void showCustomSnackBar(String text,
//     {EdgeInsets? padding, int? duration}) {
//   if (messagePermitted) {
//     flash.showFlash(
//       context: Get.context!,
//       duration: Duration(seconds: duration ?? 4),
//       builder: (context, controller) {
//         return flash.Flash(
//           controller: controller,
//           // position: flash.FlashPosition.bottom,
//           alignment: Alignment.bottomCenter,
//           boxShadows: kElevationToShadow[4],
//           backgroundColor: AppColors.black,
//           borderRadius: BorderRadius.circular(8),
//           margin: EdgeInsets.only(
//               bottom: Get.height * 0.075,
//               left: Get.width * 0.0453,
//               right: Get.width * 0.0453),
//           horizontalDismissDirection:
//               flash.HorizontalDismissDirection.horizontal,
//           child: flash.FlashBar(
//             content: Row(
//               children: [
//                 const Icon(
//                   Icons.info,
//                   color: AppColors.white,
//                 ),
//                 SizedBox(
//                   width: Get.width * 0.032,
//                 ),
//                 Flexible(
//                     child: Text(
//                   text,
//                   style: AppTextStyles.white14Normal600,
//                 )),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//     // ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
//     //     behavior: SnackBarBehavior.floating,
//     //     duration: Duration(seconds: duration ?? 4),
//     //     shape: RoundedRectangleBorder(
//     //       borderRadius: BorderRadius.circular(8),
//     //     ),
//     //     backgroundColor: AppColors.black,
//     //     margin: EdgeInsets.only(
//     //         bottom: Get.height * 0.075,
//     //         left: Get.width * 0.0453,
//     //         right: Get.width * 0.0453),
//     //     padding: padding ??
//     //         EdgeInsets.symmetric(
//     //             vertical: Get.height * 0.01, horizontal: Get.width * 0.0426),
//     //     content: Row(
//     //       children: [
//     //         const Icon(
//     //           Icons.info,
//     //           color: AppColors.white,
//     //         ),
//     //         SizedBox(
//     //           width: Get.width * 0.032,
//     //         ),
//     //         Flexible(child: Text(text)),
//     //       ],
//     //     )));
//     messagePermitted = false;
//     Future.delayed(Duration(seconds: duration != null ? duration + 1 : 5))
//         .then((value) {
//       messagePermitted = true;
//     });
//   }
// }
