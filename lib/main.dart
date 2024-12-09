import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hovee_attendence/controllers/accountSetup_controller.dart';
import 'package:hovee_attendence/controllers/addEnquery_controller.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/dashBoard_controllers.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/controllers/role_controller.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:hovee_attendence/controllers/tutorHome_controllers.dart';
import 'package:hovee_attendence/controllers/tutorsStudentAttendanceList.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/view/parent_otp_screen.dart';
import 'package:hovee_attendence/view/splash_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app_links/app_links.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<AuthControllers>(() => AuthControllers());
    Get.lazyPut<DashboardController>(
        () => DashboardController()); //TutorHomeController
    Get.lazyPut<TutorHomeController>(
        () => TutorHomeController()); //RoleController
    Get.lazyPut<RoleController>(
        () => RoleController()); //AccountSetupController
    Get.lazyPut<AccountSetupController>(
        () => AccountSetupController()); //UserProfileController
    Get.lazyPut<UserProfileController>(() => UserProfileController());
    Get.lazyPut<StudentAttendanceController>(
        () => StudentAttendanceController());
    //AddEnqueryController
    Get.lazyPut<AddEnqueryController>(() => AddEnqueryController());
    Get.lazyPut<ParentController>(() => ParentController());
  }
}

// ignore: unused_element
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(AuthControllers());
  runApp( const MyApp());
}


// class MyApp extends StatelessWidget {
//    final AppLinks _appLinks = AppLinks();
//    MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       initialBinding: MyBindings(),
//       title: 'Attendence',
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(onInitializationComplete: _handleAppInitialization),
//     );
//   }

//     Future<void> _handleAppInitialization() async {
//       Logger().i("App initialized");
    // final SplashController splashController = Get.find<SplashController>();
    // Uri? deepLink = await _fetchDeepLink();
    //   Logger().i(deepLink == null);
    // if (deepLink != null) {
    //   splashController.handleDeepLinkFlow(deepLink);
    // } else {

    //   splashController.handleNormalAppFlow();
    // }
//   }

//     Future<Uri?> _fetchDeepLink() async {
//     try {
//       //    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
//       //   debugPrint('onAppLink: $uri');
//       //   Logger().i("$uri");
        
//       //   openAppLink(uri.toString());
//       // });
//       Logger().i("fetchDeepLink ====>${_appLinks.uriLinkStream.first}");
//       return await _appLinks.uriLinkStream.first;

//     } catch (e) {
//       Logger().e(e);
   
//       return null;
//     }
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MyBindings(),
      title: 'Attendence',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
