// controllers/splash_controller.dart
import 'dart:async';
import 'dart:convert';


import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/main.dart';
import 'package:hovee_attendence/modals/appConfigModal.dart';
import 'package:hovee_attendence/services/liveLocationService.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/view/home_screen/guest_home_screen.dart';
import 'package:hovee_attendence/view/home_screen/tutor_home_screen.dart';
import 'package:hovee_attendence/view/loginSignup/loginSingup.dart';
import 'package:hovee_attendence/view/parent_otp_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

// import '../services/webservice.dart';
// import '../views/dashboard.dart';
// import '../views/login_screen.dart';

class SplashController extends GetxController {
  final Rx<double> progressValue = 0.0.obs;
  final Rx<AppConfig?> appConfig = Rx<AppConfig?>(null);
  final LocationService locationService = LocationService();
  var currentLocation = Rxn<LatLng>();

  final int _steps = 10; // Number of steps for progress animation
  final int _loadingDuration = 3000; // Total loading duration in milliseconds

  //.haandling DEEPLINK
  final RxString deepLink = ''.obs;
  final RxBool isAppConfigFetched = false.obs;

  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  var isLoading = true.obs;
  final ParentController parentController = Get.put(ParentController());
  String? deepLinkUrl;

  final String parentId;
  final String phoneNumber;


    //constreuct
      SplashController({required this.parentId,required this.phoneNumber}); 

  @override
  void onInit() {
    super.onInit();
    // initDeepLinks();
    //  handleDeepLinkFlow(sampleUri);
     handleNormalAppFlow();
  }

  // Future<void> initDeepLinks() async {
  //   try {
  //     _appLinks = AppLinks();
     


  //     _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
  //       if (uri != null) {
  //         Logger().i("Deep link received: $uri");
  //         deepLink.value = uri.toString();
  //         handleDeepLinkFlow(uri); // Use the uri received from the stream
  //       }
  //     });
  //     // _linkSubscription!.onData((uri) {
  //     //   if (uri != null) {
  //     //     SystemNavigator.pop();
  //     //     runApp(const MyApp());
  //     //   }
  //     // });

  //     // Handle initial deep link
  //     final initialLink = await _appLinks.getInitialLink();
  //     if (initialLink != null) {
  //       Logger().i("Initial deep link: $initialLink");
  //       deepLink.value = initialLink.toString();
  //       handleDeepLinkFlow(initialLink);
  //     }
      
  //     //  else {
  //     //   handleNormalAppFlow(); // Proceed to the normal app flow
  //     // }
  //   } catch (e) {
  //     Logger().e("Error in initDeepLinks: $e");
  //     handleNormalAppFlow();
  //   }
  // }

  @override
  void onClose() {
    _linkSubscription?.cancel();
    super.onClose();
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

        // Simulate progress steps
        for (int i = 0; i <= _steps; i++) {
          progressValue.value =
              i / _steps; // Update progress value for each step
          await Future.delayed(Duration(milliseconds: stepDuration));
        }

        // // Proceed to user authentication check after a slight delay
        // Future.delayed(const Duration(seconds: 2), () {
        //   handleNormalAppFlow();
        // });
        await Future.delayed(const Duration(seconds: 2));

        Logger().i('AppConfig loaded successfully');
      } else {
        Logger().e('Failed to load AppConfig');
        // navigateToErrorScreen(); // Navigate to an error screen or retry logic
      }
    } catch (e) {
      Logger().e(e);
      // navigateToErrorScreen(); // Navigate to an error screen or retry logic
    }
  }

  void handleDeepLinkFlow(Uri deepLink) async {
    isAppConfigFetched.value = true;
    final parsedData = _parseDeepLink(deepLink);
    if (parsedData != null) {
      await fetchAppConfig();
       Get.off(() => ParentOtpScreen(), arguments: parsedData);
      // });
      // Replace SplashScreen
    } else {
      Logger().w("Invalid deep link. Proceeding with normal app flow.",stackTrace: StackTrace.current);
      handleNormalAppFlow();
    }
  }

  Map<String, String>? _parseDeepLink(Uri uri) {
    try {
      final code = uri.queryParameters['code']?.split('/phone').first;
      final phoneDetails = uri.queryParameters['code']?.split('/phone').last;

      String? phoneNumber;
      if (phoneDetails != null && phoneDetails.startsWith('?')) {
        phoneNumber = Uri.parse('https://dummy$phoneDetails')
            .queryParameters['phoneNumber'];
      }

      if (code != null && phoneNumber != null) {
        return {'code': code, 'phoneNumber': phoneNumber};
      }
    } catch (e) {
      Logger().e(e);
      // print("Error parsing deep link: $e");
    }
    return null;
  }

  Future<void> handleNormalAppFlow() async {
    await fetchAppConfig();
    isAppConfigFetched.value = true;
    // Fetch current location
    currentLocation.value = await locationService.getCurrentLocation();
    final prefs = await SharedPreferences.getInstance();
    Logger().i(
        "lat====${prefs.getDouble('latitude')}------${prefs.getDouble('longitude')}");
    Logger().i("${currentLocation.value.toString()}");
    prefs.getDouble('latitude');
    prefs.getDouble('longitude');




    // Retrieve token from SharedPreferences
    final token = await getTokenFromPreferences();

    // Navigate based on token presence

    if(parentId.isNotEmpty){
       Get.off(() => ParentOtpScreen(), arguments: {"code": parentId, "phoneNumber": phoneNumber});
      
    }else if (token.isNotEmpty) {
      await _validateTokenAndNavigate();
    }
    else {
      Get.off(() => const GuestHomeScreen()); // Navigate to guest home
    }
  }

  Future<String> getTokenFromPreferences() async {
    // Simulate token retrieval logic, replace with actual implementation
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('Token') ?? "";
  }

  Future<void> _validateTokenAndNavigate() async {
    try {
      isLoading(true);

      // Validate token using web service
      final response = await WebService.validateToken();

      if (response != null && response.tokenValid == true) {
        // Extract and save user data
        final validateTokenData = response.data;
        final prefs = await SharedPreferences.getInstance();

        LoginData loginData = LoginData(
          firstName: validateTokenData!.firstName,
          lastName: validateTokenData.lastName,
          wowId: validateTokenData.wowId,
        );
        prefs.setString('userData', jsonEncode(loginData.toJson()));

        // Navigate to Dashboard
        final roleName = response.roleName ?? 'Guest';
        parentController.getUserTokenList(response.data!.sId!);
        Get.off(() => DashboardScreen(rolename: roleName));
      } else {
        // Token invalid, navigate to Login/Signup
        Get.off(() => const LoginSignUp());
      }
    } catch (e) {
      // Handle errors
      Logger().e(e);
      Get.off(() => const LoginSignUp());
    } finally {
      isLoading(false);
    }
  }
}
