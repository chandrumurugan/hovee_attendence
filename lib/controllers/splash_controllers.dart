// controllers/splash_controller.dart
import 'package:get/get.dart';
import 'package:hovee_attendence/view/loginSignup/loginSingup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

// import '../services/webservice.dart';
// import '../views/dashboard.dart';
// import '../views/login_screen.dart';

class SplashController extends GetxController {
  var showSecondImage = false.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1), () {
      showSecondImage.value = true;
    });
    checkUserLoggedIn();
  }

  Future<void> checkUserLoggedIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('user_token');
      Future.delayed(const Duration(
        seconds: 2
      ));
        Get.off(() => const LoginSignUp());
      

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
