import 'package:flutter/material.dart';
import 'package:jify_app/constants/app_colors.dart';

class CustomRadioButton extends StatelessWidget {
  final bool selected;

  const CustomRadioButton({required this.selected});

  @override
  Widget build(BuildContext context) {
    return selected
        ? Container(
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.blue),
            width: 24,
            height: 24,
            child: Container(
              margin: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.blue, border: Border.all(color: AppColors.white, width: 3)),
            ),
          )
        : Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
                border: Border.all(color: AppColors.black.withOpacity(0.3), width: 1.5)),
            width: 24,
            height: 24,
          );
  }
}
