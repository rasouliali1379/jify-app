import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final GestureTapCallback onClick;
  final double? height;
  final double? width;

  const CircleButton(this.child, this.color, this.onClick,
      {this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onClick,
      child: Builder(builder: (context) {
        return width != null && height != null
            ? Container(
                width: width,
                height: height,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                child: child,
              )
            : Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                child: child,
              );
      }),
    );
  }
}
