import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/home_fragment_controller.dart';
import 'package:jify_app/controllers/main_page_controller.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final GestureTapCallback backClickHandler;
  final Function searchChangeHandler;
  final TextEditingController textController;

  @override
  final Size preferredSize;

  CustomAppBar(this.backClickHandler, this.searchChangeHandler, this.textController)
      : preferredSize = const Size.fromHeight(kToolbarHeight);

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
                        SizedBox(
                          width: controller.backBtnVisibility ? 0 : 16,
                        ),
                        Visibility(
                          visible: controller.backBtnVisibility,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: backClickHandler,
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
                          ),
                        ),
                      ],
                    );
                  }),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 1.5),
                        child: SvgPicture.asset(
                          'assets/icons/tuka.svg',
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/tuka.svg'),
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.only(bottom: 12, top: 8),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.white),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: 'Search within Snacks',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: AppTextStyles.grayishBlack14Normal400
                                    .copyWith(
                                        color: AppTextColors.grayishBlack
                                            .withOpacity(0.3))),
                            onChanged: (value) => searchChangeHandler(value),
                            style: AppTextStyles.extraDarkCyan16Normal500,
                            cursorColor: AppColors.blue,
                            cursorHeight: 18,
                            cursorWidth: 1.2,
                          ),
                        ),
                        GetX<HomeFragmentController>(builder: (controller) {
                          return controller.searchLoading
                              ? const SpinKitRing(
                                  color: AppColors.blue,
                                  size: 20,
                                  lineWidth: 2,
                                )
                              : SvgPicture.asset('assets/icons/search.svg');
                        })
                      ],
                    ),
                  )),
                  const SizedBox(
                    width: 21,
                  ),
                ],
              ))),
    );
  }
}
