import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/controllers/orders_page_controller.dart';
import 'package:jify_app/widgets/custom_app_bar.dart';
import 'package:jify_app/widgets/custom_toolbar.dart';
import 'package:jify_app/widgets/live_orders_list.dart';
import 'package:jify_app/widgets/orders_list_item.dart';
import 'package:jify_app/widgets/previous_orders_list_item.dart';

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
    final list = [
      OrdersListItem(
          'order_num1545', '950.00', 1, _controller.openOrderDetailsPage),
      OrdersListItem(
          'order_num1545', '950.00', 2, _controller.openOrderDetailsPage)
    ];

    final previousList = [
      PreviousOrdersListItem(
          'order_num1545', '950.00', _controller.openOrderDetailsPage),
      PreviousOrdersListItem(
          'order_num1545', '950.00', _controller.openOrderDetailsPage)
    ];

    return Scaffold(
      backgroundColor: AppColors.milky,
      appBar: CustomToolBar('My Orders'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0453),
          child: Column(
            children: [
              OrdersList('Live orders', list),
              OrdersList('Previous orders', previousList),
            ],
          ),
        ),
      ),
    );
  }
}
