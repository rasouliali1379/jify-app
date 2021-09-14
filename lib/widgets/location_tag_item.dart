import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class LocationTagItem extends StatelessWidget {
  final String icon;
  final String label;
  final GestureTapCallback onClick;
  final bool selected;

  const LocationTagItem(this.icon, this.label, this.onClick, {required this.selected});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onClick,
        child: Container(
          alignment: Alignment.center,
          height: Get.height * 0.096,
          decoration: selected
              ? BoxDecoration(
                  color: AppColors.blue.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(color: AppColors.blue))
              : BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(11)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                color: selected ? AppColors.blue : AppColors.grey,
              ),
              SizedBox(
                height: Get.height * 0.016,
              ),
              Text(
                label,
                style: AppTextStyles.darkGrey13Normal400,
              )
            ],
          ),
        ),
      ),
    );
  }
}
