import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/modals/regiasterModal.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:logger/logger.dart';

class ParentAccountSetupController extends GetxController
    with GetSingleTickerProviderStateMixin {

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

var registerResponse = RegisterModal().obs;

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _populateFieldsFromAuth();
  }

  void _populateFieldsFromAuth() {
    phController.text = parentController.otpResponse.value.userDetail!.phoneNumber!;
  
  }

    bool validateFields(BuildContext context) {
    if (firstNameController.text.isEmpty) {
       SnackBarUtils.showErrorSnackBar(context, 'Please enter the first name.');
      return false;
    }
    if (lastNameController.text.isEmpty) {
        SnackBarUtils.showErrorSnackBar(context,'Please enter the last name.',);
      return false;
    }
    if (emailController.text.isEmpty) {
        SnackBarUtils.showErrorSnackBar(context,'Please enter the email.',);
      return false;
    }
    // Email format validation
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
       SnackBarUtils.showErrorSnackBar(context,'Invalid email format',);
      return false;
    }

    if (dobController.text.isEmpty) {
        SnackBarUtils.showErrorSnackBar(context,'Please select the DOB.',);
      return false;
    }

    if (phController.text.isEmpty) {
       SnackBarUtils.showErrorSnackBar(context,'Please enter the phone number.',);
      return false;
    }
    // Phone number format validation (10 digits)
    if (!RegExp(r'^[0-9]{10}$').hasMatch(phController.text)) {
        SnackBarUtils.showErrorSnackBar(context,'Invalid mobile number',);
      return false;
    }

    if (pincodeController.text.isEmpty) {
        SnackBarUtils.showErrorSnackBar(context,'Please enter the pincode.',);
      return false;
    }

    // if (pincodeController.text.length <10) {
    //    SnackBarUtils.showSuccessSnackBar(context,'Invalid pincode.',);
    //   return false;
    // }

    if (!acceptedTerms.value) {
      SnackBarUtils.showErrorSnackBar(context,'Please accept the checkbox to proceed',);
      return false;
    }

    if (selectedIDProof.value.isEmpty && idProofController.text.isEmpty) {
       SnackBarUtils.showErrorSnackBar(context,'Please select the Id proof',);
      return false;
    }

    // Add more validation as needed
    return true;
  }

    void signIn(BuildContext context) async {
    if (validateFields(context)) {
      isLoading.value = true;
      try {
        var response = await WebService.RegisterParent(
            context: context,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: emailController.text,
            dob: dobController.text,
            phNo: phController.text,
            pincode: pincodeController.text,
            idProof: selectedIDProof.value);

        if (response != null) {
          registerResponse.value = response;
              phController.clear();
     firstNameController.clear();
      lastNameController.clear();
       emailController.clear();
        dobController.clear();
         pincodeController.clear();
          //otpController.clear();
            idProofController.clear();
            acceptedTerms.value=false;
            selectedIDProof.value='';
        
          isLoading.value = false;
         // Get.to(() => Das());
        } else {
          Logger().e('Failed to load AppConfig');
          isLoading.value = false;
        }
      } catch (e) {
        print(e);
      }
    }
  }
     }