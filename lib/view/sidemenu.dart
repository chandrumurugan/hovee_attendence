import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/accountSetup_controller.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/services/modalServices.dart';
import 'package:hovee_attendence/utils/sidemenuHeader.dart';
import 'package:hovee_attendence/view/loginSignup/loginSingup.dart';
import 'package:hovee_attendence/view/userProfile.dart';

class SideMenu extends StatelessWidget {
  final bool isGuest;
   SideMenu({super.key, required this.isGuest});
  

  @override
  Widget build(BuildContext context) {
      final AuthControllers authController = Get.put(AuthControllers());
    var box = GetStorage();

    bool notification = true;
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            SidemenuHeader(
              isGuest: isGuest,
              userName: 'Justin Joe',
              wowID: '1234567',
              rating: '3/5',
            ),
            const SizedBox(
              height: 10,
            ),
            if (!isGuest)
              ListTile(
                onTap: () {
                  Get.to(() => UserProfile());

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const StudentProfileScreen()));
                },
                leading: Image.asset(
                  'assets/sidemenu/viewprofile.png',
                  height: 25,
                ),
                title:  Text('View profile',style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w600),),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            if (!isGuest)
              const Divider(
                height: 3,
                thickness: 5,
              ),
            if (!isGuest)
              ListTile(
                onTap: () {},
                leading: Image.asset(
                  'assets/sidemenu/mypayment.png',
                  height: 25,
                ),
                title:  Text('My payment',style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w600),),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ListTile(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => WebViewLoader(
                //       loadUrl: "http://hovee.in/attn-web/how-it-works.php",
                //       isBottomMenu: false,
                //     ),
                //   ),
                // );
              },
              leading: Image.asset(
                'assets/sidemenu/userManual.png',
                height: 25,
              ),
              title:  Text('How it works',style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w600),),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const Divider(
              height: 3,
              thickness: 5,
            ),
            ListTile(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => WebViewLoader(
                //       loadUrl: "http://hovee.in/attn-web/privacy-policy.php",
                //       isBottomMenu: false,
                //     ),
                //   ),
                // );
              },
              leading: Image.asset(
                'assets/sidemenu/privacy.png',
                height: 25,
              ),
              title:  Text('Privacy',style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w600),),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => WebViewLoader(
                //       loadUrl: "http://hovee.in/attn-web/terms-conditions.php",
                //       isBottomMenu: false,
                //     ),
                //   ),
                // );
              },
              leading: Image.asset(
                'assets/sidemenu/terms&condition.png',
                height: 25,
              ),
              title:  Text('Terms & conditions',style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w600),),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => WebViewLoader(
                //       loadUrl: "http://hovee.in/attn-web/about.php",
                //       isBottomMenu: false,
                //     ),
                //   ),
                // );
              },
              leading: Image.asset(
                'assets/sidemenu/aboutus.png',
                height: 25,
              ),
              title:  Text('About us',style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w600),),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const Divider(
              height: 3,
              thickness: 5,
            ),
            ListTile(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => WebViewLoader(
                //       loadUrl: "http://hovee.in/attn-web/help-support.php",
                //       isBottomMenu: false,
                //     ),
                //   ),
                // );
              },
              leading: Image.asset(
                'assets/sidemenu/help&support.png',
                height: 25,
              ),
              title:  Text('Help & support',style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w600),),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: () {},
              leading: Image.asset(
                'assets/sidemenu/notification.png',
                height: 25,
              ),
              title:  Text('Notification',style: GoogleFonts.nunito(
                      fontSize: 16, fontWeight: FontWeight.w600),),
              trailing: Switch(
                  activeTrackColor: const Color(0xFFC13584),
                  value: notification,
                  onChanged: (bool value) {
                    // setState(() {
                    //   notification = value;
                    // });
                  }),
            ),
            if (!isGuest)
            Obx((){
              var logout=authController.currentTabIndex.value;
              return ListTile(
                onTap: () async {
                  // _logoutPopup(context);
                  bool islogut = await ModalService.handleBackButton(context);
                  if (islogut) {
                    box.remove("Token");
                    authController!.tabController!.animateTo(0);
                    authController.currentTabIndex.value == 0;
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
            })
              ,
          ],
        ),
      )),
    );
  }
}
