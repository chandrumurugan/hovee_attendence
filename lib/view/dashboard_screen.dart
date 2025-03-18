// // ignore_for_file: deprecated_member_use

// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:hovee_attendence/constants/colors_constants.dart';
// import 'package:hovee_attendence/controllers/dashBoard_controllers.dart';
// import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';
// import 'package:hovee_attendence/view/enrollment_screen.dart';
// import 'package:hovee_attendence/view/home_screen/parent_home_screen.dart';
// import 'package:hovee_attendence/view/home_screen/tutee_home_screen.dart';
// import 'package:hovee_attendence/view/home_screen/tutor_home_screen.dart';
// import 'package:hovee_attendence/view/ratings_screen.dart';
// import 'package:share_plus/share_plus.dart';

// class DashboardScreen extends StatelessWidget {
//   final String rolename;
//   final String? firstname, lastname, wowid;

//   DashboardScreen({
//     Key? key,
//     required this.rolename,
//     this.firstname,
//     this.lastname,
//     this.wowid,
//   }) : super(key: key);

//   final DashboardController controller = Get.put(DashboardController());

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//        onWillPop: controller.handleBackButton,
//       child: Scaffold(
//         body: PageView(
//           controller: controller.pageController,
//           onPageChanged: controller.onPageChanged,
//           children: _buildScreens(),
//         ),
//         bottomNavigationBar: Obx(
//           () => BottomNavigationBar(
//             backgroundColor: Colors.white,
//             selectedLabelStyle: const TextStyle(
//               fontSize: 12,
//               color: AppConstants.secondaryColor,
//             ),
//             unselectedLabelStyle: const TextStyle(
//               fontSize: 12,
//               color: Colors.grey,
//             ),
//             items: _navBarsItems(),
//             currentIndex: controller.selectedIndex.value,
//             selectedItemColor: AppConstants.secondaryColor,
//             unselectedItemColor: Colors.grey,
//             onTap: controller.onItemTapped,
//             showSelectedLabels: true,
//             showUnselectedLabels: true,
//             type: BottomNavigationBarType.fixed,
//           ),
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildScreens() {
//     return [
//        if (rolename=='Tutee')
//         TuteeHome(firstname: firstname,lastname: lastname,wowid: wowid, onDashBoardBack: () { 
//           controller.navigateFunc();
//          },)
//       else if (rolename=='Tutor')
//         TutorHome(firstname: firstname,lastname: lastname,wowid: wowid, onDashBoardBack: () { 
//           controller.navigateFunc();
//          },)
//       else if(rolename=='Parent')
//         ParentView(userId: '',rolename: 'Parent',firstname: firstname,lastname: lastname,wowid: wowid, onDashBoardBack: () { controller.navigateFunc(); },),
//         Tutorenquirlist(type: rolename, fromBottomNav: true,onDashBoardBack:(){controller.navigateFunc();}),
//         EnrollmentScreen(type: rolename, fromBottomNav: true,onDashBoardBack:(){controller.navigateFunc();}),
//           if (rolename=='Tutor')
//        MyRatingsScreen(fromBottomNav: true, type: 'Tutor',onDashBoardBack:(){controller.navigateFunc();})
//       else 
//       const Center(child: Text("Feature under development")),
//       const Center(child: Text("Feature under development")),
//     ];
//   }

//   List<BottomNavigationBarItem> _navBarsItems() {
//     return [
//       BottomNavigationBarItem(
//               label: 'Home',
//               activeIcon: Container(
//                 padding: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xFFC13584), Color(0xFF833AB4)],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                     borderRadius: BorderRadius.circular(8)),
//                 child: SizedBox(
//                     width: 35,
//                     height: 35,
//                   child: Image.asset(
//                     'assets/bottomBar/Group (4).png',
//                     color: Colors.white,
                  
//                   ),
//                 ),
//               ),
//               icon: SizedBox(
//                   width: 35,
//                     height: 35,
//                 child: Image.asset(
//                   'assets/bottomBar/Group (4).png',
//                   color: Colors.grey,
//                   // width: 35,
//                   //   height: 35,
//                 ),
//               ),
//               backgroundColor: Colors.white),
//                         BottomNavigationBarItem(
//               label: 'Enquiries',
//               activeIcon: Container(
//                 padding: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xFFC13584), Color(0xFF833AB4)],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                     borderRadius: BorderRadius.circular(8)),
//                 child: SizedBox(
//                     width: 35,
//                     height: 35,
//                   child: Image.asset(
//                     'assets/bottomBar/user (1) 1.png',
//                     color: Colors.white,
//                     // width: 35,
//                     // height: 35,
//                   ),
//                 ),
//               ),
//               icon: SizedBox(
//                   width: 35,
//                     height: 35,
//                 child: Image.asset(
//                   'assets/bottomBar/user (1) 1.png',
//                   // width: 35,
//                   //   height: 35,
//                 ),
//               ),
//               backgroundColor: Colors.white),
//                   BottomNavigationBarItem(
//               label: 'Enrollments',
//               activeIcon: Container(
//                 padding: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xFFC13584), Color(0xFF833AB4)],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                     borderRadius: BorderRadius.circular(8)),
//                 child: SizedBox(
//                     width: 35,
//                     height: 35,
//                   child: Image.asset(
//                     'assets/bottomBar/online-learning 1.png',
//                     color: Colors.white,
//                     // width: 35,
//                     // height: 35,
//                   ),
//                 ),
//               ),
//               icon: SizedBox(
//                   width: 35,
//                     height: 35,
//                 child: Image.asset(
//                   'assets/bottomBar/online-learning 1.png',
//                   // width: 35,
//                   //   height: 35,
//                 ),
//               ),
//               backgroundColor: Colors.white),
//               BottomNavigationBarItem(
//               label: 'Rating',
//               activeIcon: Container(
//                 padding: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xFFC13584), Color(0xFF833AB4)],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                     borderRadius: BorderRadius.circular(8)),
//                 child: SizedBox(
//                     width: 35,
//                     height: 35,
//                   child: Image.asset(
//                     'assets/bottomBar/Vector (4).png',
//                     color: Colors.white,
//                     // width: 35,
//                     // height: 35,
//                   ),
//                 ),
//               ),
//               icon: SizedBox(
//                   width: 35,
//                     height: 35,
//                 child: Image.asset(
//                   'assets/bottomBar/Vector (4).png',
//                   color: Colors.grey,
//                   // width: 35,
//                   //   height: 35,
//                 ),
//               ),
//               backgroundColor: Colors.white),
//           BottomNavigationBarItem(
//               label: 'Plan',
//               activeIcon: Container(
//                 padding: const EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xFFC13584), Color(0xFF833AB4)],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                     borderRadius: BorderRadius.circular(8)),
//                 child: SizedBox(
//                     width: 35,
//                     height: 35,
//                   child: Image.asset(
//                     'assets/bottomBar/Vector (2).png',
//                     color: Colors.white,
//                     // width: 50,
//                     // height: 50,
//                   ),
//                 ),
//               ),
//               icon: SizedBox(
//                   width: 35,
//                     height: 35,
//                 child: Image.asset('assets/bottomBar/Vector (2).png',
                
//                 // width: 50,
//                 //     height: 50,
                    
//                     ),
//               ),
//               backgroundColor: Colors.white),
//     ];
//   }

//   BottomNavigationBarItem _buildBottomNavItem({
//     required String label,
//     required String iconPath,
//   }) {
//     return BottomNavigationBarItem(
//       label: label,
//       activeIcon: _buildActiveIcon(iconPath),
//       icon: SizedBox(
//         width: 35,
//         height: 35,
//         child: Image.asset(iconPath, color: Colors.grey),
//       ),
//       backgroundColor: Colors.white,
//     );
//   }

//   Widget _buildActiveIcon(String iconPath) {
//     return Container(
//       padding: const EdgeInsets.all(5),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFFC13584), Color(0xFF833AB4)],
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//         ),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: SizedBox(
//         width: 35,
//         height: 35,
//         child: Image.asset(iconPath, color: Colors.white),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/notification_controller.dart';
import 'package:hovee_attendence/controllers/tuteeHome_controllers.dart';
import 'package:hovee_attendence/controllers/tutorHome_controllers.dart';
import 'package:hovee_attendence/modals/userProfile_modal.dart';
import 'package:hovee_attendence/services/modalServices.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_enquiry_list.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_enrollment_screen.dart';
import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';
import 'package:hovee_attendence/view/enrollment_screen.dart';
import 'package:hovee_attendence/view/home_screen/hosteller_home_screen.dart';
import 'package:hovee_attendence/view/home_screen/parent_home_screen.dart';
import 'package:hovee_attendence/view/home_screen/tutee_home_screen.dart';
import 'package:hovee_attendence/view/home_screen/tutor_home_screen.dart';
import 'package:hovee_attendence/view/ratings_screen.dart';
import 'package:hovee_attendence/view/subscription_plans/subcription_plan_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  final String rolename;
  final String? firstname, lastname, wowid;

  const DashboardScreen({
    Key? key,
    required this.rolename,
    this.firstname,
    this.lastname,
    this.wowid,
  }) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;
  final List<int> _navigationStack = [0];
   int _backButtonPressedCount = 0;
    final NotificationController noticontroller =
      Get.put(NotificationController());
        UserProfileM? userProfileResponse;
        ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    fetchUserProfiles();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<bool> _handleBackButton() async {
    if (_navigationStack.length > 1) {
      setState(() {
        _navigationStack.removeLast();
        _selectedIndex = _navigationStack.last;
        
      });
      _pageController.jumpToPage(_selectedIndex);
      return false;
    }
    return true;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _navigationStack.add(index);
      _pageController.jumpToPage(index);
     
       if (index == 0 && widget.rolename == 'Tutor') {
      noticontroller.fetchNotifications('Tutor',false);
    }
    else if (index == 0 && widget.rolename == 'Tutee') {
      noticontroller.fetchNotifications('Tutee',false);
    }else{
      noticontroller.filteredNotifications('', widget.rolename, false);
    }
    });
  }

  List<Widget> _buildScreens() {
  return [
    if (widget.rolename == 'Tutee')
      TuteeHome(
        firstname: widget.firstname,
        lastname: widget.lastname,
        wowid: widget.wowid,
        onDashBoardBack: () => _navigateBack(),
      ),
    if (widget.rolename == 'Tutor')
      TutorHome(
        firstname: widget.firstname,
        lastname: widget.lastname,
        wowid: widget.wowid,
        onDashBoardBack: () => _navigateBack(),
      ),
    if (widget.rolename == 'Parent')
      ParentView(
        userId: '',
        rolename: 'Parent',
        firstname: widget.firstname,
        lastname: widget.lastname,
        wowid: widget.wowid,
        onDashBoardBack: () => _navigateBack(),
      ),
    if (widget.rolename == 'Hosteller' || widget.rolename == "Hostel") ...[
      HostellerHomeScreen(
        firstname: widget.firstname,
        lastname: widget.lastname,
        wowid: widget.wowid,
        onDashBoardBack: () => _navigateBack(),
      ),
      HostelEnquiryList(
        type: widget.rolename,
        fromBottomNav: true,
        onDashBoardBack: () => _navigateBack(),
      ),
      HostelEnrollmentScreen(
        type: widget.rolename,
        fromBottomNav: true,
        onDashBoardBack: () => _navigateBack(),
      ),
    ] else ...[
      Tutorenquirlist(
        type: widget.rolename,
        fromBottomNav: true,
        onDashBoardBack: () => _navigateBack(),
      ),
      EnrollmentScreen(
        type: widget.rolename,
        fromBottomNav: true,
        onDashBoardBack: () => _navigateBack(),
      ),
    ],
    if (widget.rolename == 'Tutor')
      MyRatingsScreen(
        fromBottomNav: true,
        type: 'Tutor',
        onDashBoardBack: () => _navigateBack(),
      ),
    if (userProfileResponse?.data?.institudeId== null)
      PlanList(fromBottomNav: true,type: widget.rolename,
        onDashBoardBack: () => _navigateBack(),),
  ];
}


  void _navigateBack() {
    if (_navigationStack.length > 1) {
      setState(() {
        _navigationStack.removeLast();
        _selectedIndex = _navigationStack.last;
        _pageController.jumpToPage(_selectedIndex);
      });
    }
  }

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      _buildBottomNavItem(label: 'Home', iconPath: 'assets/bottomBar/Group (4).png'),
      _buildBottomNavItem(label: 'Enquiries', iconPath: 'assets/bottomBar/user (1) 1.png'),
      _buildBottomNavItem(label: 'Enrollments', iconPath: 'assets/bottomBar/online-learning 1.png'),
       if (widget.rolename == 'Tutor')
      _buildBottomNavItem(label: 'Rating', iconPath: 'assets/bottomBar/Vector (4).png'),
    if (userProfileResponse?.data?.institudeId== null)
      _buildBottomNavItem(label: 'Plan', iconPath: 'assets/bottomBar/Vector (2).png'),
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

  @override
  Widget build(BuildContext context) {
      final TutorHomeController controller = Get.put(TutorHomeController());
       final TuteeHomeController tuteecontroller = Get.put(TuteeHomeController());
    return ValueListenableBuilder<bool>(
      valueListenable: isLoading,
      builder: (context, loading, child) {
      return WillPopScope(
       onWillPop: () async {
          if (_navigationStack.length > 0) {
            // Navigate to the previous bottom tab
            setState(() {
              _navigationStack.removeLast();
              _selectedIndex = _navigationStack.last;
      
              // _selectedIndex -= 1;
            });
            _pageController.jumpToPage(_selectedIndex);
            return false; // Prevent default back behavior
          } else {
            // Handle exit confirmation logic
            if (_backButtonPressedCount == 1) {
               return await ModalService.handleBackButtonN(context);
            } else {
              // Show snack bar for back button press hint
              _backButtonPressedCount++;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Press back again to exit'),
                  duration: Duration(seconds: 1),
                ),
              );
              Future.delayed(const Duration(seconds: 2), () {
                _backButtonPressedCount = 0;
              });
              return false; // Prevent default back behavior
            }
          }
        },
        child: Scaffold(
          body: loading
              ? Center(child: CircularProgressIndicator())
         : PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: _buildScreens(),
          ),
          bottomNavigationBar:loading
              ? Center(child: CircularProgressIndicator())
         :
           BottomNavigationBar(
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
            currentIndex: _selectedIndex,
            selectedItemColor: AppConstants.secondaryColor,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      );
      }
    );
  }


void fetchUserProfiles() async { 
  isLoading.value = true;// Start loading
    try {
      UserProfileM? fetchProfile = await WebService.fetchUserProfile();
      if (fetchProfile != null) {
        userProfileResponse = fetchProfile;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('firstName', fetchProfile.data!.firstName!);
        prefs.setString('lastName', fetchProfile.data!.lastName!);
        prefs.setString('wowId', fetchProfile.data!.wowId!);
        prefs.setString('RoleType', fetchProfile.data!.rolesId!.roleName!);
        prefs.setString('InstituteId', fetchProfile.data!.institudeId ?? '');
      } else {
        // Handle error or no data case
      }
    } catch (e) {
      print(e);
    } finally { 
       isLoading.value = false;// Stop loading
    }
  }
}