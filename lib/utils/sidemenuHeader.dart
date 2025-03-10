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
   return Container(
      key: sidemenuKey,
      height: 170,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * 0.025,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image:
                AssetImage('assets/tutorHomeImg/Homepage_bg_banner (1).png')),
        gradient: LinearGradient(
          colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
           Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
  radius: 42,
  child: isGuest
      ? ClipOval(
          child: const Icon(
            Icons.person,
            size: 36,
            color: Colors.black,
          ),
        )
      : (userProfileData.userProfileResponse.value.data!.profileUrl != null &&
              userProfileData.userProfileResponse.value.data!.profileUrl!.isNotEmpty)
          ? ClipOval(
              child: Image.network(
                userProfileData.userProfileResponse.value.data!.profileUrl!,
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            )
          : const Icon(
              Icons.person,
              size: 36,
              color: Colors.black,
            ),
),

            ],
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              // type!.isNotEmpty?
              //  Text(
              //     isGuest ? "Guest" :
              //                       '${firstname} ${lastname}',
              //     style: GoogleFonts.nunito(
              //         fontWeight: FontWeight.w600,
              //         color: Colors.white,
              //         fontSize: 20),
              //   ):
                Text(
                  isGuest ? "Guest" :
                   '${userProfileData.userProfileResponse.value.data!.firstName} ${userProfileData.userProfileResponse.value.data!.lastName}',
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
                    width: 5,
                  ),
                  // authController.otpResponse.value != null?
                    Container(
                      //color: Colors.amberAccent,
                      width: 180,
                     child: 
              //  Text(
              //     isGuest ? "Guest" :
              //                       'ID : ${wowid}',
              //     style: GoogleFonts.nunito(
              //         fontWeight: FontWeight.w400,
              //         color: Colors.white,
              //         fontSize: 16),
              //   ):
             isGuest ?
              Text(
                        "ID: xxxxxxx" 
                       ,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 16),
                      )
             : userProfileData.userProfileResponse.value.data!.institudeId!=null?
                  Text(
                        isGuest ?   "ID: xxxxxxx" :
                       'Reg no : ${userProfileData.userProfileResponse.value.data!.wowId}',
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 16),
                      ):
                       Text(
                        isGuest ? "ID: xxxxxxx" :
                       'ID : ${userProfileData.userProfileResponse.value.data!.wowId}',
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    )
                //     :Text(
                //   isGuest ? "Guest" :
                //                     '${parentController.loginData!.value.wowId}',
                //   style: GoogleFonts.nunito(
                //       fontWeight: FontWeight.w600,
                //       color: Colors.white,
                //       fontSize: 20),
                // ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              userProfileData.userProfileResponse.value.data!.rolesId!.roleName=='Tutee'?const SizedBox():
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
                   isGuest ?  '0':
                    userProfileData .userRatings!.averageRating ?? '0',
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
                          Get.offAll(() => const LoginSignUp());
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
     return const Center(child: Text("No user data found")); 

       }
       
        );
   
  }
}
