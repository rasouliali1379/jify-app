import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';

class CategoryGridItem extends StatelessWidget {
  final String name;
  final String image;
  final Function onItemClickHandler;
  final int index;

  const CategoryGridItem(this.name, this.image, this.onItemClickHandler, this.index);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onItemClickHandler(index),
      child: Container(
        height: Get.height * 0.1527,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), color: AppColors.white, boxShadow: [
          BoxShadow(offset: const Offset(0, 2), blurRadius: 2, color: AppColors.black.withOpacity(0.25))
        ]),
        child: Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: CachedNetworkImage(
                  imageUrl: image,
                  width: double.maxFinite,
                  height: double.maxFinite,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: SpinKitThreeBounce(
                      size: 20,
                      color: AppColors.blue,
                    ),
                  ),
                ))),
      ),
    );
  }
}
