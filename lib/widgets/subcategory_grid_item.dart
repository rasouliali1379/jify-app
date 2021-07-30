import 'package:flutter/material.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class SubCategoryGridItem extends StatelessWidget {
  final String name;
  final Color color;
  final GestureTapCallback onClick;

  const SubCategoryGridItem(this.name, this.color, this.onClick);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 50,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(14), color: color),
        child: Center(
          child: Text(
            name,
            style: AppTextStyles.white15Normal400,
          ),
        ),
      ),
    );
  }
}
