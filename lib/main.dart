import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hovee_attendence/controllers/accountSetup_controller.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/dashBoard_controllers.dart';
import 'package:hovee_attendence/controllers/role_controller.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:hovee_attendence/controllers/tutorHome_controllers.dart';
import 'package:hovee_attendence/view/splash_screen.dart';
import 'package:get/get.dart';



class MyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<AuthControllers>(() => AuthControllers());
       Get.lazyPut<DashboardController>(() => DashboardController()); //TutorHomeController
         Get.lazyPut<TutorHomeController>(() => TutorHomeController());//RoleController
          Get.lazyPut<RoleController>(() => RoleController());//AccountSetupController
            Get.lazyPut<AccountSetupController>(() => AccountSetupController());
  }
}

void main() {
    WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
    Get.put(AuthControllers());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

