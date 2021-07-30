import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final GestureTapCallback onClick;

  const CircleButton(this.child, this.color, this.onClick);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: const CircleBorder(),
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: child,
      ),
    );
  }
}
