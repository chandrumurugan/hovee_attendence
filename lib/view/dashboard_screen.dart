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
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (index) {
          // Synchronize BottomNavigationBar with PageView
          controller.selectedIndex.value = index;
        },
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
          onTap: (index) {
            // Update PageView when BottomNavigationBar item is tapped
            controller.selectedIndex.value = index;
            controller.pageController.jumpToPage(index);
          },
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  List<Widget> _buildScreens() {
    return [
      if (rolename == 'Tutee')
        TuteeHome(firstname: firstname, lastname: lastname, wowid: wowid)
      else if (rolename == 'Tutor')
        TutorHome(firstname: firstname, lastname: lastname, wowid: wowid)
      else if (rolename == 'Parent')
        ParentView(
          userId: '',
          rolename: 'Parent',
          firstname: firstname,
          lastname: lastname,
          wowid: wowid,
        ),
      Tutorenquirlist(
        type: rolename,
        fromBottomNav: true,
        onDashBoardBack: () => controller.navigateFunc(),
      ),
      EnrollmentScreen(
        type: rolename,
        fromBottomNav: true,
        onDashBoardBack: () => controller.navigateFunc(),
      ),
      if (rolename == 'Tutor')
        MyRatingsScreen(
          fromBottomNav: true,
          onDashBoardBack: () => controller.navigateFunc(),
          type: rolename,
        ),
      const Center(child: Text("Feature under development")),
      const Center(child: Text("Feature under development")),
    ];
  }

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      _buildBottomNavItem(
        label: 'Home',
        iconPath: 'assets/bottomBar/Group (4).png',
      ),
      _buildBottomNavItem(
        label: 'Enquiries',
        iconPath: 'assets/bottomBar/user (1) 1.png',
      ),
      _buildBottomNavItem(
        label: 'Enrollments',
        iconPath: 'assets/bottomBar/online-learning 1.png',
      ),
      _buildBottomNavItem(
        label: 'Rating',
        iconPath: 'assets/bottomBar/Vector (4).png',
      ),
      _buildBottomNavItem(
        label: 'Plan',
        iconPath: 'assets/bottomBar/Vector (2).png',
      ),
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
