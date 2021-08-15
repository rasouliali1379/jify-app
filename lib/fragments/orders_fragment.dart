import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/controllers/orders_fragment_controller.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/live_orders_list.dart';
import 'package:jify_app/widgets/long_button.dart';
import 'package:jify_app/widgets/previous_order_list.dart';

class OrdersFragment extends StatefulWidget {
  @override
  _OrdersFragmentState createState() => _OrdersFragmentState();
}

class _OrdersFragmentState extends State<OrdersFragment>
    with AutomaticKeepAliveClientMixin {
  final _controller = Get.find<OrdersFragmentController>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.milky,
      appBar: CustomToolBar(
        'My Orders',
        backButtonVisibility: false,
      ),
      body: Obx(() {
        if (!_controller.loggedIn) {
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign in to see your orders',
                    style: AppTextStyles.lightGrey14Normal300,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  LongButton(
                    _controller.openSignInPage,
                    'Sign In',
                    double.maxFinite,
                    Get.height * 0.064,
                  )
                ],
              ),
            ),
          );
        } else if (_controller.ordersList.isEmpty &&
            _controller.previousOrdersList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/orders_placeholder.svg',
                  width: Get.width * 0.221,
                  height: Get.width * 0.221,
                ),
                SizedBox(
                  height: Get.height * 0.0295,
                ),
                const Text(
                  'No Orders Yet',
                  style: AppTextStyles.extraDarkCyan24Normal700,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.141),
                  child: Text(
                    'Your favorites and recent orders will live here.',
                    style: AppTextStyles.extraDarkCyan16Normal500.copyWith(
                        color: AppTextColors.extraDarkCyan.withOpacity(0.6)),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.0197,
                ),
                LongButton(
                  _controller.startOrdering,
                  "Start Order",
                  Get.width * 0.33,
                  Get.height * 0.0566,
                  color: Colors.transparent,
                  elevation: 0,
                  labelColor: AppColors.blue,
                  borderRadius: 50,
                  borderColor: const Color.fromRGBO(216, 216, 216, 1),
                )
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: _controller.onRefresh,
          child: SizedBox(
            height: Get.height,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.0453,
                    vertical: Get.height * 0.01),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  GetBuilder<OrdersFragmentController>(builder: (controller) {
                    return LiveOrdersList('Live orders', controller.ordersList,
                        controller.openOrderDetailsPage);
                  }),
                  GetBuilder<OrdersFragmentController>(builder: (controller) {
                    return PreviousOrdersList(
                        'Previous orders',
                        controller.previousOrdersList,
                        controller.openOrderDetailsPage,
                        controller.reorder);
                  }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
