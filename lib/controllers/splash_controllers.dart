// controllers/splash_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/modals/appConfigModal.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/home_screen/tutor_home_screen.dart';
import 'package:hovee_attendence/view/loginSignup/loginSingup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

// import '../services/webservice.dart';
// import '../views/dashboard.dart';
// import '../views/login_screen.dart';

class SplashController extends GetxController {
  var showSecondImage = false.obs;
  var appConfig = AppConfig().obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 3), () {
      showSecondImage.value = true;
    });
    fetchAppConfig();
  }

  Future<void> fetchAppConfig() async {
    try {
      var response = await WebService.fetchAppConfig();
      if (response != null) {
        appConfig.value = response;
        final storage = GetStorage();
      storage.write('qualifications', response.data!.highestQualification.map((e) => e.label).where((label) => label != null).map((label) => label!).toList());
      storage.write('skills', response.data!.teachingSkill.map((e) => e.label).where((label) => label != null).map((label) => label!).toList());
      storage.write('techs', response.data!.teaching.map((e) => e.label).where((label) => label != null).map((label) => label!).toList());
      storage.write('techsExperience', response.data!.workExperience.map((e) => e.label).where((label) => label != null).map((label) => label!).toList());
      storage.write('batchDays', response.data!.batchDays.map((e) => e.label).where((label) => label != null).map((label) => label!).toList());
      storage.write('batchModes', response.data!.batchMode.map((e) => e.label).where((label) => label != null).map((label) => label!).toList());
      storage.write('idProof', response.data!.idProof.map((e) => e.label).where((label) => label != null).map((label) => label!).toList());
      storage.write('studenTeacher', response.data!.studentCategory.map((e) => e.label).where((label) => label != null).map((label) => label!).toList());
         Future.delayed(const Duration(seconds: 2), () {
        checkUserLoggedIn(); // Navigate after 2 seconds
      });
        // checkUserLoggedIn();
        Logger().i('AppConfig loaded successfully');
      } else {
        Logger().e('Failed to load AppConfig');
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> checkUserLoggedIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('user_token');
      Future.delayed(const Duration(seconds: 5));
      String isLoggedIn = box.read('Token') ?? "";
        Get.offAll(() => const LoginSignUp());
      // if(isLoggedIn.isNotEmpty){
      //      Get.offAll(() =>  TutorHome());
      // }else{
      //      Get.offAll(() => const LoginSignUp());
      // }

      // if (token != null && token.trim().isNotEmpty) {
      //   bool response = await WebService.validateToken();
      //   if (response) {
      //     // Navigate to Dashboard
      //     Get.off(() => DashBoard(
      //           parent: false,
      //           guestuser: false,
      //           tutor: false,
      //           studentOrParent: true,
      //           hosteller: false,
      //         ));
      //   } else {
      //     // Navigate to Login Screen
      //     Get.off(() => SignupLogin());
      //   }
      // } else {
      //   // Navigate to Login Screen
      //   Get.off(() => SignupLogin());
      // }
    } catch (e) {
      Logger().e(e);
    }
  }
}
