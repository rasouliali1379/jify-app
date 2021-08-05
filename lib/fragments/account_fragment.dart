import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/controllers/account_fragment_controller.dart';
import 'package:jify_app/widgets/account_items.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';

class AccountFragment extends GetView<AccountFragmentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomToolBar('My Account', backButtonVisibility: false,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              AccountItems(
                  'Account Information', controller.openAccountInformation),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
                child: const Divider(
                  height: 0,
                  thickness: 1,
                ),
              ),
              AccountItems('Help Center', controller.openHelpCenter),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
                child: const Divider(
                  height: 0,
                  thickness: 1,
                ),
              ),
              AccountItems('Privacy and Terms', controller.openPrivacyAndTerms),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
                child: const Divider(
                  height: 0,
                  thickness: 1,
                ),
              ),
              AccountItems(
                  'Terms and Conditions', controller.openTermsAndConditions),
            ],
          ),
          AccountItems(
            'Log out',
            controller.logout,
            color: AppTextColors.red,
          ),
          const SizedBox()
        ],
      ),
    );
  }
}
