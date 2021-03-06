import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/models/order_model.dart';
import 'package:jify_app/widgets/orders_list_item.dart';

class LiveOrdersList extends StatelessWidget {
  final String title;
  final List<OrderModel> items;
  final Function openOrder;

  const LiveOrdersList(this.title, this.items, this.openOrder);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 21),
          child: Text(
            title,
            style: AppTextStyles.extraDarkCyan19Normal500,
          ),
        ),
        if (items.isEmpty)
          SizedBox(
            height: Get.height * 0.3,
            width: double.maxFinite,
            child: const Center(
              child: Text(
                'Nothing to show',
                style: AppTextStyles.lightGrey14Normal300,
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) => OrdersListItem(items[index], openOrder),
          )
      ],
    );
  }
}
