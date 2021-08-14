import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jify_app/constants/app_colors.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class ExpandableContainer extends StatefulWidget {
  final String title;
  final String content;

  const ExpandableContainer(this.title, this.content);

  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer>
    with SingleTickerProviderStateMixin {
  bool expanded = false;

  late AnimationController _rotationController;

  @override
  void initState() {
    _rotationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: double.maxFinite,
      height: expanded ? Get.height * 0.18 : Get.height * 0.07,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          border: Border.all(color: AppColors.milky),
          color: AppColors.lightRed),
      padding: EdgeInsets.symmetric(
          vertical: Get.height * 0.02, horizontal: Get.width * 0.0533),
      duration: const Duration(milliseconds: 200),
      child: Column(
        children: [
          GestureDetector(
            onTap: expandContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: AppTextStyles.extraDarkCyan14Normal500,
                ),
                RotationTransition(
                  turns:
                      Tween(begin: 0.0, end: 0.5).animate(_rotationController),
                  child: const RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.darkCyan,
                        size: 20,
                      )),
                )
              ],
            ),
          ),
          Visibility(
            visible: expanded,
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.016,
                ),
                Text(
                  widget.content,
                  style: AppTextStyles.black12Normal400.copyWith(
                      height: 1.6, color: AppTextColors.black.withOpacity(0.7)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void expandContainer() {
    setState(() {
      expanded = !expanded;
      if (expanded) {
        _rotationController.forward();
      } else {
        _rotationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }
}
