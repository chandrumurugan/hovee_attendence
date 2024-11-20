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
        child: CustomSnackBar.success(message: message,backgroundColor: Color.fromRGBO(186, 1, 97, 1),)),
    );
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      SizedBox(
        height: 60,
        child: CustomSnackBar.error(message: message)),
    );
  }
}
