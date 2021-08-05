import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class CategoryGridItem extends StatelessWidget {
  final String name;
  final String image;
  final GestureTapCallback onClick;

  const CategoryGridItem(this.name, this.image, this.onClick);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
        child: Stack(
          children: [
            Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: CachedNetworkImage(
                      imageUrl: image,
                    ))),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.black.withOpacity(0.35))),
            Center(
              child: Text(
                name,
                style: AppTextStyles.white15Normal400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
