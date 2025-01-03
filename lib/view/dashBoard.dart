

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hovee_attendence/constants/colors_constants.dart';
// import 'package:hovee_attendence/controllers/dashBoard_controllers.dart';
// import 'package:hovee_attendence/view/home_screen/tutor_home_screen.dart';

// class DashBoard extends StatelessWidget {
//    DashBoard({super.key});

//    final DashboardController controller = Get.put(DashboardController());

//     final List<Widget> pages = [
//     TutorHome(),
//    TutorHome(),
//    TutorHome(),
//   TutorHome(),
//   TutorHome(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return 
//      Scaffold(
//        body: Obx(() => pages[controller.selectedIndex.value]),
//        bottomNavigationBar:Obx(()=>BottomNavigationBar(
//           currentIndex: controller.selectedIndex.value,
//         onTap: controller.onPageChanged,
//         selectedItemColor: AppConstants.primaryColor,
//         selectedIconTheme: const IconThemeData(
//             // color: AppColors.secondary_color,
//             ),
//         unselectedItemColor: Colors.grey,
//         selectedLabelStyle: const TextStyle(color: AppConstants.secondaryColor),
//         unselectedLabelStyle: GoogleFonts.nunito(color: Colors.grey),
//         showUnselectedLabels: true,
//         items: [
//               BottomNavigationBarItem(
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
//                 child: Image.asset(
//                   'assets/bottomBar/Group (4).png',
//                   color: Colors.white,
//                 ),
//               ),
//               icon: Image.asset(
//                 'assets/bottomBar/Group (4).png',
//                 color: Colors.grey,
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
//                 child: Image.asset(
//                   'assets/bottomBar/user (1) 1.png',
//                   color: Colors.white,
//                 ),
//               ),
//               icon: Image.asset(
//                 'assets/bottomBar/user (1) 1.png',
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
//                 child: Image.asset(
//                   'assets/bottomBar/online-learning 1.png',
//                   color: Colors.white,
//                 ),
//               ),
//               icon: Image.asset(
//                 'assets/bottomBar/online-learning 1.png',
//               ),
//               backgroundColor: Colors.white),
//           BottomNavigationBarItem(
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
//                 child: Image.asset(
//                   'assets/bottomBar/Vector (4).png',
//                   color: Colors.white,
//                 ),
//               ),
//               icon: Image.asset('assets/bottomBar/Vector (4).png'),
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
//                 child: Image.asset(
//                   'assets/bottomBar/Vector (2).png',
//                   color: Colors.white,
//                 ),
//               ),
//               icon: Image.asset('assets/bottomBar/Vector (2).png'),
//               backgroundColor: Colors.white),



//        ])) ,
//      );
//   }
// }