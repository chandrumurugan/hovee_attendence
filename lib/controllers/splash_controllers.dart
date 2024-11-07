// controllers/splash_controller.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovee_attendence/modals/appConfigModal.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/home_screen/tutor_home_screen.dart';
import 'package:hovee_attendence/view/loginSignup/loginSingup.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

// import '../services/webservice.dart';
// import '../views/dashboard.dart';
// import '../views/login_screen.dart';

class SplashController extends GetxController {
  var showSecondImage = false.obs;
  var appConfig = AppConfig().obs;
  final box = GetStorage();
 final int _steps = 100; 
 var progressValue = 0.0.obs;
  final Duration _loadingDuration =
      const Duration(seconds: 3);
       var currentLocation = Rxn<LatLng>();
  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 2), () {
      showSecondImage.value = true;
    });
     _checkPermissions();
   fetchAppConfig();
  }

  Future<void> fetchAppConfig() async {
    final stepDuration = _loadingDuration ~/ _steps;
    try {
      var response = await WebService.fetchAppConfig();
      if (response != null) {
        appConfig.value = response;
       // Store the response data in GetStorage
      final storage = GetStorage();
      storage.write('appConfig', response.toJson());
      for (int i = 0; i <= _steps; i++) {
     
        progressValue.value = i / _steps; // Update progress value for each step
    
      await Future.delayed(stepDuration);
    }
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

    Future<void> _checkPermissions() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      var result = await Permission.location.request();
      if (result.isGranted) {
        _getCurrentLocation();
      } else {
        // Handle the case when the user denies the permission
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentLocation.value = LatLng(position.latitude, position.longitude);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('latitude', position.latitude);
      await prefs.setDouble('longitude', position.longitude);
       Get.log("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
    } catch (e) {
      print('Error fetching location: $e');
      // Handle error fetching location
    }
  }
}
