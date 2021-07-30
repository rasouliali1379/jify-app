import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class CategoryProductRowList extends StatelessWidget {
  final String title;
  final GestureTapCallback showAllOnClick;
  final List<Widget> items;

  const CategoryProductRowList(this.title, this.showAllOnClick, this.items);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Get.width * 0.0453, vertical: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.extraDarkCyan19Normal500,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                    onTap: showAllOnClick,
                    customBorder: const CircleBorder(),
                    child: Row(
                      children: const [
                        Text(
                          'Show all',
                          style: AppTextStyles.blue14Normal500,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.blue,
                          size: 20,
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.3078,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.029),
            scrollDirection: Axis.horizontal,
            children: items,
          ),
        )
      ],
    );
  }
}
