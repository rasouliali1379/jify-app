import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jify_app/constants/app_colors.dart';

class MaterialAppCupertinoThemeDataOverrides extends CupertinoThemeData {
  MaterialAppCupertinoThemeDataOverrides(String fontFamily)
      : super(
          brightness: Brightness.light,
          primaryColor: AppColors.white,
          primaryContrastingColor: AppColors.blue,
          scaffoldBackgroundColor: AppColors.white,
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(
                color: AppTextColors.extraDarkCyan, fontFamily: fontFamily),
            actionTextStyle: TextStyle(
                color: AppTextColors.extraDarkCyan, fontFamily: fontFamily),
            dateTimePickerTextStyle: TextStyle(
                color: AppTextColors.extraDarkCyan, fontFamily: fontFamily),
            navActionTextStyle: TextStyle(
                color: AppTextColors.extraDarkCyan, fontFamily: fontFamily),
            navLargeTitleTextStyle: TextStyle(
                color: AppTextColors.extraDarkCyan, fontFamily: fontFamily),
            navTitleTextStyle: TextStyle(
                color: AppTextColors.extraDarkCyan, fontFamily: fontFamily),
            pickerTextStyle: TextStyle(
                color: AppTextColors.extraDarkCyan, fontFamily: fontFamily),
            tabLabelTextStyle: TextStyle(
                color: AppTextColors.extraDarkCyan,
                fontFamily: fontFamily,
                fontSize: 11),
          ),
        );
}
