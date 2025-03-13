import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/tuteeHome_controllers.dart';
import 'package:hovee_attendence/services/modalServices.dart';
import 'package:hovee_attendence/utils/sidemenuHeader.dart';
import 'package:hovee_attendence/utils/url_launcher.dart';
import 'package:hovee_attendence/view/loginSignup/loginSingup.dart';
import 'package:hovee_attendence/view/parent_login_screen.dart';
import 'package:hovee_attendence/view/subscription_plans/my_payment_screen.dart';
import 'package:hovee_attendence/view/userProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatelessWidget {
  final bool isGuest;
 final String? type;
   final String? firstname,lastname,wowid;
  SideMenu({super.key, required this.isGuest,  this.type, this.firstname, this.lastname, this.wowid});

  @override
  Widget build(BuildContext context) {
      const String termsUrl = "https://hoveeattendance.com/#/main/terms-condition";
        final String contactusUrl = "https://hoveeattendance.com/#/main/contact";
          const String howitworsUrl = "https://hoveeattendance.com/#/main/how-it-works";
            const String aboutusUrl = "https://hoveeattendance.com/#/main/about";
              const String hpaupportUrl = "https://hoveeattendance.com/#/main/help-support";

    final AuthControllers authController = Get.put(AuthControllers());
    var box = GetStorage();
    //final TuteeHomeController controller = Get.put(TuteeHomeController());
    bool notification = true;
    
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            SidemenuHeader(
              isGuest: isGuest,
              userName: isGuest ? "Guest" : 'Justin Joe',
              wowID: isGuest ? "ID:xxxxx" : '1234567',
              rating: isGuest ? '0' : '0',
              type: type??"",
              firstname: firstname,
              lastname: lastname,
              wowid: wowid,
            ),
            const SizedBox(
              height: 10,
            ),
            if (!isGuest)
              ListTile(
                onTap: () {
                  Get.to(() => UserProfile(type:type ,));
                },
                leading: Image.asset(
                  'assets/sidemenu/viewprofile.png',
                  height: 25,
                ),
                title: Text(
                  'View profile',
                  style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            if (!isGuest)
              const Divider(
                height: 3,
                thickness: 2,
              ),
            if (!isGuest)
              ListTile(
                onTap: () {
                   Get.to(() =>  MyPaymentScreen(type: type ?? "",));
                },
                leading: Image.asset(
                  'assets/sidemenu/mypayment.png',
                  height: 25,
                ),
                title: Text(
                  'My payment',
                  style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ListTile(
              onTap:  () => URLLauncherHelper.launchInBrowser(howitworsUrl, context),
              leading: Image.asset(
                'assets/sidemenu/userManual.png',
                height: 25,
              ),
              title: Text(
                'How it works',
                style: GoogleFonts.nunito(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const Divider(
              height: 3,
              thickness: 2,
            ),
            ListTile(
             onTap:  () => URLLauncherHelper.launchInBrowser(contactusUrl, context),
              leading: Image.asset(
                'assets/sidemenu/privacy.png',
                height: 25,
              ),
              title: Text(
                'Contact-us',
                style: GoogleFonts.nunito(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
//              if (!isGuest ||type=='Tutee')
// ListTile(
//   onTap: () {
//     // Close the side menu
//    Get.offAll(() =>  ParentLoginScreen());

    
//   },
//   leading: Image.asset(
//     'assets/sidemenu/privacy.png',
//     height: 25,
//   ),
//   title: Text(
//     'Invite Parent',
//     style: GoogleFonts.nunito(
//       fontSize: 16,
//       fontWeight: FontWeight.w600,
//     ),
//   ),
//   trailing: const Icon(Icons.arrow_forward_ios),
// ),


            ListTile(
           onTap:  () => URLLauncherHelper.launchInBrowser(termsUrl, context),
              leading: Image.asset(
                'assets/sidemenu/terms&condition.png',
                height: 25,
              ),
              title: Text(
                'Terms & conditions',
                style: GoogleFonts.nunito(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
            onTap:  () => URLLauncherHelper.launchInBrowser(aboutusUrl, context),
              leading: Image.asset(
                'assets/sidemenu/aboutus.png',
                height: 25,
              ),
              title: Text(
                'About us',
                style: GoogleFonts.nunito(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const Divider(
              height: 3,
              thickness: 2,
            ),
            ListTile(
            onTap:  () => URLLauncherHelper.launchInBrowser(hpaupportUrl, context),
              leading: Image.asset(
                'assets/sidemenu/help&support.png',
                height: 25,
              ),
              title: Text(
                'Help & support',
                style: GoogleFonts.nunito(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            // ListTile(
            //   onTap: () {},
            //   leading: Image.asset(
            //     'assets/sidemenu/notification.png',
            //     height: 25,
            //   ),
            //   title: Text(
            //     'Notification',
            //     style: GoogleFonts.nunito(
            //         fontSize: 16, fontWeight: FontWeight.w600),
            //   ),
            //   trailing: Switch(
            //       activeTrackColor: const Color(0xFFC13584),
            //       value: notification,
            //       onChanged: (bool value) {
            //         // setState(() {
            //         //   notification = value;
            //         // });
            //       }),
            // ),
            if (!isGuest)
              Obx(() {
               
                var logout = authController.currentTabIndex.value;
                return ListTile(
                  onTap: () async {
                    // _logoutPopup(context);
                    await authController.logout();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    bool islogut = await ModalService.handleBackButton(context);
                    if (islogut) {
                      // box.remove("Token");
                      prefs.remove('Token');
                      prefs.remove('PrentToken');
                      prefs.remove("PrentToken");

                      authController.tabController.animateTo(0);
                      authController.resetTabIndex();
                      Get.offAll(() => const LoginSignUp());
                    } else {}
                    
                  },
                  leading: const Icon(
                    Icons.logout_rounded,
                    size: 30,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Logout",
                    style: GoogleFonts.nunito(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  
                  // trailing: Switch(
                  //     activeTrackColor: AppColors.primary_color,
                  //     value: notification,
                  //     onChanged: (bool value) {
                  //       setState(() {
                  //         notification = value;
                  //       });
                  //     }),
                );
              }),

              if (isGuest)
           ListTile(
                  onTap: () async {
                    // _logoutPopup(context);
                   Get.to(LoginSignUp());
                  },
                  leading: const Icon(
                    Icons.logout_rounded,
                    size: 30,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Log In",
                    style: GoogleFonts.nunito(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                )
             
          ],
        ),
      )),
    );
  }
}
