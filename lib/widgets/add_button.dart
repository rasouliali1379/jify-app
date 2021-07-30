import 'package:flutter/material.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onClick;

  const AddButton(this.onClick);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
        ),
       backgroundColor:  MaterialStateProperty.all<Color>(AppColors.lightGreen)
      ),
      child: const Text(
        'Add',
        style: AppTextStyles.white13Normal800,
      ),
    );
  }
}
