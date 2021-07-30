import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class AccountItems extends StatelessWidget {
  final String label;
  final GestureTapCallback onClick;
  final Color? color;

  const AccountItems(this.label, this.onClick, {this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onClick,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.0453, vertical: Get.height * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: color != null
                    ? AppTextStyles.darkPurple14Normal400.copyWith(color: color)
                    : AppTextStyles.darkPurple14Normal400,
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: color ?? AppColors.darkGrey,
                size: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
