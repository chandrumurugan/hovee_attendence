import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/modals/Regsisterparent_model.dart';
import 'package:hovee_attendence/modals/regiasterModal.dart';
import 'package:hovee_attendence/modals/update_parent_status_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentAccountSetupController extends GetxController
    with GetTickerProviderStateMixin {
  RxBool isLoading = false.obs;

  ///personal info
  final phController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();

  final pincodeController = TextEditingController();
  final idProofController = TextEditingController();
  var selectedIDProof = ''.obs;

  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final pincodesController = TextEditingController();
  final additionalInfoController = TextEditingController();

  var acceptedTerms = false.obs;
  var isTickedWhatsApp = false.obs;

  late TabController tabController;
  var currentTabIndex = 0.obs;
  RxBool isChecked = false.obs;
  final ParentController parentController = Get.put(ParentController());

  var registerResponse = RegisterParentModel().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _populateFieldsFromAuth();
  }

  void _populateFieldsFromAuth() {
    phController.text =
        parentController.otpResponse.value.parentDetail!.phoneNumber ?? '';
  }

  bool validateFields(BuildContext context) {
    if (firstNameController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Please enter the first name.');
      return false;
    }
    if (lastNameController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the last name.',
      );
      return false;
    }
    if (emailController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the email.',
      );
      return false;
    }
    // Email format validation
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Invalid email format',
      );
      return false;
    }

    if (dobController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please select the DOB.',
      );
      return false;
    }

    if (phController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the phone number.',
      );
      return false;
    }
    // Phone number format validation (10 digits)
    if (!RegExp(r'^[0-9]{10}$').hasMatch(phController.text)) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Invalid mobile number',
      );
      return false;
    }

    if (pincodeController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the pincode.',
      );
      return false;
    }

    // if (pincodeController.text.length <10) {
    //    SnackBarUtils.showSuccessSnackBar(context,'Invalid pincode.',);
    //   return false;
    // }

    // if (!acceptedTerms.value) {
    //   SnackBarUtils.showErrorSnackBar(context,'Please accept the checkbox to proceed',);
    //   return false;
    // }

    // if (selectedIDProof.value.isEmpty && idProofController.text.isEmpty) {
    //    SnackBarUtils.showErrorSnackBar(context,'Please select the Id proof',);
    //   return false;
    // }
    return true;
  }

  bool validateAddressInfo(BuildContext context) {
    if (address1Controller.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please enter the door no",
      );
      return false;
    }
    if (address2Controller.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please enter the street & area",
      );
      return false;
    }
    if (cityController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please enter the city",
      );
      return false;
    }
    if (stateController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please enter the state",
      );
      return false;
    }
    if (countryController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please enter the country",
      );
      return false;
    }
    // if (pincodesController.text.isEmpty) {
    //   SnackBarUtils.showErrorSnackBar(
    //     context,
    //     "Please enter the pincode",
    //   );
    //   return false;
    // }

    // if (pincodesController.text.length != 6) {
    //    SnackBarUtils.showSuccessSnackBar(context,'Invalid pincode.',);
    //   return false;
    // }
    return true;
  }

  void signIn(BuildContext context) async {
    if (validateAddressInfo(context)) {
      isLoading.value = true;
      try {
        final prefs = await SharedPreferences.getInstance();
        double? latitude = prefs.getDouble('latitude');
        double? longitude = prefs.getDouble('longitude');
        var response = await WebService.RegisterParent(
            context: context,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: emailController.text,
            dob: dobController.text,
            phNo: phController.text,
            pincode: pincodeController.text,
            latitude: latitude.toString(),
            longitude: longitude.toString(),
            country: countryController.text,
            state: stateController.text,
            city: cityController.text,
            street: address2Controller.text,
            doorNo: address1Controller.text);

        if (response != null) {
          registerResponse.value = response;
          phController.clear();
          firstNameController.clear();
          lastNameController.clear();
          emailController.clear();
          dobController.clear();
          pincodeController.clear();
          //otpController.clear();
          address1Controller.clear();
          address2Controller.clear();
          cityController.clear();
          stateController.clear();
          countryController.clear();

          isLoading.value = false;
          Get.dialog(
  AlertDialog(
    title: Text('Tutee Preview'),
    content: Column(
      mainAxisSize: MainAxisSize.min, // To avoid stretching the dialog unnecessarily
      children: [
        _buildRow(
          'Tutee name',
          '${response.data!.firstName} ${response.data!.lastName}',
        ),
        _buildRow('Wow ID', response.data!.wowId!),
        _buildRow('Email', response.data!.email!),
        _buildRow(
          'Phone number',
          '${response.data!.phoneNumber}',
        ),
        _buildRow('Dob', response.data!.dob!),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          updateEnrollment(
            Get.context!, // Using Get.context for context
            response.data!.sId!,
            response.data!.userId!.first,
          );
          Get.back(); // Close the dialog
        },
        child: Text('Accept'),
      ),
      TextButton(
        onPressed: () {
          Get.off(() => DashboardScreen(rolename: 'Parent'));
          Get.back(); // Close the dialog
        },
        child: Text('Reject'),
      ),
    ],
  ),
  barrierDismissible: false, // Ensures the dialog is not dismissed by tapping outside
);

        } else {
          Logger().e('Failed to load AppConfig');
          isLoading.value = false;
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  void updateEnrollment(
    BuildContext context,
    String parentId,
    String userId,
  ) async {
    isLoading.value = true;
    try {
      var batchData = {"parentId": parentId, "userId": userId};

      final UpdateParentStausModel? response =
          await WebService.updateParentStatus(batchData);

      if (response != null && response.statusCode == 200) {
        // SnackBarUtils.showSuccessSnackBar(
        //     context, 'Update enquire successfully');
        // if (response.data!.status == 'Approved') {
        // SnackBarUtils.showSuccessSnackBar(context,'You are enrolled successfully',);
        Get.snackbar(
          icon: const Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 40,
          ),
          response.message!,
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
        );
        Get.off(() => DashboardScreen(rolename: 'Parent'));
      } else {
        Get.snackbar(
          icon: const Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 40,
          ),
          response!.message!,
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
        );
      }
    } catch (e) {
      //SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
