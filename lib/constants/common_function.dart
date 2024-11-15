import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/widget/animated_dialog.dart';



MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (final double strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

void showAnimatedDialog(String msg, String imageString,BuildContext context) {
  Get.dialog(
    Center(
      child: AnimatedDialog(
        message: msg,
        imageString: imageString,
      ),
    ),
  );
   
  // Hide the dialog after 2 seconds
  Future.delayed(const Duration(milliseconds: 1500), () {
    //Get.back();
    Navigator.of(context).pop();
    
  });
}
