import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class CustomToolBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final GestureTapCallback? onBackPressed;
  final Widget? action;
  final bool backButtonVisibility;

  CustomToolBar(this.title,
      {this.onBackPressed, this.action, this.backButtonVisibility = true})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blue,
      child: SafeArea(
          child: SizedBox(
        height: preferredSize.height,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: backButtonVisibility
                  ? Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: onBackPressed ?? () => Get.back(),
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox()),
            ),
            Center(
              child: Text(
                title,
                style: AppTextStyles.white20Normal400,
              ),
            ),
            Align(alignment: Alignment.centerRight, child: action)
          ],
        ),
      )),
    );
  }
}
