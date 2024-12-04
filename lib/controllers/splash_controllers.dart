// controllers/splash_controller.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/modals/appConfigModal.dart';
import 'package:hovee_attendence/modals/validateTokenModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/view/home_screen/guest_home_screen.dart';
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
    //  final AuthControllers classController =
    //   Get.put(AuthControllers());
    var isLoading = true.obs;
   // final AuthControllers classController =  Get.put(AuthControllers());
  @override 
  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 2), () {
      showSecondImage.value = true;
    });
    _getCurrentLocation();
    //  _checkPermissions();
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
    Future.delayed(const Duration(seconds: 5));
     final ParentController parentController = Get.put(ParentController());

    String isLoggedIn = prefs.getString('Token') ?? "";
    String rolename = prefs.getString('Rolename') ?? '';
   //Get.off(() => DashboardScreen(rolename: 'Parent'));
    print(rolename);
    if (isLoggedIn.isNotEmpty) {
      try{
           isLoading(true);
      var response = await WebService.validateToken();
      if (response != null) {
        String roleName = response.roleName!;
        bool validateToken = response.tokenValid!;
        
        if (validateToken) {
          var validateTokendata = response.data;
          
          // Create LoginData object and save it in SharedPreferences
          LoginData loginData = LoginData(
            firstName: validateTokendata!.firstName,
            lastName: validateTokendata.lastName,
            wowId: validateTokendata.wowId,
          );
           prefs.setString('userData', jsonEncode(loginData.toJson()));
            //classController.getUserData();
          // Navigate to Dashboard
          parentController. getUserTokenList(response.data!.sId!);
          Get.off(() => DashboardScreen(rolename: roleName));
        } else {
          // Navigate to Login Screen
          Get.off(() => LoginSignUp());
        }
      } else {
        // Navigate to Login Screen
        Get.off(() => LoginSignUp());
      }
      }catch (e) {
    // Handle errors if needed
  } finally {
    isLoading(false);
  }
      
    } else {
      Get.to(()=>GuestHomeScreen());
      // Get.offAll(() => const LoginSignUp());
    }
  } catch (e) {
    Logger().e(e);
  }
}


  //   Future<void> _checkPermissions() async {
  //   var status = await Permission.location.status;
  //   if (status.isGranted) {
  //     _getCurrentLocation();
  //   } else {
  //     var result = await Permission.location.request();
  //     if (result.isGranted) {
  //       _getCurrentLocation();
  //     } else {
  //       // Handle the case when the user denies the permission
  //     }
  //   }
  // }

  Future<void> _getCurrentLocation() async {
    try {
      

        Position position = await _determinePosition();

      // Position position = await Geolocator.getCurrentPosition(
      //     desiredAccuracy: LocationAccuracy.high);
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

   Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool locationServiceRequest = await Geolocator.openLocationSettings();
      if (!locationServiceRequest) {
        throw 'Location services are disabled.';
      }
      // Wait for the user to enable location services
      await Future.delayed(Duration(seconds: 1));
      // throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }

    return await Geolocator.getCurrentPosition();
  }
}
