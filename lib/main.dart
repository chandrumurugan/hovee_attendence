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
       Get.lazyPut<DashboardController>(() => DashboardController()); //TutorHomeController
         Get.lazyPut<TutorHomeController>(() => TutorHomeController());//RoleController
          Get.lazyPut<RoleController>(() => RoleController());//AccountSetupController
            Get.lazyPut<AccountSetupController>(() => AccountSetupController());//UserProfileController
             Get.lazyPut<UserProfileController>(() => UserProfileController());
             Get.lazyPut<StudentAttendanceController>(() => StudentAttendanceController());
             //AddEnqueryController
                Get.lazyPut<AddEnqueryController>(() => AddEnqueryController());
                Get.lazyPut<ParentController>(() => ParentController());

  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}


void main()async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
    Get.put(AuthControllers());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;


    @override
  void initState() {
    super.initState();
    
    //initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();

    super.dispose();
  }

  //   Future<void> initDeepLinks() async {
  //   _appLinks = AppLinks();

  //   // Handle links
  //   _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
  //     debugPrint('onAppLink: $uri');
  //     Logger().i("$uri");
  //     // openAppLink(uri);
  //   });
  // }

//  Future<void> initDeepLinks() async {
//   String url = 'https://express.insakal.com/parent-login?code=aec0c641b27c6db9ea70eab34450c925%3A08fe7457e1144be383540006b026381c&phoneNumber=9876543210';

//   // Parse the URL
//   Uri uri = Uri.parse(url);

//   // Extract the 'code' query parameter
//   String? code = uri.queryParameters['code'];
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('code', code!);
//   if (code != null) {
//     print('Extracted Code: $code');
//   } else {
//     print('Code parameter not found in the URL');
//   } 
//   // Get.to(() => ParentOtpScreen());
// }


  // This widget is the root of your application.
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

