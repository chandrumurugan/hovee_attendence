import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/parent_dashboard_controller.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';

class HomePageHeader extends StatelessWidget {
  @override
  HomePageHeader({super.key, required this.title, required this.userType, this.firstName, this.lastName, this.wowId});
  final String title;
  final String userType;
  final String? firstName,lastName,wowId;
  @override
  Widget build(BuildContext context) {
    final AuthControllers authController = Get.put(AuthControllers());
    final userProfileData = Get.find<UserProfileController>();
    final userdata = authController.getStoredUserData();
    // final parentController = Get.find<ParentDashboardController>();
    final ParentDashboardController parentController =
        Get.put(ParentDashboardController(), permanent: true);
    // final ParentDashboardController  parentController =Get.put(ParentDashboardController());

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
                                begin: Offset(-1.0, 0.0), // Slide in from left
                                end: Offset(0.0, 0.0), // End at original position
                                duration: 300.ms,
                              ),
                              FadeEffect(
                                begin: 0.0,
                                end: 1.0,
                                duration: 300.ms,
                              ),
                            ],
                            child: const CircleAvatar(
                              radius: 35,
                              // Optional: Set a background color
                              //backgroundColor: Colors.grey[200],
                              child: Icon(
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
                                          begin: Offset(-1.0,
                                              0.0), // Slide in from the left
                                          end: Offset(0.0,
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
                                    begin: Offset(
                                        -1.0, 0.0), // Slide in from the left
                                    end: Offset(
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
                        height: 5,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Animate(
                            effects: [
                              SlideEffect(
                                begin:
                                    Offset(-1.0, 0.0), // Slide in from the left
                                end: Offset(0.0, 0.0), // End at original position
                                duration: 400.ms,
                              ),
                              FadeEffect(
                                begin: 0.0,
                                end: 1.0,
                                duration: 400.ms,
                              ),
                            ],
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green),
                              child: Row(
                                children: [
                                  const Text('0',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.0,
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
                          Animate(
                            effects: [
                              SlideEffect(
                                begin:
                                    Offset(-1.0, 0.0), // Slide in from the left
                                end: Offset(0.0, 0.0), // End at original position
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
                                    Offset(-1.0, 0.0), // Slide in from the left
                                end: Offset(0.0, 0.0), // End at original position
                                duration: 500.ms,
                              ),
                              FadeEffect(
                                begin: 0.0,
                                end: 1.0,
                                duration: 500.ms,
                              ),
                            ],
                            child: Text('ID: ${userProfileData.userProfileResponse.value.data!.wowId ??''}',
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
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
}
