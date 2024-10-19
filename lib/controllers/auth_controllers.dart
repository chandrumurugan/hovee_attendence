import 'dart:async';

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

  var _start = 30.obs; // Reactive variable to hold the timer value
  var _isTimerRunning =
      true.obs; // Reactive variable to track if the timer is running
  Timer? _timer;

  int get timerValue => _start.value; // Getter for timer value
  bool get isTimerRunning => _isTimerRunning.value; // Getter for timer state

  bool validateFields() {
    if (firstNameController.text.isEmpty) {
      Get.snackbar('Validation Error', 'First name cannot be empty');
      return false;
    }
    if (lastNameController.text.isEmpty) {
      Get.snackbar('Validation Error', 'Last name cannot be empty');
      return false;
    }
    if (emailController.text.isEmpty) {
      Get.snackbar('Validation Error', 'Email cannot be empty');
      return false;
    }
    // Email format validation
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
      Get.snackbar('Validation Error', 'Invalid email fomat');
      return false;
    }

    if (dobController.text.isEmpty) {
      Get.snackbar('Validation Error', 'DOB cannot be empty');
      return false;
    }

    if (phController.text.isEmpty) {
      Get.snackbar('Validation Error', 'Phone number cannot be empty');
      return false;
    }
    // Phone number format validation (10 digits)
    if (!RegExp(r'^[0-9]{10}$').hasMatch(phController.text)) {
      Get.snackbar('Validation Error', 'Invalid number');
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
    String input = logInController.text.trim();

    if (input.isEmpty) {
      Get.snackbar(
          'Validation Error', 'Phone number or Email ID cannot be empty.');
      return false;
    }

    // Check if the input is a phone number (10 digits)
    if (RegExp(r'^[0-9]+$').hasMatch(input)) {
      if (input.length != 10) {
        Get.snackbar(
            'Validation Error', 'Phone number must be exactly 10 digits.');
        return false;
      }
      return true; // It's a valid phone number
    }

    // Check if the input is a valid email format
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input)) {
      Get.snackbar('Validation Error', 'Please enter a valid email address.');
      return false;
    }

    // If the input is a valid email
    return true;
  }

  bool validateOtp() {
    if (otpController.text.isEmpty) {
      Get.snackbar('Validation Error', 'Please enter the OTP');
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
        var response = await WebService.otp(
            otpController.text,
            currentTabIndex.value == 0
                ? loginResponse.value.accountVerificationToken!
                : registerResponse.value.data!.accountVerificationToken!);
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

  // Function to start the timer
  void startTimer() {
    _start.value = 30; // Reset the timer value
    _isTimerRunning.value = true;
    const oneSec = Duration(seconds: 1);
    _timer?.cancel(); // Cancel any previous timer if running
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start.value == 0) {
        _isTimerRunning.value = false;
        timer.cancel();
      } else {
        _start.value--;
      }
    });
  }

  // Function to resend OTP
  Future<void> resendOtp() async {
    // Add your resend OTP logic here
    // After successful resend, restart the timer
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel timer when controller is closed
    super.onClose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }
  
}
