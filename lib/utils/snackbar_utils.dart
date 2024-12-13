import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:alert_banner/exports.dart';

class SnackBarUtils {
  static void showInfoSnackBar(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      SizedBox(
        height: 60,
        child: CustomSnackBar.info(
          message: message,
          textAlign: TextAlign.left,
          icon: const Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          iconPositionTop: -10,
          iconRotationAngle: 0,
          textStyle:
              const TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
          backgroundColor: Colors.yellow,
        ),
      ),
    );
  }

  static void showSuccessSnackBar(BuildContext context, String message) {
    showTopSnackBar(
      Overlay.of(context),
      SizedBox(
          height: 72,
          child: CustomSnackBar.success(
            message: message,
              maxLines: 2,
            messagePadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 44),
            icon: const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 34,
            ),
            iconPositionTop: -10,
            iconRotationAngle: 0,
            iconPositionLeft: 5,
            textAlign: TextAlign.left,
            textStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.white,
              fontSize: 14,
              overflow: TextOverflow.ellipsis,
            ),
            backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
          )),
    );
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    // showAlertBanner(
    //               context,
    //               () => print("TAPPED"),
    //               const ExampleAlertBannerChild(),
    //               alertBannerLocation: AlertBannerLocation.top,
    //               // .. EDIT MORE FIELDS HERE ...
    //             );
    showTopSnackBar(
      Overlay.of(context),
      SizedBox(
          height: 74,
          child: CustomSnackBar.error(
            message: message,
            maxLines: 2,
            messagePadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 44),
            icon: const Icon(
              Icons.info,
              color: Colors.white,
              size: 30,
            ),
            iconPositionTop: -10,
            iconRotationAngle: 0,
            iconPositionLeft: 5,
            textAlign: TextAlign.center,
            textStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontSize: 14,
                overflow: TextOverflow.ellipsis),
            backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
          )),
    );
  }
}

class ExampleAlertBannerChild extends StatelessWidget {
  const ExampleAlertBannerChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
      decoration: const BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Material(
          color: Colors.transparent,
          child: Row(
            children: [
              Icon(Icons.info),
              Text(
                "This is an example notification. It looks awesome!",
                style: TextStyle(color: Colors.white, fontSize: 18),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}