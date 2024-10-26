import 'package:flutter/material.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';

class ButtonSplashEffect extends StatelessWidget {
  const ButtonSplashEffect({
    super.key,
    required this.borderRadius,
    this.color,
    required this.onTapped,
    required this.widget,
    this.onTapDown,
  });

  final Widget widget;
  final double borderRadius;
  final Color? color;
  final VoidCallback onTapped;
  final onTapDown;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Material(
          color: Colors.transparent,
          child: onTapDown == null
              ? InkWell(
                  splashColor: color ??AppConstants.secondaryColor,
                  splashFactory: InkRipple.splashFactory,
                  borderRadius: BorderRadius.circular(borderRadius),
                  onTap: onTapped,
                  child: widget)
              : InkWell(
                  splashColor: color ??AppConstants. secondaryColor,
                  splashFactory: InkRipple.splashFactory,
                  borderRadius: BorderRadius.circular(borderRadius),
                  onTapDown: onTapDown,
                  child: widget),
        ),
      ),
    );
  }
}
