import 'package:flutter/material.dart';
import 'package:hovee_attendence/widget/font_style.dart';


Widget regularText(
    {required String text,
    Color? color,
    TextOverflow? textOverflow,
    TextAlign? textAlign,
    int? maxlines,
    double? fontSize,
    double? linespace}) {
  return Text(
    text,
    overflow: textOverflow,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxlines,
    style: FontType.normal.style(
      size: fontSize ?? 16,
      color: color ?? Color(0xff131313),
      appFontFamilyName: 'Poppins',
      lineSpace: linespace ?? 1.4,
    ),
  );
}

Widget subText({
  required String text,
  Color? color,
  double? fontSize,
  TextOverflow? textOverflow,
  TextAlign? textAlign,
  int? maxlines,
  FontStyle? fontStyle,
  TextDecoration? textDecoration,
}) {
  return Text(
    text,
    overflow: textOverflow,
    textAlign: textAlign ?? TextAlign.start,
    maxLines: maxlines,
    style: FontType.small.style(
      size: fontSize ?? 14,
      color: color ?? Color(0xffa5a5a5),
      fontStyle: fontStyle ?? FontStyle.italic,
      lineSpace: 1.4,
      decoration: textDecoration ?? TextDecoration.none,
      shadows: [
        Shadow(
          blurRadius: 0.2,
          color: Color(0xffa5a5a5),
          offset: const Offset(0.2, 0.2),
        ),
      ],
    ),
  );
}
