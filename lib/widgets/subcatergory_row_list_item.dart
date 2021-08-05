import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class SubCategoryRowListItem extends StatelessWidget {
  final String label;
  final bool selected;
  final Function onClick;
  final int index;

  const SubCategoryRowListItem(this.label, this.selected, this.onClick, this.index);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(index),
      child: Container(
        height: Get.height * 0.0394,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: selected ? null : Border.all(color: AppColors.blue),
          color: selected ? AppColors.blue : AppColors.semiLightBlue,
        ),
        child: Text(
          label,
          style: selected
              ? AppTextStyles.white13Normal300
              : AppTextStyles.blue13Normal300,
        ),
      ),
    );
  }
}
