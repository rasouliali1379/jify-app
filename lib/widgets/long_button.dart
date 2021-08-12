import 'package:flutter/material.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class LongButton extends StatelessWidget {
  final Function onClick;
  final String title;
  final double width;
  final double height;
  final Widget? customText;
  final Color? color;
  final Color? labelColor;
  final double? elevation;

  const LongButton(this.onClick, this.title, this.width, this.height,
      {this.customText, this.color, this.labelColor, this.elevation});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: () => onClick(),
        style: ButtonStyle(
            elevation: elevation != null
                ? MaterialStateProperty.all<double>(elevation!)
                : null,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(color ?? AppColors.blue)),
        child: customText ??
            Text(
              title,
              style: AppTextStyles.white18Normal500
                  .copyWith(color: labelColor ?? AppColors.white),
            ),
      ),
    );
  }
}
