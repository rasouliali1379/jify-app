import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      body: Obx(() => _controller.loggedIn
          ? RefreshIndicator(
              onRefresh: _controller.onRefresh,
              child: SizedBox(
                height: Get.height,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        GetBuilder<OrdersFragmentController>(
                            builder: (controller) {
                          return LiveOrdersList(
                              'Live orders',
                              controller.ordersList,
                              controller.openOrderDetailsPage);
                        }),
                        GetBuilder<OrdersFragmentController>(
                            builder: (controller) {
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
              ),
            )
          : Center(
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
            )),
    );
  }
}
