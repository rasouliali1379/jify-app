import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/home_fragment_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final GestureTapCallback backClickHandler;
  final GestureTapCallback clearSearch;
  final Function searchChangeHandler;
  final TextEditingController textController;
  final FocusNode focusNode;
  @override
  final Size preferredSize;

  CustomAppBar(this.backClickHandler, this.clearSearch, this.searchChangeHandler, this.textController, this.focusNode)
      : preferredSize = Size.fromHeight(Get.height * 0.09);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blue,
      child: SafeArea(
          child: SizedBox(
              height: preferredSize.height,
              child: Row(
                children: [
                  GetX<MainPageController>(builder: (controller) {
                    return Row(
                      children: [
                        // SizedBox(
                        //   width: controller.backBtnVisibility
                        //       ? 0
                        //       : Get.width * 0.0426,
                        // ),
                        Opacity(
                          opacity: controller.backBtnVisibility ? 1 : 0,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: backClickHandler,
                              customBorder: const CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.only(left: Get.width * 0.0373, right: Get.width * 0.0266),
                                child: const Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  Expanded(
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: Get.width * 0.24,
                          height: Get.height * 0.055,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          width: Get.width * 0.05,
                        ),
                        Expanded(
                            child: Container(
                          height: Get.height * 0.0492,
                          margin: EdgeInsets.symmetric(vertical: Get.height * 0.0147),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.transparent),
                          child: Neumorphic(
                            style: NeumorphicStyle(
                                color: AppColors.white,
                                depth: -1,
                                shadowDarkColor: Colors.black,
                                shadowDarkColorEmboss: Colors.black,
                                boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0426),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: "Search items ...",
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          contentPadding: EdgeInsets.only(bottom: Get.height * 0.006),
                                          hintStyle: AppTextStyles.grayishBlack14Normal400
                                              .copyWith(color: AppTextColors.grayishBlack.withOpacity(0.3))),
                                      onChanged: (value) => searchChangeHandler(value),
                                      style: AppTextStyles.extraDarkCyan16Normal500,
                                      cursorColor: AppColors.blue,
                                      cursorHeight: 18,
                                      cursorWidth: 1.2,
                                      controller: textController,
                                      focusNode: focusNode,
                                    ),
                                  ),
                                  GetX<HomeFragmentController>(builder: (controller) {
                                    if (controller.searchLoading) {
                                      return const SpinKitRing(
                                        color: AppColors.blue,
                                        size: 20,
                                        lineWidth: 2,
                                      );
                                    } else if (textController.text.isNotEmpty) {
                                      return InkWell(
                                          onTap: clearSearch,
                                          child: const Icon(
                                            Icons.clear,
                                            size: 20,
                                            color: AppColors.grayishBlack,
                                          ));
                                    }
                                    return SvgPicture.asset('assets/icons/search.svg');
                                  })
                                ],
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 21,
                  ),
                ],
              ))),
    );
  }
}
