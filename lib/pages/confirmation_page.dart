import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/confirmation_page_controller.dart';
import 'package:jify_app/enums/payment_enum.dart';
import 'package:jify_app/widgets/clickable_text.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/long_button.dart';
import 'package:jify_app/widgets/titled_textfield.dart';

class ConfirmationPage extends GetView<ConfirmationPageController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        // statusBarColor: AppColors.blue,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: AppColors.white,
        systemNavigationBarColor: AppColors.white));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomToolBar('Confirmation'),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: Get.height * 0.1613,
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: controller.cameraPosition,
                      rotateGesturesEnabled: false,
                      zoomGesturesEnabled: false,
                      zoomControlsEnabled: false,
                      tiltGesturesEnabled: false,
                      scrollGesturesEnabled: false,
                      compassEnabled: false,
                      myLocationButtonEnabled: false,
                      onMapCreated: controller.onMapCreated,
                    ),
                    Align(
                      child: SvgPicture.asset(
                        'assets/icons/location.svg',
                        color: AppColors.blue,
                        height: 24,
                        width: 24,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.0283,
                    ),
                    const Text(
                      'Delivery Details',
                      style: AppTextStyles.extraDarkCyan16Normal500,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: controller.openAddressesPage,
                        child: Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.032, bottom: Get.height * 0.0233),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Address',
                                style: AppTextStyles.darkGrey14Normal400,
                              ),
                              const Expanded(child: SizedBox()),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Obx(() => Expanded(
                                          child: Text(
                                            controller.getDeliveryAddress(controller.selectedAddress.address!),
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyles.extraDarkCyan14Normal400
                                                .copyWith(color: AppTextColors.darkCyan),
                                          ),
                                        )),
                                    SizedBox(
                                      width: Get.width * 0.0373,
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: AppColors.darkGrey,
                                      size: 15,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                      color: AppColors.grey,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.032, bottom: Get.height * 0.0233),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Phone Number',
                            style: AppTextStyles.darkGrey14Normal400,
                          ),
                          Row(
                            children: [
                              Text(
                                '+61${controller.globalController.initialDataModel.user!.mobileNumber!}',
                                style: AppTextStyles.extraDarkCyan14Normal400.copyWith(color: AppTextColors.darkCyan),
                              ),
                              // SizedBox(
                              //   width: Get.width * 0.0373,
                              // ),
                              // const Icon(
                              //   Icons.arrow_forward_ios_rounded,
                              //   color: AppColors.darkGrey,
                              //   size: 15,
                              // )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.015,
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 2,
                color: AppColors.grey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.0283,
                    ),
                    const Text(
                      'Delivery Options',
                      style: AppTextStyles.extraDarkCyan16Normal500,
                    ),
                    SizedBox(
                      height: Get.height * 0.027,
                    ),
                    Obx(() => Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: controller.onOptionClickHandler(0),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0123),
                                  height: Get.height * 0.0418,
                                  decoration: controller.selectedOption == 0
                                      ? BoxDecoration(
                                          color: AppColors.blue.withOpacity(0.12),
                                          border: Border.all(color: AppColors.blue),
                                          borderRadius: BorderRadius.circular(9))
                                      : BoxDecoration(
                                          color: AppColors.white,
                                          border: Border.all(color: AppColors.grey),
                                          borderRadius: BorderRadius.circular(9)),
                                  child: Text(
                                    'Leave at door',
                                    style: controller.selectedOption == 0
                                        ? AppTextStyles.blue13Normal300
                                        : AppTextStyles.darkGrey13Normal400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.0186,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: controller.onOptionClickHandler(1),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0123),
                                  height: Get.height * 0.0418,
                                  decoration: controller.selectedOption == 1
                                      ? BoxDecoration(
                                          color: AppColors.blue.withOpacity(0.12),
                                          border: Border.all(color: AppColors.blue),
                                          borderRadius: BorderRadius.circular(9))
                                      : BoxDecoration(
                                          color: AppColors.white,
                                          border: Border.all(color: AppColors.grey),
                                          borderRadius: BorderRadius.circular(9)),
                                  child: Text(
                                    'Meet at door',
                                    style: controller.selectedOption == 1
                                        ? AppTextStyles.blue13Normal300
                                        : AppTextStyles.darkGrey13Normal400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.0186,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: controller.onOptionClickHandler(2),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0123),
                                  height: Get.height * 0.0418,
                                  decoration: controller.selectedOption == 2
                                      ? BoxDecoration(
                                          color: AppColors.blue.withOpacity(0.12),
                                          border: Border.all(color: AppColors.blue),
                                          borderRadius: BorderRadius.circular(9))
                                      : BoxDecoration(
                                          color: AppColors.white,
                                          border: Border.all(color: AppColors.grey),
                                          borderRadius: BorderRadius.circular(9)),
                                  child: Text(
                                    'Meet outside',
                                    style: controller.selectedOption == 2
                                        ? AppTextStyles.blue13Normal300
                                        : AppTextStyles.darkGrey13Normal400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: Get.height * 0.0381,
                    ),
                    TitledTextField('Delivery Notes (optional)', controller.noteTextController),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.0357,
              ),
              const Divider(
                height: 0,
                thickness: 2,
                color: AppColors.grey,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Payment',
                      style: AppTextStyles.extraDarkCyan16Normal500,
                    ),
                    ClickableText(
                      'Add New Card',
                      controller.openAddCardModal,
                      icon: 'assets/icons/card.svg',
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.015,
                ),
                Obx(() {
                  final Payment payment = controller.paymentMethod;
                  return GestureDetector(
                    onTap: controller.openPaymentModal,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.013, horizontal: Get.width * 0.0426),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: AppColors.white,
                          border: Border.all(color: AppColors.grey)),
                      child: Row(
                        children: [
                          Expanded(
                              child: Row(
                            children: [
                              SvgPicture.asset(
                                controller.paymentMethod.icon,
                                width: 16,
                                height: 16,
                              ),
                              SizedBox(
                                width: Get.width * 0.024,
                              ),
                              Text(
                                payment.name,
                                style: AppTextStyles.darkGrey13Normal300,
                              ),
                            ],
                          )),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.grayishBlack,
                          )
                        ],
                      ),
                    ),
                  );
                }),
                SizedBox(
                  height: Get.height * 0.02,
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
            thickness: 2,
            color: AppColors.grey,
          ),
          SizedBox(
            height: Get.height * 0.0357,
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
                child: Obx(() => LongButton(
                      controller.placeOrder,
                      '',
                      double.maxFinite,
                      Get.height * 0.064,
                      customText: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (controller.loadingStatus)
                            const SpinKitThreeBounce(
                              color: AppColors.white,
                              size: 15,
                            )
                          else
                            const Text(
                              'Place Order',
                              style: AppTextStyles.white18Normal500,
                            ),
                          Text(
                            '\$${controller.checkoutData.checkout!.amount!.total!}',
                            style: AppTextStyles.white19Normal700,
                          ),
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: Get.height * 0.0332,
              )
            ],
          )
        ],
      ),
    );
  }
}
