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
      resizeToAvoidBottomInset: false,
      appBar: CustomToolBar(
        'My Account',
        backButtonVisibility: false,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          AccountItems('Account Information', controller.openAccountInformation),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
            child: const Divider(
              height: 0,
              thickness: 1,
            ),
          ),
          AccountItems('Promotions', controller.openPromotions),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
            child: const Divider(
              height: 0,
              thickness: 1,
            ),
          ),
          AccountItems('Help Centere', controller.openHelpCenter),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
            child: const Divider(
              height: 0,
              thickness: 1,
            ),
          ),
          AccountItems('Privacy Policy', controller.openPrivacyAndTerms),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
            child: const Divider(
              height: 0,
              thickness: 1,
            ),
          ),
          AccountItems('Terms and Conditions', controller.openTermsAndConditions),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
            child: const Divider(
              height: 0,
              thickness: 1,
            ),
          ),
          Obx(() => controller.loggedIn
              ? AccountItems(
                  'Log out',
                  controller.openLogoutModal,
                  color: AppTextColors.red,
                )
              : AccountItems(
                  'Sign in',
                  controller.login,
                  color: AppTextColors.green,
                )),
        ],
      ),
    );
  }
}
