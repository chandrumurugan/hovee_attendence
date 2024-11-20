import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/controllers/dashBoard_controllers.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';
import 'package:hovee_attendence/view/enrollment_screen.dart';
import 'package:hovee_attendence/view/home_screen/tutee_home_screen.dart';
import 'package:hovee_attendence/view/home_screen/tutor_home_screen.dart';
import 'package:hovee_attendence/view/notification_screen.dart';
import 'package:hovee_attendence/view/sidemenu.dart';
import 'package:hovee_attendence/widget/gifController.dart';
import 'package:share_plus/share_plus.dart';

class DashboardScreen extends StatelessWidget {
  final String rolename;
  DashboardScreen({Key? key, required this.rolename}) : super(key: key);

  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  key: controller.tuteeScaffoldKey,
      // drawer:  SideMenu(isGuest: false),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 5,
      //   shadowColor: Colors.grey.shade100,
      //   title: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Row(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           InkWell(
      //             onTap: () {
      //               controller.tuteeScaffoldKey.currentState!.openDrawer();
      //             },
      //             child: Image.asset(
      //               'assets/appbar/Group 2322.png',
      //               color: AppConstants.primaryColor,
      //             ),
      //           ),
      //           const SizedBox(
      //             width: 30,
      //           ),
      //           LogoGif()
      //         ],
      //       ),
      //       Container(
      //         //padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      //         decoration: BoxDecoration(
      //             borderRadius: BorderRadius.circular(12),
      //             //color: Colors.grey.shade200
      //             ),
      //         child: Row(
      //           // mainAxisSize: MainAxisSize.min,
      //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //           children: [
      //             InkWell(
      //               onTap: (){
      //                 Get.to(()=> NotificationScreen());
      //               },
      //               child: Image.asset(
      //                 'assets/appbar/bell 5.png',
      //                 color: Colors.black.withOpacity(0.4),
      //                 height: 30,
      //               ),
      //             ),
      //             // const SizedBox(
      //             //   width: 10,
      //             // ),
      //             InkWell(
      //               onTap: () {
      //                 // Navigator.push(
      //                 //     context,
      //                 //     MaterialPageRoute(
      //                 //         builder: (context) => const ChatScreen()));
      //               },
      //               child: Icon(
      //                 Icons.message,
      //                 color: Colors.black.withOpacity(0.4),
      //               ),
      //             ),
      //                         IconButton(
      //           onPressed: () {
      //             _showQrCodeBottomSheet(
      //           context,
      //            controller.qrcodeImageData!
      //          );
      //           },
      //           icon: const Icon(Icons.qr_code))
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      //   centerTitle: false,
      //   surfaceTintColor: Colors.white,
      //   backgroundColor: Colors.white,
      // ),
      body: PageView(
        controller: controller.pageController,
        children: _buildScreens(),
        onPageChanged: controller.onPageChanged,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedLabelStyle: TextStyle(
            fontSize: 12,
            color: AppConstants.secondaryColor,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
          items: _navBarsItems(),
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: AppConstants.secondaryColor,
          unselectedItemColor: Colors.grey,
          onTap: controller.onItemTapped,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      if (rolename=='Tutee')
        TuteeHome()
      else
        TutorHome(),
        Tutorenquirlist(type: rolename, fromBottomNav: false,),
        EnrollmentScreen(type: rolename, fromBottomNav: false,),
      Center(child: Text("Feature under development")),
      Center(child: Text("Feature under development")),
    ];
  }

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      // BottomNavigationBarItem(
      //   backgroundColor: Colors.white,
      //   icon: SvgPicture.asset(
      //     'assets/bottomBar/Group.svg',
      //     height: 20,
      //     width: 20,
      //      color: Colors.grey,
      //   ),
      //   label: "Home",
      //   activeIcon: SvgPicture.asset(
      //     'assets/bottomBar/Group.svg',
      //     color: AppConstants.secondaryColor,
      //     height: 20,
      //     width: 20,
      //   ),
      // ),
      // BottomNavigationBarItem(
      //   backgroundColor: Colors.white,
      //   icon:Image.asset(
      //             'assets/bottomBar/user (1) 1.png',
      //             color: Colors.grey,
      //           ),
      //   label: 'Enrollments',
      //   activeIcon: Image.asset(
      //             'assets/bottomBar/user (1) 1.png',
      //             color: AppConstants.secondaryColor,
      //           ),
      // ),
      // BottomNavigationBarItem(
      //   backgroundColor: Colors.white,
      //   icon: Image.asset(
      //             'assets/bottomBar/online-learning 1.png',
      //             color: Colors.grey,
      //           ),
      //   label: 'Enquiry',
      //   activeIcon: Image.asset(
      //             'assets/bottomBar/online-learning 1.png',
      //             color: AppConstants.secondaryColor,
      //           ),
      // ),
      // BottomNavigationBarItem(
      //   backgroundColor: Colors.white,
      //   icon: SvgPicture.asset(
      //     'assets/bottomBar/Vector.svg',
      //     height: 20,
      //     width: 20,
      //   ),
      //   label: 'Ratings',
      //   activeIcon: SvgPicture.asset(
      //     'assets/bottomBar/Vector.svg',
      //     color: AppConstants.secondaryColor,
      //     height: 20,
      //     width: 20,
      //   ),
      // ),
      // BottomNavigationBarItem(
      //   backgroundColor: Colors.white,
      //   icon: SvgPicture.asset(
      //     'assets/bottomBar/Vector (1).svg',
      //     height: 25,
      //     width: 25,
      //   ),
      //   label: 'Plans',
      //   activeIcon: SvgPicture.asset(
      //     'assets/bottomBar/Vector (1).svg',
      //     color: AppConstants.secondaryColor,
      //     height: 20,
      //     width: 20,
      //   ),
      // ),
      BottomNavigationBarItem(
              label: 'Home',
              activeIcon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: SizedBox(
                    width: 35,
                    height: 35,
                  child: Image.asset(
                    'assets/bottomBar/Group (4).png',
                    color: Colors.white,
                  
                  ),
                ),
              ),
              icon: SizedBox(
                  width: 35,
                    height: 35,
                child: Image.asset(
                  'assets/bottomBar/Group (4).png',
                  color: Colors.grey,
                  // width: 35,
                  //   height: 35,
                ),
              ),
              backgroundColor: Colors.white),
                        BottomNavigationBarItem(
              label: 'Enquiries',
              activeIcon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: SizedBox(
                    width: 35,
                    height: 35,
                  child: Image.asset(
                    'assets/bottomBar/user (1) 1.png',
                    color: Colors.white,
                    // width: 35,
                    // height: 35,
                  ),
                ),
              ),
              icon: SizedBox(
                  width: 35,
                    height: 35,
                child: Image.asset(
                  'assets/bottomBar/user (1) 1.png',
                  // width: 35,
                  //   height: 35,
                ),
              ),
              backgroundColor: Colors.white),
                  BottomNavigationBarItem(
              label: 'Enrollments',
              activeIcon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: SizedBox(
                    width: 35,
                    height: 35,
                  child: Image.asset(
                    'assets/bottomBar/online-learning 1.png',
                    color: Colors.white,
                    // width: 35,
                    // height: 35,
                  ),
                ),
              ),
              icon: SizedBox(
                  width: 35,
                    height: 35,
                child: Image.asset(
                  'assets/bottomBar/online-learning 1.png',
                  // width: 35,
                  //   height: 35,
                ),
              ),
              backgroundColor: Colors.white),
              BottomNavigationBarItem(
              label: 'Rating',
              activeIcon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: SizedBox(
                    width: 35,
                    height: 35,
                  child: Image.asset(
                    'assets/bottomBar/Vector (4).png',
                    color: Colors.white,
                    // width: 35,
                    // height: 35,
                  ),
                ),
              ),
              icon: SizedBox(
                  width: 35,
                    height: 35,
                child: Image.asset(
                  'assets/bottomBar/Vector (4).png',
                  color: Colors.grey,
                  // width: 35,
                  //   height: 35,
                ),
              ),
              backgroundColor: Colors.white),
          // BottomNavigationBarItem(
          //     label: 'Rating',
          //     activeIcon: Container(
          //       padding: const EdgeInsets.all(5),
          //       decoration: BoxDecoration(
          //           gradient: const LinearGradient(
          //             colors: [Color(0xFFC13584), Color(0xFF833AB4)],
          //             begin: Alignment.topCenter,
          //             end: Alignment.bottomCenter,
          //           ),
          //           borderRadius: BorderRadius.circular(8)),
          //       child: Image.asset(
          //         'assets/bottomBar/Vector (4).png',
          //         color: Colors.white,
          //         width: 50,
          //         height: 50,
          //       ),
          //     ),
          //     icon: Image.asset('assets/bottomBar/Vector (4).png'),
          //     backgroundColor: Colors.white),
          BottomNavigationBarItem(
              label: 'Plan',
              activeIcon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8)),
                child: SizedBox(
                    width: 35,
                    height: 35,
                  child: Image.asset(
                    'assets/bottomBar/Vector (2).png',
                    color: Colors.white,
                    // width: 50,
                    // height: 50,
                  ),
                ),
              ),
              icon: SizedBox(
                  width: 35,
                    height: 35,
                child: Image.asset('assets/bottomBar/Vector (2).png',
                
                // width: 50,
                //     height: 50,
                    
                    ),
              ),
              backgroundColor: Colors.white),
    ];
  }

    void _showQrCodeBottomSheet(BuildContext context, Uint8List qrCodeUrl) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Image.memory(qrCodeUrl!),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Share.share(qrCodeUrl.toString(), subject: 'QR Code');
                },
                icon: const Icon(Icons.share),
                label: const Text('Share'),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
