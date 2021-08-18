import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/confirmation_page_controller.dart';
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
      appBar: CustomToolBar('Confirmation'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      onTap: () => {},
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Get.height * 0.032,
                            bottom: Get.height * 0.0233),
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
                                  Obx(() => Flexible(
                                        child: Text(
                                          controller.checkoutData.checkout!
                                              .address!.address!,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyles
                                              .extraDarkCyan14Normal400
                                              .copyWith(
                                                  color:
                                                      AppTextColors.darkCyan),
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
                    padding: EdgeInsets.only(
                        top: Get.height * 0.032, bottom: Get.height * 0.0233),
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
                              style: AppTextStyles.extraDarkCyan14Normal400
                                  .copyWith(color: AppTextColors.darkCyan),
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
            // const Divider(
            //   height: 0,
            //   thickness: 2,
            //   color: AppColors.grey,
            // ),
            // SizedBox(
            //   height: Get.height * 0.0344,
            // ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Text(
            //         'Delivery Times',
            //         style: AppTextStyles.extraDarkCyan16Normal500,
            //       ),
            //       SizedBox(
            //         height: Get.height * 0.027,
            //       ),
            //       Row(
            //         children: [
            //           Expanded(
            //             child: GestureDetector(
            //               onTap: controller.onStandardScheduleClickHandler,
            //               child: Obx(() => Container(
            //                     padding: EdgeInsets.symmetric(
            //                         horizontal: Get.width * 0.032),
            //                     height: Get.height * 0.0837,
            //                     decoration: controller
            //                             .selectedSchedule.isNotEmpty
            //                         ? BoxDecoration(
            //                             color: AppColors.white,
            //                             border:
            //                                 Border.all(color: AppColors.grey),
            //                             borderRadius: BorderRadius.circular(9))
            //                         : BoxDecoration(
            //                             color: AppColors.blue.withOpacity(0.12),
            //                             border:
            //                                 Border.all(color: AppColors.blue),
            //                             borderRadius: BorderRadius.circular(9)),
            //                     child: Row(
            //                       children: [
            //                         if (controller.selectedSchedule.isNotEmpty)
            //                           Container(
            //                             decoration: BoxDecoration(
            //                                 shape: BoxShape.circle,
            //                                 color: AppColors.white,
            //                                 border: Border.all(
            //                                     color: AppColors.grey,
            //                                     width: 1.2)),
            //                             width: 22,
            //                             height: 22,
            //                           )
            //                         else
            //                           Container(
            //                             decoration: const BoxDecoration(
            //                                 shape: BoxShape.circle,
            //                                 color: AppColors.blue),
            //                             width: 22,
            //                             height: 22,
            //                             child: Container(
            //                               margin: const EdgeInsets.all(1.5),
            //                               decoration: BoxDecoration(
            //                                   shape: BoxShape.circle,
            //                                   color: AppColors.blue,
            //                                   border: Border.all(
            //                                       color: const Color.fromRGBO(
            //                                           231, 238, 252, 1.0),
            //                                       width: 3)),
            //                             ),
            //                           ),
            //                         SizedBox(
            //                           width: Get.width * 0.0266,
            //                         ),
            //                         Column(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.center,
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                           children: [
            //                             Text(
            //                               'Standard',
            //                               style: controller
            //                                       .selectedSchedule.isNotEmpty
            //                                   ? AppTextStyles
            //                                       .darkCyan14Normal500
            //                                       .copyWith(
            //                                           color: AppColors.darkCyan)
            //                                   : AppTextStyles.blue14Normal500,
            //                             ),
            //                             SizedBox(
            //                               height: Get.height * 0.0086,
            //                             ),
            //                             Text(
            //                               'Available',
            //                               style: controller
            //                                       .selectedSchedule.isNotEmpty
            //                                   ? AppTextStyles
            //                                       .lightGrey14Normal300
            //                                       .copyWith(fontSize: 11)
            //                                   : AppTextStyles.blue14Normal300
            //                                       .copyWith(fontSize: 11),
            //                             ),
            //                           ],
            //                         )
            //                       ],
            //                     ),
            //                   )),
            //             ),
            //           ),
            //           SizedBox(
            //             width: Get.width * 0.024,
            //           ),
            //           Expanded(
            //             child: GestureDetector(
            //                 onTap: controller.openSchedule,
            //                 child: Obx(() => Container(
            //                       padding: EdgeInsets.symmetric(
            //                           horizontal: Get.width * 0.032),
            //                       height: Get.height * 0.0837,
            //                       decoration: controller
            //                               .selectedSchedule.isNotEmpty
            //                           ? BoxDecoration(
            //                               color:
            //                                   AppColors.blue.withOpacity(0.12),
            //                               border:
            //                                   Border.all(color: AppColors.blue),
            //                               borderRadius:
            //                                   BorderRadius.circular(9))
            //                           : BoxDecoration(
            //                               color: AppColors.white,
            //                               border:
            //                                   Border.all(color: AppColors.grey),
            //                               borderRadius:
            //                                   BorderRadius.circular(9)),
            //                       child: Row(
            //                         children: [
            //                           if (controller
            //                               .selectedSchedule.isNotEmpty)
            //                             Container(
            //                               decoration: const BoxDecoration(
            //                                   shape: BoxShape.circle,
            //                                   color: AppColors.blue),
            //                               width: 22,
            //                               height: 22,
            //                               child: Container(
            //                                 margin: const EdgeInsets.all(1.5),
            //                                 decoration: BoxDecoration(
            //                                     shape: BoxShape.circle,
            //                                     color: AppColors.blue,
            //                                     border: Border.all(
            //                                         color: const Color.fromRGBO(
            //                                             231, 238, 252, 1.0),
            //                                         width: 3)),
            //                               ),
            //                             )
            //                           else
            //                             Container(
            //                               decoration: BoxDecoration(
            //                                   shape: BoxShape.circle,
            //                                   color: AppColors.white,
            //                                   border: Border.all(
            //                                       color: AppColors.grey,
            //                                       width: 1.2)),
            //                               width: 22,
            //                               height: 22,
            //                             ),
            //                           SizedBox(
            //                             width: Get.width * 0.0266,
            //                           ),
            //                           Column(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.center,
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             children: [
            //                               Text(
            //                                 'Schedule',
            //                                 style: controller
            //                                         .selectedSchedule.isNotEmpty
            //                                     ? AppTextStyles.blue14Normal500
            //                                     : AppTextStyles
            //                                         .darkCyan14Normal500
            //                                         .copyWith(
            //                                             color:
            //                                                 AppColors.darkCyan),
            //                               ),
            //                               SizedBox(
            //                                 height: Get.height * 0.0086,
            //                               ),
            //                               Text(
            //                                 controller
            //                                         .selectedSchedule.isNotEmpty
            //                                     ? controller.selectedSchedule
            //                                     : 'Not Defined',
            //                                 style: controller
            //                                         .selectedSchedule.isNotEmpty
            //                                     ? AppTextStyles.blue14Normal300
            //                                         .copyWith(fontSize: 11)
            //                                     : AppTextStyles
            //                                         .lightGrey14Normal300
            //                                         .copyWith(fontSize: 11),
            //                               ),
            //                             ],
            //                           )
            //                         ],
            //                       ),
            //                     ))),
            //           )
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: Get.height * 0.0307,
            // ),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.0123),
                                height: Get.height * 0.0418,
                                decoration: controller.selectedOption == 0
                                    ? BoxDecoration(
                                        color: AppColors.blue.withOpacity(0.12),
                                        border:
                                            Border.all(color: AppColors.blue),
                                        borderRadius: BorderRadius.circular(9))
                                    : BoxDecoration(
                                        color: AppColors.white,
                                        border:
                                            Border.all(color: AppColors.grey),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.0123),
                                height: Get.height * 0.0418,
                                decoration: controller.selectedOption == 1
                                    ? BoxDecoration(
                                        color: AppColors.blue.withOpacity(0.12),
                                        border:
                                            Border.all(color: AppColors.blue),
                                        borderRadius: BorderRadius.circular(9))
                                    : BoxDecoration(
                                        color: AppColors.white,
                                        border:
                                            Border.all(color: AppColors.grey),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.0123),
                                height: Get.height * 0.0418,
                                decoration: controller.selectedOption == 2
                                    ? BoxDecoration(
                                        color: AppColors.blue.withOpacity(0.12),
                                        border:
                                            Border.all(color: AppColors.blue),
                                        borderRadius: BorderRadius.circular(9))
                                    : BoxDecoration(
                                        color: AppColors.white,
                                        border:
                                            Border.all(color: AppColors.grey),
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
                  TitledTextField('Delivery Notes (optional)',
                      controller.noteTextController),
                  SizedBox(
                    height: Get.height * 0.0357,
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
              height: Get.height * 0.0307,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment',
                    style: AppTextStyles.extraDarkCyan16Normal500,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: Get.height * 0.032, bottom: Get.height * 0.0233),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Payment',
                          style: AppTextStyles.darkGrey14Normal400,
                        ),
                        Row(
                          children: [
                            Image.asset('assets/images/master_card.png',
                                width: Get.width * 0.0853,
                                height: Get.height * 0.027),
                            SizedBox(
                              width: Get.width * 0.0266,
                            ),
                            Text(
                              'MasterCard...099',
                              style: AppTextStyles.extraDarkCyan14Normal400
                                  .copyWith(
                                      color: AppTextColors.extraDarkCyan
                                          .withOpacity(0.6)),
                            ),
                            SizedBox(
                              width: Get.width * 0.0373,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.grayishBlack,
                              size: 15,
                            )
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
            SizedBox(
              height: Get.height * 0.0344,
            ),
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
        ),
      ),
    );
  }
}
