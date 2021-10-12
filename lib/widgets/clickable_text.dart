import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jify_app/constants/app_text_styles.dart';

class ClickableText extends StatelessWidget {
  final String text;
  final GestureTapCallback onClick;
  final TextStyle? style;
  final String? icon;

  const ClickableText(this.text, this.onClick, {this.style, this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onClick,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: [
                if (icon != null) ...[
                  SvgPicture.asset(icon!),
                  const SizedBox(
                    width: 6,
                  )
                ],
                Text(
                  text,
                  style: style ?? AppTextStyles.blue14Normal400,
                ),
              ],
            ),
          )),
    );
  }
}
