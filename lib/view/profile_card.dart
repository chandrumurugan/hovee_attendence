import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/parent_dashboard_controller.dart';

class HomePageHeader extends StatelessWidget {
  @override
  HomePageHeader({super.key, required this.title, required this.userType});
  final String title;
  final String userType;
  @override
  Widget build(BuildContext context) {
    final AuthControllers authController = Get.put(AuthControllers());
      // final parentController = Get.find<ParentDashboardController>();
       final ParentDashboardController parentController = Get.put(ParentDashboardController(),permanent: true );
      // final ParentDashboardController  parentController =Get.put(ParentDashboardController());
   return   Container(
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
                            const CircleAvatar(
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
                            const SizedBox(
                              width: 10,
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                userType=='Parent'?
                                Obx(() {
                                   return Text(
                                      '${parentController.loginData!.value.firstName ?? ""} ${parentController.loginData!.value.lastName ?? ""}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 20.0,
                                        color: Colors.white,
                                      ));
                                } ):
                                
                                Text(
                                    '${authController.loginData!.firstName} ${authController.loginData!.lastName}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20.0,
                                      color: Colors.white,
                                    )),
                                Text(userType,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18.0,
                                      color: Colors.amber,
                                    )),
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
                            Container(
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
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 15,
                              width: 1,
                              color: Colors.white,
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
                            Text('ID: ${authController.loginData!.wowId!}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.0,
                                  color: Colors.white,
                                )),
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
            ));
    // return Obx(() {
    //   if (authController.isLoading.value) {
    //     return const SizedBox.shrink();
    //   } else {
    //     return Container(
    //         padding: const EdgeInsets.fromLTRB(20, 5, 20, 40),
    //         decoration: const BoxDecoration(
    //           image: DecorationImage(
    //               fit: BoxFit.cover,
    //               image: AssetImage(
    //                 'assets/tutorHomeImg/Homepage_bg_banner (1).png',
    //               )),
    //           borderRadius: BorderRadius.all(Radius.circular(12)),
    //           gradient: LinearGradient(
    //             colors: [Color(0xFFC13584), Color(0xFF833AB4)],
    //             begin: Alignment.topCenter,
    //             end: Alignment.bottomCenter,
    //           ),
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             const SizedBox(
    //               height: 10,
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Row(
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: [
    //                         const CircleAvatar(
    //                           radius: 35,
    //                           // Optional: Set a background color
    //                           //backgroundColor: Colors.grey[200],
    //                           child: Icon(
    //                             Icons
    //                                 .person, // Correct usage: provide IconData directly
    //                             size: 36, // Adjust the icon size as needed
    //                             color: Colors.black, // Set the icon color
    //                           ),
    //                         ),
    //                         const SizedBox(
    //                           width: 10,
    //                         ),

    //                         Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             userType=='Parent'?
    //                              Text(
    //                                 '${parentController.loginData!.value.firstName!} ${parentController.loginData!.value.lastName!}',
    //                                 style: const TextStyle(
    //                                   fontWeight: FontWeight.w400,
    //                                   fontSize: 20.0,
    //                                   color: Colors.white,
    //                                 )):
    //                             Text(
    //                                 '${authController.loginData!.firstName} ${authController.loginData!.lastName}',
    //                                 style: const TextStyle(
    //                                   fontWeight: FontWeight.w400,
    //                                   fontSize: 20.0,
    //                                   color: Colors.white,
    //                                 )),
    //                             Text(userType,
    //                                 style: const TextStyle(
    //                                   fontWeight: FontWeight.w400,
    //                                   fontSize: 18.0,
    //                                   color: Colors.amber,
    //                                 )),
    //                           ],
    //                         ),
    //                         // const SizedBox(
    //                         //   width: 10,
    //                         // ),
    //                       ],
    //                     ),
    //                     const SizedBox(
    //                       height: 5,
    //                     ),
    //                     Row(
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: [
    //                         Container(
    //                           padding: const EdgeInsets.symmetric(
    //                               horizontal: 10, vertical: 3),
    //                           decoration: BoxDecoration(
    //                               borderRadius: BorderRadius.circular(20),
    //                               color: Colors.green),
    //                           child: Row(
    //                             children: [
    //                               const Text('4.2',
    //                                   style: TextStyle(
    //                                     fontWeight: FontWeight.w500,
    //                                     fontSize: 10.0,
    //                                     color: Colors.white,
    //                                   )),
    //                               Image.asset('assets/tutorHomeImg/star 1.png')
    //                             ],
    //                           ),
    //                         ),
    //                         const SizedBox(
    //                           width: 10,
    //                         ),
    //                         Container(
    //                           height: 15,
    //                           width: 1,
    //                           color: Colors.white,
    //                         ),
    //                         const SizedBox(
    //                           width: 10,
    //                         ),
    //                         // userType=='Parent'?
    //                         // Text(
    //                         //         '${parentController.loginData!.value.wowId}',
    //                         //     style: const TextStyle(
    //                         //       fontWeight: FontWeight.w400,
    //                         //       fontSize: 13.0,
    //                         //       color: Colors.white,
    //                         //     )):
    //                         Text('${authController.loginData!.wowId!}',
    //                             style: const TextStyle(
    //                               fontWeight: FontWeight.w400,
    //                               fontSize: 13.0,
    //                               color: Colors.white,
    //                             )),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //             Padding(
    //               padding:
    //                   const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
    //               child: Text(
    //                 title,
    //                 style: const TextStyle(
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.w500,
    //                     color: Colors.white),
    //               ),
    //             ),
    //             if (userType == "Tutor")
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //           ],
    //         ));
    //   }
    // });
  }
}