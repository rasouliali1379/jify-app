import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/controllers/order_info_controller.dart';
import 'package:jify_app/controllers/orders_fragment_controller.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/live_orders_list.dart';

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
      backgroundColor: AppColors.milky,
      appBar: CustomToolBar(
        'My Orders',
        backButtonVisibility: false,
      ),
      body: SizedBox(
        child: RefreshIndicator(
          onRefresh: _controller.onRefresh,
          key: _controller.refreshKey,
          child: SizedBox(
            height: Get.height,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    GetBuilder<OrdersFragmentController>(builder: (controller) {
                      return OrdersList('Live orders', controller.ordersList,
                          controller.openOrderDetailsPage);
                    }),
                    GetBuilder<OrdersFragmentController>(builder: (controller) {
                      return OrdersList(
                          'Previous orders',
                          controller.previousOrdersList,
                          controller.openOrderDetailsPage);
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
