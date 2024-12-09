import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:hovee_attendence/view/loginSignup/loginSingup.dart';

class ModalService {
  static void openIDProofModalSheet(BuildContext context,
      SplashController splashController, dynamic authController) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          // Check if the ID Proofs are available in appConfig
          var idProofs = splashController.appConfig.value!.data?.iDProof ?? [];
          const double itemHeight = 56.0; // Height for each RadioListTile
          const double maxHeight = 400.0; // Maximum height of the bottom sheet
          final double sheetHeight =
              (idProofs.length * itemHeight).clamp(0, maxHeight);
          // Return a ListView of ID Proofs with Radio Buttons
          return Container(
            height: sheetHeight,
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Select ID proof",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.separated(
                    itemCount: idProofs.length,
                    separatorBuilder: (context, index) =>
                        Container(), // Add a separator between items
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 40,
                        child: RadioListTile<String>(
                          title: Text(idProofs[index]
                              .label!), // Display the ID Proof name
                          value: idProofs[index].label!,
                          groupValue: authController.selectedIDProof
                              .value, // Track the selected ID Proof
                          onChanged: (value) {
                            authController.selectedIDProof.value =
                                value!; // Update the selected value
                            authController.idProofController.text =
                                value; // Update the text field
                            Navigator.pop(
                                context); // Close the bottom sheet after selection
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
  static    Future<bool> handleBackButtonN(BuildContext context) async {
    return await showExitPopupN(context) ?? false;
  }

  // Exit confirmation dialog logic
 static Future<bool?> showExitPopupN(BuildContext context) {
    return Get.dialog<bool>(
      AlertDialog(
        title: Text('Exit'),
        content: Text('Are you sure you want to go back ?'),
        actions: [
          TextButton(
            onPressed: () {
              // If "No" is pressed, just close the dialog
              Get.back(result: false);
             
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              // If "Yes" is pressed, close the app
              Get.back(result: true);
              Future.delayed(Duration(milliseconds: 300), () {
                 Get.offAll(()=>LoginSignUp());
                // SystemNavigator.pop();
              });
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

 static   Future<bool> handleBackButton(BuildContext context) async {
    return await showExitPopup(context) ?? false;
  }

  // Exit confirmation dialog logic
 static Future<bool?> showExitPopup(BuildContext context) {
    return Get.dialog<bool>(
      AlertDialog(
        title: Text('Logout'),
        content: Text('Do you want to logout?'),
        actions: [
          TextButton(
            onPressed: () {
              // If "No" is pressed, just close the dialog
              Get.back(result: false);
             
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              // If "Yes" is pressed, close the app
              Get.back(result: true);
              Future.delayed(Duration(milliseconds: 300), () {
                 Get.offAll(()=>LoginSignUp());
                // SystemNavigator.pop();
              });
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}
