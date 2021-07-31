import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class ScheduleGridItem extends StatelessWidget {
  final bool selected;
  final String label;
  final GestureTapCallback onClick;

  const ScheduleGridItem(this.label, this.onClick, {required this.selected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(
            vertical: Get.height * 0.0246, horizontal: Get.width * 0.04),
        decoration: selected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: Colors.blue),
                color: AppColors.blue.withOpacity(0.12))
            : BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(9)),
        child: Row(
          children: [
            if (selected)
              Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.blue),
                width: 22,
                height: 22,
                child: Container(
                  margin: const EdgeInsets.all(1.5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.blue,
                      border: Border.all(
                          color: const Color.fromRGBO(231, 238, 252, 1.0),
                          width: 3)),
                ),
              )
            else
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                    border: Border.all(color: AppColors.grey, width: 1.2)),
                width: 22,
                height: 22,
              ),
            SizedBox(
              width: Get.width * 0.0266,
            ),
            Text(
              label,
              style: AppTextStyles.darkCyan14Normal500,
            ),
          ],
        ),
      ),
    );
  }
}
