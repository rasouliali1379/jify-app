import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/checkout_fragment_controller.dart';
import 'package:jify_app/controllers/help_center_page_controller.dart';
import 'package:jify_app/widgets/circle_button.dart';
import 'package:jify_app/widgets/long_button.dart';
import 'package:jify_app/widgets/multiline_textfield.dart';
import 'package:jify_app/widgets/no_scroll_glow.dart';
import 'package:jify_app/widgets/titled_textfield.dart';

class ContactUsModal extends GetView<HelpCenterPageController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.maxFinite,
        height: Get.height * 0.8349,
        padding: EdgeInsets.all(Get.width * 0.0453),
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: NoScrollGlow(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Contact Us',
                      style: AppTextStyles.black16Normal600,
                    ),
                    CircleButton(
                      Icon(
                        Icons.clear,
                        color: AppColors.darkGrey,
                        size: Get.width * 0.06,
                      ),
                      AppColors.grey,
                      controller.closeModal,
                      height: Get.width * 0.0746,
                      width: Get.width * 0.0746,
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.0147,
                ),
                const Text(
                  'Delivery option and delivery speeds may very '
                  'for different locations',
                  style: AppTextStyles.grey14Normal400,
                ),
                SizedBox(
                  height: Get.height * 0.0332,
                ),
                TitledTextField(
                  'Fullname',
                  controller.fullNameTextController,
                  inputAction: TextInputAction.next,
                  textFieldBgColor: AppColors.red.withOpacity(0.05),
                ),
                SizedBox(
                  height: Get.height * 0.0197,
                ),
                TitledTextField(
                  'Email',
                  controller.emailTextController,
                  inputAction: TextInputAction.next,
                  textFieldBgColor: AppColors.red.withOpacity(0.05),
                ),
                SizedBox(
                  height: Get.height * 0.0197,
                ),
                TitledTextField(
                  'Subject',
                  controller.subjectTextController,
                  inputAction: TextInputAction.next,
                  textFieldBgColor: AppColors.red.withOpacity(0.05),
                ),
                SizedBox(
                  height: Get.height * 0.0197,
                ),
                TitledTextField(
                  'Order Number',
                  controller.orderNumberTextController,
                  inputAction: TextInputAction.next,
                  textFieldBgColor: AppColors.red.withOpacity(0.05),
                ),
                SizedBox(
                  height: Get.height * 0.0197,
                ),
                TitledTextField(
                  'Messages',
                  controller.messagesTextController,
                  inputAction: TextInputAction.next,
                  customTextField: MultilineTextField(
                    controller.messagesTextController,
                    bgColor: AppColors.red.withOpacity(0.05),
                    height: Get.height * 0.1256,
                    hint: 'Type your message ...',
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.0197,
                ),
                Obx(
                  () => LongButton(
                    controller.submitMessage,
                    'Submit',
                    Get.width,
                    Get.height * 0.064,
                    customText: controller.loadingStatus
                        ? const SpinKitThreeBounce(
                            color: AppColors.white,
                            size: 15,
                          )
                        : null,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
