

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';

class ModalService {
  static void openIDProofModalSheet(BuildContext context, SplashController splashController,AuthControllers authController) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          // Check if the ID Proofs are available in appConfig
          var idProofs = splashController.appConfig.value.data?.idProof ?? [];

          // Return a ListView of ID Proofs with Radio Buttons
          return SizedBox(
            height: 300, // Set a fixed height for the modal sheet
            child: ListView.builder(
              itemCount: idProofs.length,
              itemBuilder: (context, index) {
                return RadioListTile<String>(
                  title: Text(idProofs[index].label!), // Display the ID Proof name
                  value: idProofs[index].label!,
                  groupValue: authController.selectedIDProof.value, // Track the selected ID Proof
                  onChanged: (value) {
                    authController.selectedIDProof.value = value!; // Update the selected value
                    authController.idProofController.text = value; // Update the text field
                    Navigator.pop(context); // Close the bottom sheet after selection
                  },
                );
              },
            ),
          );
        });
      },
    );
  }


}