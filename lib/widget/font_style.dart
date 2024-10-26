import 'package:flutter/material.dart';

enum FontType { small, normal, bold, extraBold }

extension FontTypeExtn on FontType {
  TextStyle style({
    double? size,
    Color? color,
    double? lineSpace,
    TextDecoration? decoration,
    String? appFontFamilyName,
    List<Shadow>? shadows,
    FontStyle? fontStyle,
  }) {
    FontWeight weight = FontWeight.normal;

    switch (this) {
      case FontType.small:
        weight = FontWeight.w200;
        break;
      case FontType.normal:
        weight = FontWeight.w500;
        break;
      case FontType.bold:
        weight = FontWeight.w700;
        break;
      case FontType.extraBold:
        weight = FontWeight.w900;
        break;
    }

    return TextStyle(
      decoration: decoration,
      fontSize: size ?? 16,
      color: color,
      height: lineSpace,
      fontWeight: weight,
      fontStyle: fontStyle,
      fontFamily: appFontFamilyName ?? 'Lato',
      shadows: shadows,
    );
  }
}
