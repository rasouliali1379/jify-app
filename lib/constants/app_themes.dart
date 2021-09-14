import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_fonts.dart';
import 'package:jify_app/utilities/cupertino_theme_overrides.dart';

class AppThemes {
  static final defaultTheme = ThemeData(
    cupertinoOverrideTheme: MaterialAppCupertinoThemeDataOverrides(AppFonts.pulpDisplay),
    accentColor: AppColors.blue,
    primaryColor: AppColors.white,
    primaryColorBrightness: Brightness.light,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
    backgroundColor: AppColors.white,
    scaffoldBackgroundColor: AppColors.white,
    dialogBackgroundColor: AppColors.white,
    canvasColor: AppColors.white,
    fontFamily: AppFonts.pulpDisplay,
    textTheme: Get.textTheme.apply(
      displayColor: AppTextColors.black,
      bodyColor: AppTextColors.black,
      fontFamily: AppFonts.pulpDisplay,
    ),
  );
}
