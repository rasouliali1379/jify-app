import 'package:flutter/material.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class ProductItem extends StatelessWidget {
  final String image;
  final String name;
  final String price;

  const ProductItem(this.image, this.name, this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.extraLightBLue, width: 1.2)),
      child: Column(
        children: [
          const SizedBox(height: 4,),
          Image.asset(image),
          const SizedBox(height: 10,),
          Text(
            name,
            style: AppTextStyles.darkPurple13Normal300,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4,),
          Text(
            price,
            style: AppTextStyles.darkPurple13Normal700,
          ),

        ],
      ),
    );
  }
}
