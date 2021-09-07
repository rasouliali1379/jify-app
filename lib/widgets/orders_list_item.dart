import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/models/order_model.dart';
import 'package:jify_app/widgets/product_preview_row.dart';

class OrdersListItem extends StatelessWidget {
  final OrderModel orderModel;
  final Function onClick;

  const OrdersListItem(this.orderModel, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Get.width * 0.04),
      margin: EdgeInsets.symmetric(vertical: Get.width * 0.011),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(11)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    orderModel.orderNumber.toString(),
                    style: AppTextStyles.extraDarkCyan14Normal400,
                  ),
                  Text(
                      orderModel.status == "paid"
                          ? ' (In progress) '
                          : ' (On its way) ',
                      style: AppTextStyles.blue12Normal400.copyWith(
                        color: const Color.fromRGBO(59, 195, 238, 1),
                      ))
                ],
              ),
              RichText(
                  text: TextSpan(
                      text: ' \$ ',
                      style: AppTextStyles.green12Normal400,
                      children: [
                    TextSpan(
                        text: orderModel.amount!.total!.toStringAsFixed(2),
                        style: AppTextStyles.green14Normal400)
                  ]))
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: Get.width * 0.266,
                  height: Get.height * 0.0394,
                  child: ProductPreviewRow(orderModel.products!)),
              GestureDetector(
                onTap: () => onClick(orderModel),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                      color: AppColors.blue.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(14)),
                  child: const Text(
                    'View',
                    style: AppTextStyles.blue13Normal400,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
