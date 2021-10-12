import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class TitledTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Widget? customTextField;
  final bool? obscureText;
  final TextInputType? inputType;
  final String? errorText;
  final TextStyle? titleStyle;
  final Color? textFieldBgColor;
  final double? height;
  final TextInputAction inputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;

  const TitledTextField(this.title, this.controller,
      {this.customTextField,
      this.obscureText,
      this.inputType,
      this.errorText,
      this.titleStyle,
      this.textFieldBgColor,
      this.height,
      this.onChanged,
      this.focusNode,
      this.inputAction = TextInputAction.done});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleStyle ?? AppTextStyles.darkGrey13Normal300,
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: height,
          child: customTextField ??
              TextField(
                obscureText: obscureText ?? false,
                cursorColor: AppColors.blue,
                cursorHeight: 20,
                focusNode: focusNode,
                onChanged: onChanged,
                style: AppTextStyles.darkGrey14Normal300,
                controller: controller,
                keyboardType: inputType ?? TextInputType.text,
                textInputAction: inputAction,
                decoration: InputDecoration(
                  errorText: errorText,
                  filled: textFieldBgColor != null,
                  fillColor: textFieldBgColor ?? Colors.transparent,
                  errorStyle: AppTextStyles.red10Normal300,
                  contentPadding: EdgeInsets.symmetric(vertical: Get.height * 0.0209, horizontal: Get.width * 0.0426),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11), borderSide: const BorderSide(color: AppColors.grey)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11), borderSide: const BorderSide(color: AppColors.red)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11), borderSide: const BorderSide(color: AppColors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11), borderSide: const BorderSide(color: AppColors.blue)),
                ),
              ),
        ),
      ],
    );
  }
}
