import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class ChangeAddressContainer extends StatelessWidget {
  final GestureTapCallback onClick;

  const ChangeAddressContainer(this.onClick);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.orange,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SvgPicture.asset(
                'assets/icons/alert.svg',
                width: 18,
                height: 18,
              ),
              const SizedBox(
                width: 5,
              ),
              const Text('Your address is not in range',
                  style: AppTextStyles.white14Normal700),
            ],
          ),
          GestureDetector(
            onTap: onClick,
            child: Container(
                decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(13)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Text(
                    'Change Address',
                    style: AppTextStyles.white12Normal700,
                    textAlign: TextAlign.center,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
