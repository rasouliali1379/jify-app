import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/account_information_page_controller.dart';
import 'package:jify_app/widgets/circle_button.dart';
import 'package:jify_app/widgets/custom_drop_down.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/long_button.dart';
import 'package:jify_app/widgets/phone_number_text.dart';
import 'package:jify_app/widgets/titled_textfield.dart';

class AccountInformationPage extends GetView<AccountInformationPageController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        // statusBarColor: AppColors.blue,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: AppColors.white,
        systemNavigationBarColor: AppColors.white));
    return Scaffold(
      appBar: CustomToolBar(
        'Account Information',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.0344),
                child: const Text(
                  'View or change your account details',
                  style: AppTextStyles.grayishBlack12Normal300,
                ),
              ),
              TitledTextField('First Name', controller.nameTextController),
              SizedBox(
                height: Get.height * 0.0221,
              ),
              TitledTextField('Last name', controller.lastNameTextController),
              SizedBox(
                height: Get.height * 0.0221,
              ),
              TitledTextField('Email', controller.emailTextController),
              SizedBox(
                height: Get.height * 0.0221,
              ),
              Obx(() => PhoneNumberText(controller.phoneNumber)),
              SizedBox(
                height: Get.height * 0.032,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Addresses',
                    style: AppTextStyles.extraDarkCyan16Normal500,
                  ),
                  CircleButton(
                      const Icon(
                        Icons.add,
                        color: AppColors.white,
                        size: 22,
                      ),
                      AppColors.blue,
                      controller.openDeliveryAddressesPage)
                ],
              ),
              SizedBox(
                height: Get.height * 0.0258,
              ),
              Obx(() => CustomDropDown(controller.selectedAddress, controller.openAddressesPage)),
              // SizedBox(
              //   height: Get.height * 0.032,
              // ),
              // const Text(
              //   'Change password',
              //   style: AppTextStyles.extraDarkCyan16Normal500,
              // ),
              // SizedBox(
              //   height: Get.height * 0.0258,
              // ),
              // TitledTextField(
              //   'Old Password',
              //   controller.oldPassTextController,
              //   inputType: TextInputType.visiblePassword,
              //   obscureText: true,
              // ),
              // SizedBox(
              //   height: Get.height * 0.0258,
              // ),
              // TitledTextField(
              //   'New Password',
              //   controller.newPassTextController,
              //   inputType: TextInputType.visiblePassword,
              //   obscureText: true,
              // ),
              // SizedBox(
              //   height: Get.height * 0.0258,
              // ),
              // TitledTextField(
              //   'Confirm Password',
              //   controller.confirmPassTextController,
              //   inputType: TextInputType.visiblePassword,
              //   obscureText: true,
              // ),
              SizedBox(
                height: Get.height * 0.0418,
              ),

              Obx(() => LongButton(controller.updateUserData, 'Save', double.maxFinite, Get.height * 0.064,
                  customText: controller.loadingStatus
                      ? SpinKitThreeBounce(
                          color: AppColors.white,
                          size: Get.width * 0.0453,
                        )
                      : null)),
              SizedBox(
                height: Get.height * 0.0369,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
