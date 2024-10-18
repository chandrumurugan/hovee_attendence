import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/modals/loginModal.dart';
import 'package:hovee_attendence/modals/otpModal.dart';
import 'package:hovee_attendence/modals/regiasterModal.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/loginSignup/otp_screen.dart';
import 'package:logger/logger.dart';
import 'package:get_storage/get_storage.dart';

class AuthControllers extends GetxController
    with GetSingleTickerProviderStateMixin {
  final box = GetStorage();

  late TabController tabController;
  var currentTabIndex = 0.obs;
  //login
  final logInController = TextEditingController();
//signup
  final phController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();

  final pincodeController = TextEditingController();
  final otpController = TextEditingController();
  final focusNode = FocusNode();
  final idProofController = TextEditingController();

  var selectedIDProof = ''.obs;
  var acceptedTerms = false.obs;
  var isTickedWhatsApp = false.obs;

  // var isLoading = false.obs;
  RxBool isLoading = false.obs;

  var loginResponse = LoginModal().obs;
  var registerResponse = RegisterModal().obs;
  var otpResponse = OtpModal().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  bool validateFields() {
    if (firstNameController.text.isEmpty) {
      Get.snackbar('Validation Error', 'First name cannot be empty');
      return false;
    }
    if (lastNameController.text.isEmpty) {
      Get.snackbar('Validation Error', 'First name cannot be empty');
      return false;
    }
    if (emailController.text.isEmpty) {
      Get.snackbar('Validation Error', 'Email cannot be empty');
      return false;
    }
    if (dobController.text.isEmpty) {
      Get.snackbar('Validation Error', 'DOB cannot be empty');
      return false;
    }

    if (phController.text.isEmpty) {
      Get.snackbar('Validation Error', 'Phone no cannot be empty');
      return false;
    }

    if (pincodeController.text.isEmpty) {
      Get.snackbar('Validation Error', 'Pincode cannot be empty');
      return false;
    }
    if (!acceptedTerms.value) {
      Get.snackbar(
          'Validation Error', 'Please accept the terms and conditions');
      return false;
    }

    if (selectedIDProof.value.isEmpty && idProofController.text.isEmpty) {
      Get.snackbar('Validation Error', 'Please select the Id proof');
      return false;
    }

    // Add more validation as needed
    return true;
  }

  bool validateLogin() {
    if (logInController.text.isEmpty) {
      Get.snackbar(
          'Validation Error', 'Phone number or Email ID cannot be empty.');
      return false;
    }
    return true;
  }

  bool validateOtp() {
    if (otpController.text.isEmpty) {
      Get.snackbar('Validation Error', 'Otp cannot be empty.');
      return false;
    }
    return true;
  }

  void logIn(String identifiers) async {
    if (validateLogin()) {
      isLoading.value = true;
      try {
        var response = await WebService.login(identifiers);
        if (response != null) {
          loginResponse.value = response;
          isLoading.value = false;
          Get.to(() => OtpScreen());
        } else {
          Logger().e('Failed to load AppConfig');
          isLoading.value = false;
        }
      } catch (e) {
        Logger().e(e);
      }
    }
  }

  void signIn() async {
    if (validateFields()) {
      isLoading.value = true;
      try {
        var response = await WebService.Register(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: emailController.text,
            dob: dobController.text,
            phNo: phController.text,
            pincode: pincodeController.text,
            idProof: selectedIDProof.value);

        if (response != null) {
          registerResponse.value = response;
          isLoading.value = false;
          Get.to(() => OtpScreen());
        } else {
          Logger().e('Failed to load AppConfig');
          isLoading.value = false;
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<int?> otp() async {
    if (validateOtp()) {
      isLoading.value = true;
      try {
        // Logger().i("moving to otp ===>$");
        var response = await WebService.otp(otpController.text,
        currentTabIndex.value == 0 ? loginResponse.value.accountVerificationToken! :
            registerResponse.value.data!.accountVerificationToken!);
        if (response != null) {
          Logger().i(response.data);
          otpResponse.value = response!;
          box.write('Token', response.token);

          isLoading.value = false;
          return response.statusCode;
        } else {
          isLoading.value = false;
          return null;
        }

        //    Get.snackbar(
        // '', response.message!);
      } catch (e) {
        print(e);
        return null;
      }
    }
  }
}
