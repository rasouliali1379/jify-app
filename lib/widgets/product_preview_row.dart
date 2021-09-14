import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/models/product_model.dart';

class ProductPreviewRow extends StatelessWidget {
  final List<ProductModel> products;

  const ProductPreviewRow(this.products);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: fruitsGroup(products),
    );
  }

  List<Widget> fruitsGroup(List<ProductModel> products) {
    final distances = [0, Get.width * 0.0533, Get.width * 0.101];
    final images = <Widget>[];

    int loopLength = 3;

    if (products.length < 3) {
      loopLength = products.length;
    }

    for (int i = 0; i < loopLength; i++) {
      images.add(Positioned(
        left: distances[i].toDouble(),
        child: Container(
          height: Get.width * 0.08,
          width: Get.width * 0.08,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: AppColors.lightGrey, border: Border.all(color: AppColors.white)),
          padding: EdgeInsets.all(Get.width * 0.008),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: CachedNetworkImage(
              imageUrl: products[i].image!,
            ),
          ),
        ),
      ));
    }

    return images;
  }
}
