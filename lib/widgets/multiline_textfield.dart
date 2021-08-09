import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class MultilineTextField extends StatefulWidget {
  final TextEditingController controller;
  final String errorText;
  final double? height;
  final Color? bgColor;
  final String hint;

  const MultilineTextField(this.controller,
      {this.errorText = "", this.height, this.bgColor, this.hint = ""});

  @override
  _MultilineTextFieldState createState() => _MultilineTextFieldState();
}

class _MultilineTextFieldState extends State<MultilineTextField>
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: widget.height ?? Get.height * 0.0591,
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.0373),
          decoration: BoxDecoration(
              color: widget.bgColor,
              border: Border.all(
                color: widget.errorText.isNotEmpty
                    ? AppColors.red
                    : _colorTween.value!,
              ),
              borderRadius: BorderRadius.circular(11)),
          child: TextField(
              style: AppTextStyles.darkGrey14Normal300,
              controller: widget.controller,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              cursorHeight: 20,
              cursorColor: AppColors.blue,
              decoration: InputDecoration(
                hintText: widget.hint,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              )),
        ),
        SizedBox(
          height: Get.height * 0.015,
        ),
        Visibility(
            visible: widget.errorText.isNotEmpty,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Text(
                widget.errorText,
                style: AppTextStyles.red10Normal300,
              ),
            ))
      ],
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
