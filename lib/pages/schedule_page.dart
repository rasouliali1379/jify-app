import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/schedule_page_controller.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/long_button.dart';
import 'package:jify_app/widgets/schedule_grid_item.dart';

class SchedulePage extends GetView<SchedulePageController> {
  final times = ["5PM", "6PM", "7Pm", "8PM"];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        // statusBarColor: AppColors.blue,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: AppColors.white,
        systemNavigationBarColor: AppColors.white));
    return Scaffold(
      appBar: CustomToolBar('Schedule'),
      backgroundColor: AppColors.milky,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                color: AppColors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: Colors.transparent,
                      shape: const CircleBorder(),
                      child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: controller.previousDay,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Get.width * 0.0453, vertical: Get.height * 0.0258),
                            child: const Icon(Icons.arrow_back_ios, size: 20),
                          )),
                    ),
                    Obx(() => Text(
                          controller.days[controller.selectedDay],
                          style: AppTextStyles.extraDarkCyan16Normal500,
                        )),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: controller.nexDay,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: Get.width * 0.0453, vertical: Get.height * 0.0258),
                            child: const Icon(Icons.arrow_forward_ios, size: 20),
                          )),
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
              }),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.0369, horizontal: Get.width * 0.0453),
            child: LongButton(
              controller.onSelectClickHandler,
              'Select',
              double.maxFinite,
              Get.height * 0.064,
            ),
          )
        ],
      ),
    );
  }
}
