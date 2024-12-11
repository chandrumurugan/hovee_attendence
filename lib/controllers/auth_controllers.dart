import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:hovee_attendence/modals/loginModal.dart';
import 'package:hovee_attendence/modals/login_data_model.dart';
import 'package:hovee_attendence/modals/otpModal.dart';
import 'package:hovee_attendence/modals/regiasterModal.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/home_screen/tutor_home_screen.dart';
import 'package:hovee_attendence/view/loginSignup/otp_screen.dart';
import 'package:logger/logger.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  RxBool isOtpResent = false.obs;

  var _start = 30.obs; // Reactive variable to hold the timer value
  var _isTimerRunning =
      true.obs; // Reactive variable to track if the timer is running
  Timer? _timer;

  int get timerValue => _start.value; // Getter for timer value
  bool get isTimerRunning => _isTimerRunning.value; // Getter for timer state

  RxBool isChecked = false.obs;
  final SplashController splashController = Get.put(SplashController(parentId: '', phoneNumber: '',));

  LoginData? loginData;

  final ParentController parentController = Get.put(ParentController());

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

  bool validateLogin(BuildContext context) {
    String input = logInController.text.trim();

    if (input.isEmpty) {
        SnackBarUtils.showErrorSnackBar(context,'Please enter the phone number / \n email ID',);
      return false;
    }

    // Check if the input is a phone number (10 digits)
    if (RegExp(r'^[0-9]+$').hasMatch(input)) {
      if (input.length != 10) {
         SnackBarUtils.showErrorSnackBar(context,'Invalid Phone number',);
        return false;
      }
      return true; // It's a valid phone number
    }

    // Check if the input is a valid email format
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(input)) {
      SnackBarUtils.showErrorSnackBar(context,'Invalid email address.',);
      return false;
    }

    // If the input is a valid email
    return true;
  }

  bool validateOtp(BuildContext context) {
    if (otpController.text.isEmpty) {
       SnackBarUtils.showErrorSnackBar(context,'Please enter the OTP',);
      return false;
    }
    return true;
  }

  void logIn(String identifiers, BuildContext context) async {
    if (validateLogin(context)) {
      isLoading.value = true;
      try {
        var response = await WebService.login(identifiers, context);
        if (response != null) {
          loginResponse.value = response;
          isLoading.value = false;
            logInController.clear();
            isChecked.value=false;
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

  void signIn(BuildContext context) async {
    if (validateFields(context)) {
      isLoading.value = true;
      try {
        var response = await WebService.Register(
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
          otpController.clear();
            idProofController.clear();
            acceptedTerms.value=false;
            selectedIDProof.value='';
        
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

  Future<OtpModal?> otp(BuildContext context) async {
    if (validateOtp(context)) {
      isLoading.value = true;
      try {
        // Logger().i("moving to otp ===>$");
         SharedPreferences prefs = await SharedPreferences.getInstance();
        var response = await WebService.otp(
            otpController.text,
           
            currentTabIndex.value == 0 ||  isOtpResent.value 
                ? loginResponse.value.accountVerificationToken!
                : registerResponse.value.data!.accountVerificationToken!,
            context);
        if (response != null) {
          Logger().i(response.data);
          otpResponse.value = response;
          prefs.setString('Token', response.token!);
          prefs.setString('Rolename', response.data!.roles!.roleName??'');
           var validateTokendata = response.data!;
            //if(response.parentData=='true'){
              parentController.fetchHomeDashboardTuteeList();
               parentController. getUserTokenList(response.data!.sId!);
           // }
        
          LoginData loginData = LoginData(
            firstName: validateTokendata!.firstName,
            lastName: validateTokendata.lastName,
            wowId: validateTokendata.wowId,
          );
          prefs.setString('userData', jsonEncode(loginData.toJson()));
          getUserData();
         
          // box.write('Token', response.token);
          //  box.write('Rolename', response.data!.roles!.roleName);
          // var validateTokendata = response.data!;
          //  box.write('ValidateTokenData', validateTokendata);
          isLoading.value = false;
          return response;
        } else {
          isLoading.value = false;
          return null;
        }

        //     Get.snackbar(
        // '', response.message!);
      } catch (e) {
        print(e);
        return null;
      }
    }
    return null;
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
  Future<void> resendOtp(BuildContext context) async {
    // Add your resend OTP logic here
    // After successful resend, restart the timer
   
    try {
      var response = await WebService.resendOtp(
        context: context,
        accountToken: currentTabIndex.value == 0
            ? loginResponse.value.accountVerificationToken!
            : registerResponse.value.data!.accountVerificationToken!,
      );
      if (response != null) {
        isOtpResent(true);
        loginResponse.value = response;
        isLoading.value = false;
         startTimer();
        // Get.to(() => OtpScreen());
      } else {
        Logger().e('Failed to load AppConfig');
        isLoading.value = false;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel timer when controller is closed
    logInController.dispose();
    phController.dispose();
     firstNameController.dispose();
      lastNameController.dispose();
       emailController.dispose();
        dobController.dispose();
         pincodeController.dispose();
          otpController.dispose();
           focusNode.dispose();
            idProofController.dispose();
    super.onClose();
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    getForLaterUse();
    getUserData();
  }

Future<void> saveForLaterUse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isChecked.value) {
      await prefs.setString(
          'rememberUserNo',logInController.text);
    }
  }

  Future<void> removeLaterUse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('rememberUserNo', "");
  }

Future<void> getForLaterUse() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    logInController.text= prefs.getString('rememberUserNo')??''; 
  }
  
  Future<void> getUserData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
 // To retrieve the data later:
String? jsonString = prefs.getString('userData');
if (jsonString != null) {
  try {
     loginData = LoginData.fromJson(jsonDecode(jsonString));
    print("Hello ${loginData!.firstName}, ${loginData!.lastName}");
  } catch (e) {
    print("Error decoding JSON: $e");
  }


  }
  
  }
    }