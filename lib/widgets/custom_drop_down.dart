import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class CustomDropDown extends StatelessWidget {
  final String label;
  final GestureTapCallback onClick;

  const CustomDropDown(this.label, this.onClick);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(11),
      child: Container(
        height: Get.height * 0.0591,
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0373),
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.grey,
            ),
            borderRadius: BorderRadius.circular(11)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.darkGrey13Normal300,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.grayishBlack,
            )
          ],
        ),
      ),
    );
  }
}
