import 'package:flutter/material.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final GestureTapCallback onClick;

  const ClickableText(this.text, this.onClick);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
          onTap: onClick,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: AppTextStyles.blue14Normal400,
            ),
          )),
    );
  }
}
