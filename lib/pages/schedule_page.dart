import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/schedule_page_controller.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/schedule_grid_item.dart';

class SchedulePage extends GetView<SchedulePageController> {
  final times = ["5PM", "6PM", "7Pm", "8PM"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar('Schedule'),
      backgroundColor: AppColors.milky,
      body: Column(
        children: [
          Container(
            color: AppColors.white,
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.0453, vertical: Get.height * 0.0258),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(Icons.arrow_back_ios, size: 20),
                Text(
                  'Saturday',
                  style: AppTextStyles.extraDarkCyan16Normal500,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ],
            ),
          ),
          GetBuilder<SchedulePageController>(builder: (_) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(Get.width * 0.0453),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: Get.width / 2,
                  mainAxisExtent: Get.height * 0.0714,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: times.length,
              itemBuilder: (context, index) => ScheduleGridItem(
                  times[index], controller.onScheduleClickHandler(index),
                  selected: controller.selectedTime == index),
            );
          })
        ],
      ),
    );
  }
}
