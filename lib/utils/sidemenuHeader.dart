import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/parent_accountsetup_controller.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/controllers/parent_dashboard_controller.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/view/loginSignup/loginSingup.dart';
import 'package:hovee_attendence/view/userProfile.dart';

class SidemenuHeader extends StatelessWidget {
  SidemenuHeader(
      {super.key,
      required this.userName,
      required this.wowID,
      required this.rating,
      required this.isGuest, this.type, this.firstname, this.lastname, this.wowid});
  final String userName;
  final String wowID;
  final bool isGuest;
  final String rating;
  final String? type;
    final String? firstname,lastname,wowid;
  GlobalKey<ScaffoldState> sidemenuKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthControllers>();
     final UserProfileController userProfileData = Get.put(UserProfileController());
     //final parentController = Get.find<ParentAccountSetupController>();
      //  final ParentDashboardController  parentController =Get.put(ParentDashboardController());
        final screen_height = MediaQuery.of(context).size.height;
      return FutureBuilder(future: authController.getStoredUserData(),
      
      
       builder:(context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator()); // Show loading indicator
      }
      if (snapshot.hasError) {
        return const Center(child: Text("Error fetching user data")); // Show error message
      }
    if (snapshot.hasData){
         final userData = snapshot.data!; 
   return
 Stack(
  children: [
    ClipPath(
      clipper: HemisphereClipper(),
      child: Container(
        height: 240,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFBA0161), Color(0xFF65217C)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Center contents
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            const SizedBox(height: 45), // Adjust spacing as needed
            Text(
              isGuest
                  ? "Guest"
                  : '${userProfileData.userProfileResponse.value.data?.firstName ?? ""} ${userProfileData.userProfileResponse.value.data?.lastName ?? ""}',
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center, // Ensure text is centered
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isGuest?SizedBox.shrink()
               : const Icon(Icons.perm_identity, color: Colors.white),
                //const SizedBox(width: 5),
                Container(
                  width: 180,
                  child: Text(
                    isGuest
                        ? "ID: xxxxxxx"
                        : 'ID: ${userProfileData.userProfileResponse.value.data?.wowId ?? ""}',
                    overflow: TextOverflow.clip,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center, // Center text
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),

    // Profile Image
    Positioned(
      top: 120, // Adjust this value to align the image properly
      left: MediaQuery.of(context).size.width / 2 - 51, // Center the image dynamically
      child: CircleAvatar(
        radius: 42,
        backgroundColor: Colors.white, // White border effect
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.shade200,
          child: isGuest
              ? const Icon(Icons.person, size: 40, color: Colors.black)
              : ClipOval(
                  child: Image.network(
                    userProfileData.userProfileResponse.value.data?.profileUrl ?? '',
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                ),
        ),
      ),
    ),
  ],
);

           
     }
     return const Center(child: Text("No user data found")); 

       }
       
        );
   
  }
}
