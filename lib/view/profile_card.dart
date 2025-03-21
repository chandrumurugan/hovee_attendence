import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/parent_dashboard_controller.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';

class HomePageHeader extends StatelessWidget {
  @override
  HomePageHeader({super.key, required this.title, required this.userType, this.firstName, this.lastName, this.wowId, required this.planName, required this.colorCode});
  final String title;
  final String userType;
  final String? firstName,lastName,wowId;
  final String planName,colorCode;
  @override
  Widget build(BuildContext context) {
    final AuthControllers authController = Get.put(AuthControllers());
    final userProfileData = Get.find<UserProfileController>();
    final userdata = authController.getStoredUserData();
    // final parentController = Get.find<ParentDashboardController>();
    final ParentDashboardController parentController =
        Get.put(ParentDashboardController(), permanent: true);
    // final ParentDashboardController  parentController =Get.put(ParentDashboardController());
  //Color parsedColor = Color(int.parse(colorCode.replaceFirst("#", "0xff")?? ''));
  Color parsedColor = _getColorFromHex(colorCode);
    return FutureBuilder(    future: authController.getStoredUserData(),
    
    
     builder:  (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator()); // Show loading indicator
      }
      if (snapshot.hasError) {
        return const Center(child: Text("Error fetching user data")); // Show error message
      }
       if (snapshot.hasData) {
         final userData = snapshot.data!; 
        return Animate(

      child: Container(
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 40),
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/tutorHomeImg/Homepage_bg_banner (1).png',
                )),
            borderRadius: BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(
              colors: [Color(0xFFC13584), Color(0xFF833AB4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Animate(
                            effects: [
                              SlideEffect(
                                begin: const Offset(-1.0, 0.0), // Slide in from left
                                end: const Offset(0.0, 0.0), // End at original position
                                duration: 300.ms,
                              ),
                              FadeEffect(
                                begin: 0.0,
                                end: 1.0,
                                duration: 300.ms,
                              ),
                            ],
                            child:  CircleAvatar(
                              radius: 38,
                              child: userProfileData.userProfileResponse.value.data!.profileUrl!=
                                                  null &&
                                              userProfileData.userProfileResponse.value.data!.profileUrl!.isNotEmpty?
                               ClipOval(
                                child: Image.network(
                                                        userProfileData.userProfileResponse.value.data!.profileUrl ??
                                                            "",fit: BoxFit.cover, width: 100, 
                height: 100,),
                              ):const Icon(
                                Icons
                                    .person, // Correct usage: provide IconData directly
                                size: 36, // Adjust the icon size as needed
                                color: Colors.black, // Set the icon color
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
      
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // userType == 'Parent'
                              //     ? Animate(
                              //         effects: [
                              //           FadeEffect(
                              //             begin: 0.0,
                              //             end: 1.0,
                              //             duration: 500.ms,
                              //           ),
                              //           ScaleEffect(
                              //             begin: Offset(
                              //                 -1.0, 0.0), // Slide in from left
                              //             end: Offset(0.0, 0.0),
                              //             duration: 500.ms,
                              //           ),
                              //         ],
                              //         child: Obx(() {
                              //           return Text(
                              //               '${parentController.loginData!.value.firstName ?? ""} ${parentController.loginData!.value.lastName ?? ""}',
                              //               style: const TextStyle(
                              //                 fontWeight: FontWeight.w400,
                              //                 fontSize: 20.0,
                              //                 color: Colors.white,
                              //               ));
                              //         }),
                              //       )
                              //     : Animate(
                              //         effects: [
                              //           FadeEffect(
                              //             begin: 0.0,
                              //             end: 1.0,
                              //             duration: 500.ms,
                              //           ),
                              //           ScaleEffect(
                              //             begin: Offset(
                              //                 -1.0, 0.0), // Slide in from left
                              //             end: Offset(0.0, 0.0),
                              //             duration: 500.ms,
                              //           ),
                              //         ],
                              //       child: Text(
                              //           '${authController.loginData!.firstName} ${authController.loginData!.lastName}',
                              //           style: const TextStyle(
                              //             fontWeight: FontWeight.w400,
                              //             fontSize: 20.0,
                              //             color: Colors.white,
                              //           )),
                              //     ),
      
                              // userType == 'Parent'
                              //     ? Animate(
                              //         effects: [
                              //           FadeEffect(
                              //             begin: 0.0,
                              //             end: 1.0,
                              //             duration: 500.ms,
                              //           ),
                              //           SlideEffect(
                              //             begin: Offset(-1.0,
                              //                 0.0), // Slide in from the left
                              //             end: Offset(0.0,
                              //                 0.0), // End at original position
                              //             duration: 500.ms,
                              //           ),
                              //         ],
                              //         child: Obx(() {
                              //           return Text(
                              //             '${parentController.loginData!.value.firstName ?? ""} ${parentController.loginData!.value.lastName ?? ""}',
                              //             style: const TextStyle(
                              //               fontWeight: FontWeight.w400,
                              //               fontSize: 20.0,
                              //               color: Colors.white,
                              //             ),
                              //           );
                              //         }),
                              //       )
                                   Animate(
                                      effects: [
                                        FadeEffect(
                                          begin: 0.0,
                                          end: 1.0,
                                          duration: 500.ms,
                                        ),
                                        SlideEffect(
                                          begin: const Offset(-1.0,
                                              0.0), // Slide in from the left
                                          end: const Offset(0.0,
                                              0.0), // End at original position
                                          duration: 500.ms,
                                        ),
                                      ],
                                      child:
                                       Text(
                                        '${userProfileData.userProfileResponse.value.data!.firstName} ${userProfileData.userProfileResponse.value.data!.lastName}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                              Animate(
                                effects: [
                                  FadeEffect(
                                    begin: 0.0,
                                    end: 1.0,
                                    duration: 600.ms,
                                  ),
                                  SlideEffect(
                                    begin: const Offset(
                                        -1.0, 0.0), // Slide in from the left
                                    end: const Offset(
                                        0.0, 0.0), // End at original position
                                    duration: 600.ms,
                                  ),
                                ],
                                child: Text(userProfileData.userProfileResponse.value.data!.rolesId!.roleName ?? "",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.0,
                                      color: Colors.amber,
                                    )),
                              ),
                            ],
                          ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          userType=='Tutee'?const SizedBox():
                          Animate(
                            effects: [
                              SlideEffect(
                                begin:
                                    const Offset(-1.0, 0.0), // Slide in from the left
                                end: const Offset(0.0, 0.0), // End at original position
                                duration: 400.ms,
                              ),
                              FadeEffect(
                                begin: 0.0,
                                end: 1.0,
                                duration: 400.ms,
                              ),
                            ],
                            child: 
                            
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green),
                              child: Row(
                                children: [
                                   Text(userProfileData .userRatings!.averageRating ?? '0',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.0,
                                        color: Colors.white,
                                      )),
                                  Image.asset('assets/tutorHomeImg/star 1.png')
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          userType=='Tutee'?const SizedBox():
                          Animate(
                            effects: [
                              SlideEffect(
                                begin:
                                    const Offset(-1.0, 0.0), // Slide in from the left
                                end: const Offset(0.0, 0.0), // End at original position
                                duration: 450.ms,
                              ),
                              FadeEffect(
                                begin: 0.0,
                                end: 1.0,
                                duration: 450.ms,
                              ),
                            ],
                            child: Container(
                              height: 15,
                              width: 1,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // userType=='Parent'?
                          // Text(
                          //         '${parentController.loginData!.value.wowId}',
                          //     style: const TextStyle(
                          //       fontWeight: FontWeight.w400,
                          //       fontSize: 13.0,
                          //       color: Colors.white,
                          //     )):
                          Animate(
                            effects: [
                              SlideEffect(
                                begin:
                                    const Offset(-1.0, 0.0), // Slide in from the left
                                end: const Offset(0.0, 0.0), // End at original position
                                duration: 500.ms,
                              ),
                              FadeEffect(
                                begin: 0.0,
                                end: 1.0,
                                duration: 500.ms,
                              ),
                            ],
                            child:userProfileData.userProfileResponse.value.data!.institudeId!=null?
                            Text( 'Reg no: ${userProfileData.userProfileResponse.value.data!.wowId ??''}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.0,
                                  color: Colors.white,
                                ))
                            : Text( 'ID: ${userProfileData.userProfileResponse.value.data!.wowId ??''}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.0,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              planName!=null&& planName.isNotEmpty?
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Card(
                    elevation: 4.0,
                    surfaceTintColor: Colors.white,
                    color: Colors.white,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: parsedColor),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            planName,
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: parsedColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ],
                ),
              ):SizedBox.shrink(),
              if (userType == "Tutor")
                const SizedBox(
                  height: 20,
                ),
            ],
          )),
    ).animate().shimmer(duration: 1000.ms,);
       }
        return const Center(child: Text("No user data found")); 
     }
     
     );
   
  
  }

Color _getColorFromHex(String? hexColor) {
  if (hexColor == null || hexColor.isEmpty) {
    return Colors.transparent; // Default color when colorCode is empty
  }

  // Ensure the color code starts with "#"
  if (!hexColor.startsWith("#")) {
    hexColor = "#$hexColor";
  }

  try {
    return Color(int.parse(hexColor.replaceFirst("#", "0xff")));
  } catch (e) {
    return Colors.transparent; // Fallback color in case of parsing error
  }
}

}
