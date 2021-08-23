import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
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
        margin: EdgeInsets.only(
            left: Get.width * 0.0426,
            right: Get.width * 0.0426,
            bottom: Get.width * 0.0213,
            top: Get.height * 0.0184),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                  color: AppColors.black.withOpacity(0.25))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: CachedNetworkImage(
            imageUrl: bannerModel.image!,
            width: double.maxFinite,
            height: Get.height * 0.166,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: SpinKitThreeBounce(
                size: 20,
                color: AppColors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
