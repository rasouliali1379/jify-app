import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/account_information_page_controller.dart';
import 'package:jify_app/widgets/circle_button.dart';
import 'package:jify_app/widgets/custom_drop_down.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/long_button.dart';
import 'package:jify_app/widgets/phone_number_textfield.dart';
import 'package:jify_app/widgets/titled_textfield.dart';

class AccountInformationPage extends GetView<AccountInformationPageController> {
  @override
  Widget build(BuildContext context) {
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
              TitledTextField('Email number', controller.emailTextController),
              SizedBox(
                height: Get.height * 0.0221,
              ),
              TitledTextField(
                'Mobile number',
                controller.mobileTextController,
                customTextField:
                    PhoneNumberTextField(controller.mobileTextController),
              ),
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
              CustomDropDown('NY - Daniel ST , 147552',
                  controller.openAddressesPage),
              SizedBox(
                height: Get.height * 0.032,
              ),
              const Text(
                'Change password',
                style: AppTextStyles.extraDarkCyan16Normal500,
              ),
              SizedBox(
                height: Get.height * 0.0258,
              ),
              TitledTextField(
                'Old Password',
                controller.oldPassTextController,
                inputType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              SizedBox(
                height: Get.height * 0.0258,
              ),
              TitledTextField(
                'New Password',
                controller.newPassTextController,
                inputType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              SizedBox(
                height: Get.height * 0.0258,
              ),
              TitledTextField(
                'Confirm Password',
                controller.confirmPassTextController,
                inputType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              SizedBox(
                height: Get.height * 0.0418,
              ),
              LongButton(
                  () => {}, 'Save', double.maxFinite, Get.height * 0.064),
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
