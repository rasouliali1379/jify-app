import 'package:flutter/material.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class CategoryGridItem extends StatelessWidget {
  final String name;
  final Color color;

  const CategoryGridItem(this.name, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(14), color: color),
      child: Center(
        child: Text(
          name,
          style: AppTextStyles.white15Normal400,
        ),
      ),
    );
  }
}
