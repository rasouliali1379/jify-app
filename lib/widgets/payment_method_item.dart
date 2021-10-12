import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/enums/payment_enum.dart';
import 'package:jify_app/widgets/custom_radio_button.dart';

class PaymentMethodItem extends StatelessWidget {
  final Payment payment;
  final Function onClick;
  final bool selected;

  const PaymentMethodItem({required this.payment, required this.onClick, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(11),
        onTap: () => onClick(payment),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.013, horizontal: Get.width * 0.0426),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11),
              color: AppColors.white,
              border: Border.all(color: AppColors.grey)),
          child: Row(
            children: [
              CustomRadioButton(
                selected: selected,
              ),
              SizedBox(
                width: Get.width * 0.05,
              ),
              SvgPicture.asset(
                payment.icon,
                width: 25,
                // height: 25,
              ),
              SizedBox(
                width: Get.width * 0.04,
              ),
              Text(
                payment.name,
                style: AppTextStyles.darkGrey13Normal300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
