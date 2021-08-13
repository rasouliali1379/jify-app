import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';
import 'package:jify_app/models/address_model.dart';

class AddressItem extends StatelessWidget {
  final AddressModel addressModel;
  final bool selected;
  final Function onClick;
  final String icon;
  final bool editMode;
  final Function editAddress;

  const AddressItem(
      this.addressModel, this.onClick, this.icon, this.editAddress,
      {required this.selected, required this.editMode});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(addressModel),
      child: Container(
        width: double.maxFinite,
        height: Get.height * 0.0612,
        margin: EdgeInsets.symmetric(
            vertical: Get.height * 0.0123, horizontal: Get.width * 0.0453),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.blue.withOpacity(0.15),
              ),
              child: SvgPicture.asset(
                icon,
                color: AppColors.blue,
              ),
            ),
            SizedBox(
              width: Get.width * 0.0373,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      addressModel.address!,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.extraDarkCyan16Normal500
                          .copyWith(color: AppTextColors.darkCyan),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.011,
                  ),
                  Flexible(
                    child: Text(
                      addressModel.address!,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.extraLightBlue14Normal300,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: Get.width * 0.0373,
            ),
            if (editMode)
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () => editAddress(addressModel),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.edit,
                    color: AppColors.blue,
                  ),
                ),
              )
            else
              Visibility(
                visible: selected,
                child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.blue),
                  width: 22,
                  height: 22,
                  child: Container(
                    margin: const EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.blue,
                        border: Border.all(color: AppColors.white, width: 3)),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
