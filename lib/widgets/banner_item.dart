import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jify_app/models/banner_model.dart';

class BannerItem extends StatelessWidget {
  final BannerModel bannerModel;
  final Function onClick;

  const BannerItem(this.bannerModel, this.onClick);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(bannerModel.linkTo, bannerModel.object),
      child: Container(
        padding: EdgeInsets.only(
            left: Get.width * 0.0426,
            right: Get.width * 0.0426,
            top: Get.height * 0.0184),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: CachedNetworkImage(
              imageUrl: bannerModel.image!,
              width: double.maxFinite,
              height: Get.height * 0.166,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
