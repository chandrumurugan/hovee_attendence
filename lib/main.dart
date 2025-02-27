import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/config/appConfig.dart';
import 'package:hovee_attendence/controllers/accountSetup_controller.dart';
import 'package:hovee_attendence/controllers/addEnquery_controller.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/dashBoard_controllers.dart';
import 'package:hovee_attendence/controllers/guestHome_controller.dart';
import 'package:hovee_attendence/controllers/network_controller.dart';
import 'package:hovee_attendence/controllers/parent_accountsetup_controller.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/controllers/parent_dashboard_controller.dart';
import 'package:hovee_attendence/controllers/ratings_controller.dart';
import 'package:hovee_attendence/controllers/role_controller.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:hovee_attendence/controllers/track_tutee_controller.dart';
import 'package:hovee_attendence/controllers/tutorHome_controllers.dart';
import 'package:hovee_attendence/controllers/tutorsStudentAttendanceList.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/services/notification_service.dart';
import 'package:hovee_attendence/view/splash_screen.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:restart_app/restart_app.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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
    Get.lazyPut<ParentAccountSetupController>(() => ParentAccountSetupController());
    Get.lazyPut<ParentDashboardController>(() => ParentDashboardController());
     Get.lazyPut(() => RatingsController(), fenix: true);
      Get.lazyPut<TrackTuteeLocationController>(() => TrackTuteeLocationController());
       Get.lazyPut<GuesthomeController>(() => GuesthomeController());
      
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
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    final NotificationService notificationService = NotificationService();
  await notificationService.initialize();
   APIConfig.environmentBuild = Environments.DEVELOPMENT;
   await GetStorage.init();
   
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(NetworkController(), permanent: true);
  Get.put(AuthControllers());
 //Get.put(UserProfileController());
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();
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
    _streamLink(); //stream listen
    _intialLink();
  }

  Future<void> _intialLink() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
       final storage = GetStorage();
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
     //_initialUri=  Uri.tryParse('https://express.insakal.com/parent-login?code=e84ac7f93efec4e70def8b288946518b%3A1570ac303ecb547e71d9e693d6e40681&phoneNumber=1233211233');
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

  void _streamLink() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final storage = GetStorage();
        // prefs.setBool("deepLink", true);
           //storage.write('deepLink', false); 

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
    // Extract the "code" parameter
    final code = uri.queryParameters['code'];

    // Extract the "phoneNumber" parameter directly
    final phoneNumber = uri.queryParameters['phoneNumber'];

    // Return both values if they are not null
    if (code != null && phoneNumber != null) {
      return {'code': code, 'phoneNumber': phoneNumber};
    }
  } catch (e) {
    Logger().e(e); // Log any errors
  }
  return null; // Return null if parsing fails
}


  @override
  void dispose() {
    super.dispose();
    _linkSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: _navKey,
      initialBinding: MyBindings(),
      title: 'Attendance',
      onInit: () {
          
      },
      debugShowCheckedModeBanner: false,
      
      
   builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => child ?? const SizedBox.shrink(),
            ),
          ],
        );
      },
      home: SplashScreen(
        parentId: code,
        phoneNumber: phoneNumber,
      ),
    );
  }
}
