import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
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
import 'package:hovee_attendence/view/splash_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:restart_app/restart_app.dart';

bool _initialUriIsHandled = false;

class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
        () => SplashController(parentId: '', phoneNumber: ''));
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
   await GetStorage.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(AuthControllers());
  runApp(const MyApp());
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
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;
  bool _initialUriIsHandled = false;
  String code = '';
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    initDeepLinks(); //stream listen
    _handleInitialUri();
  }

  Future<void> _handleInitialUri() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
       final storage = GetStorage();
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        _initialUri = await _appLinks.getInitialLink();
        if (_initialUri != null) {
          final parsedData = _parseDeepLink(_initialUri!);
          if (parsedData != null) {
            setState(() {
              code = parsedData['code']!;
              phoneNumber = parsedData['phoneNumber']!;
              prefs.setString('code', parsedData['code']!);
              prefs.setString('phoneNumber', parsedData['phoneNumber']!);
              storage.write('deepLink', true); 
            });
          }
        }
      } catch (e) {
        Logger().e(e);
      }
    }
  }

  void initDeepLinks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final storage = GetStorage();
        // prefs.setBool("deepLink", true);
           storage.write('deepLink', false); 

    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      final parsedData = _parseDeepLink(uri);
      if (parsedData != null) {
        setState(() {
          code = parsedData['code']!;
          phoneNumber = parsedData['phoneNumber']!;
          prefs.setString('code', parsedData['code']!);
          prefs.setString('phoneNumber', parsedData['phoneNumber']!);
          // prefs.setBool("deepLink", true);
           storage.write('deepLink', true); 
        });

        // Get.off(() => ParentOtpScreen(), arguments: parsedData);
      }
      setState(() {
        _latestUri = uri;
      });

      Restart.restartApp();
    }, onError: (Object err) {
      Logger().e(err);
    });
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

  @override
  void dispose() {
    super.dispose();
    _linkSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MyBindings(),
      title: 'Attendence',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
        parentId: code,
        phoneNumber: phoneNumber,
      ),
    );
  }
}
