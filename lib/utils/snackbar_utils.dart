import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class SnackBarUtils {
  static void showInfoSnackBar(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      SizedBox(
         height: 60,
        child: CustomSnackBar.info(
          message: message,
          textAlign: TextAlign.left,
          icon: Icon(Icons.check_circle,color: Colors.white,),
        iconPositionLeft: 30,iconPositionTop: -10,iconRotationAngle: 0,
          textStyle: TextStyle(fontWeight: FontWeight.normal,color: Colors.white),
          backgroundColor: Colors.yellow,
        ),
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      SizedBox(
         height: 60,
        child: CustomSnackBar.success(message: message, icon: Icon(Icons.check_circle,color: Colors.white,size: 40,),iconPositionLeft: 30,iconPositionTop: -18,iconRotationAngle: 0,textAlign: TextAlign.left,textStyle: TextStyle(fontWeight: FontWeight.normal,color: Colors.white,fontSize: 18),backgroundColor: Color.fromRGBO(186, 1, 97, 1),)),
    );
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      SizedBox(
        height: 60,
        child: CustomSnackBar.error(message: message,icon: Icon(Icons.info,color: Colors.white,size: 40,),iconPositionLeft: 30,iconPositionTop: -18,iconRotationAngle: 0,textAlign: TextAlign.left,textStyle: TextStyle(fontWeight: FontWeight.normal,color: Colors.white,fontSize: 18),backgroundColor: Color.fromRGBO(186, 1, 97, 1),)),
    );
  }
}
