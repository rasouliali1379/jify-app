import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  CustomAppBar() : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.blue,
      child: SafeArea(
          child: Container(
              height: preferredSize.height,
              child: Row(
                children: [
                  const SizedBox(
                    width: 21,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: SvgPicture.asset('assets/icons/tuka.svg'),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
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
                            style: AppTextStyles.extraDarkCyan16Normal500,
                            cursorColor: AppColors.blue,
                            cursorHeight: 18,
                            cursorWidth: 1.2,
                          ),
                        ),
                        SvgPicture.asset('assets/icons/search.svg')
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
