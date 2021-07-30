import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class PhoneNumberTextField extends StatefulWidget {
  final TextEditingController controller;

  const PhoneNumberTextField(this.controller);

  @override
  _PhoneNumberTextFieldState createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField>
    with SingleTickerProviderStateMixin {
  bool activated = false;
  late Animation<Color?> _colorTween;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _colorTween = ColorTween(
      begin: AppColors.grey,
      end: AppColors.blue,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.0591,
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0373),
      decoration: BoxDecoration(
          border: Border.all(
            color: _colorTween.value!,
          ),
          borderRadius: BorderRadius.circular(11)),
      child: Row(
        children: [
          Image.asset(
            'assets/images/germany.png',
            width: 18,
            height: 18,
          ),
          SizedBox(
            width: Get.width * 0.0266,
          ),
          const Text(
            '+14',
            style: AppTextStyles.darkGrey13Normal300,
          ),
          SizedBox(
            width: Get.width * 0.0346,
          ),
          VerticalDivider(
            color: _colorTween.value,
            thickness: 1,
            width: 0,
          ),
          SizedBox(
            width: Get.width * 0.0453,
          ),
          Expanded(
              child: Focus(
            onFocusChange: focusChangeHandler,
            child: TextField(
                style: AppTextStyles.darkGrey14Normal300,
                controller: widget.controller,
                keyboardType: TextInputType.phone,
                cursorHeight: 20,
                cursorColor: AppColors.blue,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                )),
          ))
        ],
      ),
    );
  }

  void focusChangeHandler(bool focus) {
    print(focus);

    if (focus) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
