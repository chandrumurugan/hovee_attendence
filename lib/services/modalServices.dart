import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';

class ModalService {
  static void openIDProofModalSheet(BuildContext context, SplashController splashController, dynamic authController) {
   
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          // Check if the ID Proofs are available in appConfig
          var idProofs = splashController.appConfig.value.data?.idProof ?? [];
             const double itemHeight = 56.0; // Height for each RadioListTile
    const double maxHeight = 400.0; // Maximum height of the bottom sheet
    final double sheetHeight = (idProofs.length * itemHeight).clamp(0, maxHeight);
          // Return a ListView of ID Proofs with Radio Buttons
          return SizedBox(
            height: sheetHeight, // Set a fixed height for the modal sheet
            child: ListView.separated(
              itemCount: idProofs.length,
              separatorBuilder: (context, index) =>  Container(), // Add a separator between items
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 40,
                  child: RadioListTile<String>(
                    title: Text(idProofs[index].label!), // Display the ID Proof name
                    value: idProofs[index].label!,
                    groupValue: authController.selectedIDProof.value, // Track the selected ID Proof
                    onChanged: (value) {
                      authController.selectedIDProof.value = value!; // Update the selected value
                      authController.idProofController.text = value; // Update the text field
                      Navigator.pop(context); // Close the bottom sheet after selection
                    },
                  ),
                );
              },
            ),
          );
        });
      },
    );
  }
}
