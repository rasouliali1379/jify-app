import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jify_app/constants/app_colors.dart';

class AddressContainer extends StatelessWidget {

  final Widget address;


  const AddressContainer(this.address);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkCyan,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/location.svg'),
          const SizedBox(
            width: 8,
          ),
          address
        ],
      ),
    );
  }
}
