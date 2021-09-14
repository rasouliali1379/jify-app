import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
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
      bottom: false,
      child: Container(
        width: double.maxFinite,
        height: Get.height * 0.8349,
        decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              SizedBox(
                height: Get.height * 0.0209,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
                child: Row(
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
              ),
              SizedBox(
                height: Get.height * 0.0209,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
                  child: NoScrollGlow(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: Get.height * 0.0147,
                        ),
                        const Text(
                          'Fill out the fields below to get in contact with us',
                          style: AppTextStyles.grey14Normal400,
                        ),
                        SizedBox(
                          height: Get.height * 0.0332,
                        ),
                        Obx(
                          () => TitledTextField(
                            'Full name',
                            controller.fullNameTextController,
                            inputAction: TextInputAction.next,
                            textFieldBgColor: AppColors.red.withOpacity(0.05),
                            errorText: controller.fullNameError.isNotEmpty ? controller.fullNameError : null,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.0197,
                        ),
                        Obx(
                          () => TitledTextField(
                            'Email',
                            controller.emailTextController,
                            inputAction: TextInputAction.next,
                            textFieldBgColor: AppColors.red.withOpacity(0.05),
                            errorText: controller.emailError.isNotEmpty ? controller.emailError : null,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.0197,
                        ),
                        Obx(
                          () => TitledTextField(
                            'Subject',
                            controller.subjectTextController,
                            inputAction: TextInputAction.next,
                            textFieldBgColor: AppColors.red.withOpacity(0.05),
                            errorText: controller.subjectError.isNotEmpty ? controller.subjectError : null,
                          ),
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
                        Obx(
                          () => TitledTextField(
                            'Messages',
                            controller.messagesTextController,
                            inputAction: TextInputAction.next,
                            errorText: controller.messagesError.isNotEmpty ? controller.messagesError : null,
                            customTextField: MultilineTextField(
                              controller.messagesTextController,
                              bgColor: AppColors.red.withOpacity(0.05),
                              height: Get.height * 0.1256,
                              hint: 'Type your message ...',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.0197,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () => Padding(
                  padding: EdgeInsets.all(Get.width * 0.0453),
                  child: LongButton(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
