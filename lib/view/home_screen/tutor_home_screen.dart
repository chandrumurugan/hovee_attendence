import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/components/tutorHomeComponents.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/enquir_controller.dart';
import 'package:hovee_attendence/controllers/enrollment_controller.dart';
import 'package:hovee_attendence/controllers/notification_controller.dart';
import 'package:hovee_attendence/controllers/splash_controllers.dart';
import 'package:hovee_attendence/controllers/tuteeHome_controllers.dart';
import 'package:hovee_attendence/controllers/tutorHome_controllers.dart';
import 'package:hovee_attendence/modals/validateTokenModel.dart';
import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';
import 'package:hovee_attendence/view/Tutor/tutorsStudentAttendenceList.dart';
import 'package:hovee_attendence/view/add_class_screen.dart';
import 'package:hovee_attendence/view/attendanceCourseList_screen.dart';
import 'package:hovee_attendence/view/batch_screen.dart';
import 'package:hovee_attendence/view/class_screen.dart';
import 'package:hovee_attendence/view/course_screen.dart';
import 'package:hovee_attendence/view/enrollment_screen.dart';
import 'package:hovee_attendence/view/holiday_screen.dart';
import 'package:hovee_attendence/view/home_screen/tutee_home_screen.dart';
import 'package:hovee_attendence/view/notification_screen.dart';
import 'package:hovee_attendence/view/sidemenu.dart';
import 'package:hovee_attendence/view/tutor_attendance_screen.dart';
import 'package:hovee_attendence/view/userProfile.dart';
import 'package:hovee_attendence/widget/gifController.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorHome extends StatelessWidget {
  TutorHome({super.key});
  final TutorHomeController controller = Get.put(TutorHomeController());
  final EnquirDetailController classController =
      Get.put(EnquirDetailController());
  final EnrollmentController enrollmentController =
      Get.put(EnrollmentController());
  final SplashController splashController = Get.find();
  final TuteeHomeController tuteecontroller = Get.put(TuteeHomeController());
   final NotificationController noticontroller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.tutorScaffoldKey,
      drawer: SideMenu(isGuest: false),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 5,
        shadowColor: Colors.grey.shade100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    controller.tutorScaffoldKey.currentState!.openDrawer();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const SideMenu()));
                  },
                  child: Image.asset(
                    'assets/appbar/Group 2322.png',
                    color: AppConstants.primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                const LogoGif()
                // SvgPicture.asset(
                //   'assets/appbar/hovee_attendance_app_icon_.svg',
                //   height: 40,
                // ),
                // Image.asset(
                //   'assets/appConstantImg/colorlogoword.png',
                //   height: 30,
                // ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => NotificationScreen(type: 'Tutor',));
                        },
                        child: Image.asset(
                          'assets/appbar/bell 5.png',
                          color: Colors.black.withOpacity(0.4),
                          height: 30,
                        ),
                      ),
                      Obx(() => Positioned(
                            right: 1,
                            top: 1,
                            child: noticontroller.notificationCount.value > 0
                                ? Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 12,
                                      minHeight: 12,
                                    ),
                                    child: Text(
                                      '${noticontroller.notificationCount.value}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : const SizedBox(),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  _showQrCodeBottomSheet(context, controller.qrcodeImageData!);
                },
                icon: const Icon(Icons.qr_code))
          ],
        ),
        centerTitle: false,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: Obx(() { 
       if (controller.isLoading.value) {
          // Call your refresh logic here, e.g., re-fetch data
          // Reset the refresh state
          return const Center(child: CircularProgressIndicator());
        }
      return SingleChildScrollView(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => UserProfile());
                          },
                          child: HomePageHeader(
                            title: 'Attendance Monitoring',
                            userType: "Tutor",
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.18,
                        ),
      
                        Obx(() {
                          if (controller.isLoading.value) {
                            return const SizedBox.shrink();
                          } else if (controller.dailyattendance.value == null) {
                            return const SizedBox.shrink();
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Visibility(
                                  visible: !controller.isLoading.value,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      'Daily Attendance',
                                      style: GoogleFonts.nunito(
                                          fontSize: 18, fontWeight: FontWeight.w700),
                                    ),
                                  )),
                              Visibility(
                                  visible: !controller.isLoading.value,
                                  child: ChartApp()),
                            ],
                          );
                        }),
      
                        // controller.dailyattendance.value != null
                        // ? Padding(
                        //     padding: const EdgeInsets.all(5.0),
                        //     child: Text(
                        //       'Daily Attendance',
                        //       style: GoogleFonts.nunito(
                        //           fontSize: 18, fontWeight: FontWeight.w700),
                        //     ),
                        //   )
                        //     : Container(),
                        // controller.dailyattendance.value != null
                        //     ? ChartApp()
                        //     : Container(),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        Obx(() {
                          if (controller.isLoading.value) {
                            return const SizedBox.shrink();
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  ' My Listings',
                                  style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1.0,
                                  crossAxisCount: 3, // Number of columns
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemCount: controller.homeDashboardNavList.value
                                    .where((item) => item.name != 'Dashboard')
                                    .length,
                                itemBuilder: (context, int index) {
                                  final filteredList = controller
                                      .homeDashboardNavList.value
                                      .where((item) => item.name != 'Dashboard')
                                      .toList();
                                  final item = filteredList[index];
      
                                  Color myColor = Color(
                                    int.parse((item.color ?? "#FFFFFF")
                                        .replaceAll("#", "0xFF")),
                                  );
      
                                  return InkWell(
                                    onTap: () {
                                      // Navigate to different screens based on the title
                                      if (item.name == 'Batches') {
                                        Get.to(() => TutorBatchList(type: 'Tutor',));
                                      } else if (item.name == 'Courses') {
                                        Get.to(() =>
                                            const TutorCourseList(type: 'Tutor'));
                                      } else if (item.name == 'Attendance') {
                                        Get.to(
                                            () =>
                                                StudentAttendanceList(type: 'Tutor'),
                                            arguments: "Tutor");
                                      } else if (item.name == 'Tution Classes') {
                                        Get.to(() => TutorClassList(type: 'Tutor',));
                                      } else if (item.name == 'Enquires') {
                                        classController.onInit();
                                        Get.to(() => Tutorenquirlist(
                                            type: 'Tutor', fromBottomNav: true));
                                      } else if (item.name == 'Enrollments') {
                                        enrollmentController.onInit();
                                        Get.to(() => EnrollmentScreen(
                                            type: 'Tutor', fromBottomNav: true));
                                      }
                                         else if (item.name == 'Holiday') {
                                        Get.to(() =>
                                             HolidayScreen(type: 'Tutor'));
                                      } 
                                       else {
                                        print('Unknown screen');
                                      }
                                    },
                                    child: Card(
                                      elevation: 10,
                                      shadowColor: Colors.grey,
                                      surfaceTintColor: Colors.white,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: myColor,
                                        ),
                                        child: item.image != null
                                            ? Image.asset(
                                                item.image!,
                                                color: Colors.white,
                                                height: 30,
                                              )
                                            : SizedBox.shrink(),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          item.name!,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
            Positioned(
                left: 20,
                right: 20,
                top: MediaQuery.sizeOf(context).height * 0.18,
                child: const LineChartSample(
                  userType: 'Tutor',
                )),
          ],
        ),
      );
      }
    ));
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
              // CachedNetworkImage(
              //   imageUrl: qrCodeUrl,
              //   placeholder: (context, url) => CircularProgressIndicator(),
              //   errorWidget: (context, url, error) => Icon(Icons.error),
              //   width: 200,
              //   height: 200,
              // ),
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

class HomePageHeader extends StatelessWidget {
  @override
  HomePageHeader({super.key, required this.title, required this.userType});
  final String title;
  final String userType;
  @override
  Widget build(BuildContext context) {
    //final authController = Get.find<AuthControllers>();
    final AuthControllers authController = Get.put(AuthControllers());

    return Obx(() {
      if (authController.isLoading.value) {
        return const SizedBox.shrink();
      } else {
        return Container(
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
                                  const Text('4.2',
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
                            Text('${authController.loginData!.wowId!}',
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
      }
    });
  }
}

class LoginData {
  String? firstName;
  String? lastName;
  String? wowId;

  LoginData({this.firstName, this.lastName, this.wowId});

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'wowId': wowId,
    };
  }

  // Convert JSON back to object
  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      firstName: json['firstName'],
      lastName: json['lastName'],
      wowId: json['wowId'],
    );
  }
}
