import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/navigation/routes.dart';
import 'package:jify_app/widgets/add_button.dart';

class ProductItem extends StatelessWidget {
  final String image;
  final String name;
  final String price;

  const ProductItem(this.image, this.name, this.price);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.product),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: AspectRatio(
          aspectRatio: (Get.width * 0.293) / (Get.height * 0.2512) ,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.extraLightBLue, width: 1.2)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 4,
                ),
                Image.asset(image),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  style: AppTextStyles.darkPurple13Normal300,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  price,
                  style: AppTextStyles.darkPurple13Normal700,
                ),
                const SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SizedBox(
                      width: double.maxFinite,
                      height: Get.height * 0.0369,
                      child: AddButton(() => {})),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
