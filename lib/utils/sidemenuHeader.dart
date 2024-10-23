



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/view/loginSignup/loginSingup.dart';

class SidemenuHeader extends StatelessWidget {
  SidemenuHeader(
      {super.key,
      required this.userName,
      required this.wowID,
      required this.rating,
      required this.isGuest});
  final String userName;
  final String wowID;
  final bool isGuest;
  final String rating;
  // final String image;
  GlobalKey<ScaffoldState> sidemenuKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthControllers>();
    return Container(
      key: sidemenuKey,
      height: 170,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * 0.05,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/tutorHomeImg/Homepage_bg_banner (1).png')),
        gradient: LinearGradient(
          colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // InkWell(
              //   onTap: () {
              //     sidemenuKey.currentState!.closeDrawer();
              //   },
              //   child: const Icon(
              //     Icons.close,
              //     color: Colors.white,
              //   ),
              // ),
              // // const SizedBox(
              // //   height: 30,
              // // ),
              CircleAvatar(
  radius: 42,
  // Optional: Set a background color
  //backgroundColor: Colors.grey[200],
  child: Icon(
    Icons.person, // Correct usage: provide IconData directly
    size: 36, // Adjust the icon size as needed
    color: Colors.black, // Set the icon color
  ),
)
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "${authController.otpResponse.value.data!.firstName} ${authController.otpResponse.value.data!.lastName}",
                style: GoogleFonts.nunito(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.perm_identity,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'hov ID : ${authController.otpResponse.value.data!.wowId}',
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_border_purple500_sharp,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    rating,
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 16),
                  ),
                  if (isGuest)
                    const SizedBox(
                      width: 40,
                    ),
                  if (isGuest)
                    InkWell(
                        onTap: () {
                          Get.offAll(()=>const LoginSignUp());
                         
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              const Icon(Icons.login),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Login",
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}