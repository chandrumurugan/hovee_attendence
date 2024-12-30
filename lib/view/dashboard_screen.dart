// ignore_for_file: deprecated_member_use

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/dashBoard_controllers.dart';
import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';
import 'package:hovee_attendence/view/enrollment_screen.dart';
import 'package:hovee_attendence/view/home_screen/parent_home_screen.dart';
import 'package:hovee_attendence/view/home_screen/tutee_home_screen.dart';
import 'package:hovee_attendence/view/home_screen/tutor_home_screen.dart';
import 'package:hovee_attendence/view/ratings_screen.dart';
import 'package:share_plus/share_plus.dart';

class DashboardScreen extends StatelessWidget {
  final String rolename;
  final String? firstname, lastname, wowid;

  DashboardScreen({
    Key? key,
    required this.rolename,
    this.firstname,
    this.lastname,
    this.wowid,
  }) : super(key: key);

  final DashboardController controller = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: controller.handleBackButton,
      child: Scaffold(
         
        body: PageView(
          controller: controller.pageController,
          onPageChanged: controller.onPageChanged,
          children: _buildScreens(),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              color: AppConstants.secondaryColor,
            ),
            unselectedLabelStyle: const TextStyle(
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
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
       if (rolename=='Tutee')
        TuteeHome(firstname: firstname,lastname: lastname,wowid: wowid,)
      else if (rolename=='Tutor')
        TutorHome(firstname: firstname,lastname: lastname,wowid: wowid,)
      else if(rolename=='Parent')
        ParentView(userId: '',rolename: 'Parent',firstname: firstname,lastname: lastname,wowid: wowid,),
        Tutorenquirlist(type: rolename, fromBottomNav: false,),
        EnrollmentScreen(type: rolename, fromBottomNav: false,),
          if (rolename=='Tutor')
       MyRatingsScreen(fromBottomNav: false, type: 'Tutor',)
      else 
      const Center(child: Text("Feature under development")),
      const Center(child: Text("Feature under development")),
    ];
  }

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
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

  BottomNavigationBarItem _buildBottomNavItem({
    required String label,
    required String iconPath,
  }) {
    return BottomNavigationBarItem(
      label: label,
      activeIcon: _buildActiveIcon(iconPath),
      icon: SizedBox(
        width: 35,
        height: 35,
        child: Image.asset(iconPath, color: Colors.grey),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildActiveIcon(String iconPath) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFC13584), Color(0xFF833AB4)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: 35,
        height: 35,
        child: Image.asset(iconPath, color: Colors.white),
      ),
    );
  }
}
