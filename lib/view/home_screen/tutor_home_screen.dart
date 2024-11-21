import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/components/tutorHomeComponents.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/enquir_controller.dart';
import 'package:hovee_attendence/controllers/enrollment_controller.dart';
import 'package:hovee_attendence/controllers/tutorHome_controllers.dart';
import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';
import 'package:hovee_attendence/view/Tutor/tutorsStudentAttendenceList.dart';
import 'package:hovee_attendence/view/add_class_screen.dart';
import 'package:hovee_attendence/view/attendanceCourseList_screen.dart';
import 'package:hovee_attendence/view/batch_screen.dart';
import 'package:hovee_attendence/view/class_screen.dart';
import 'package:hovee_attendence/view/course_screen.dart';
import 'package:hovee_attendence/view/enrollment_screen.dart';
import 'package:hovee_attendence/view/sidemenu.dart';
import 'package:hovee_attendence/view/tutor_attendance_screen.dart';
import 'package:hovee_attendence/view/userProfile.dart';
import 'package:hovee_attendence/widget/gifController.dart';
import 'package:share_plus/share_plus.dart';

class TutorHome extends StatelessWidget {
  TutorHome({super.key});
  final TutorHomeController controller = Get.put(TutorHomeController());
  final EnquirDetailController classController =
      Get.put(EnquirDetailController());
      final EnrollmentController enrollmentController = Get.put(EnrollmentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.tutorScaffoldKey,
      drawer:  SideMenu(isGuest: false),
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
                // mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/appbar/bell 5.png',
                    color: Colors.black.withOpacity(0.4),
                    height: 30,
                  ),
                  // const SizedBox(
                  //   width: 05,
                  // ),
                  // InkWell(
                  //   onTap: () {
                  //     // Navigator.push(
                  //     //     context,
                  //     //     MaterialPageRoute(
                  //     //         builder: (context) => const ChatScreen()));
                  //   },
                  //   child: Icon(
                  //     Icons.message,
                  //     color: Colors.black.withOpacity(0.4),
                  //   ),
                  // )
                  
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  _showQrCodeBottomSheet(
                context,
                 controller.qrcodeImageData!
               );
                },
                icon: const Icon(Icons.qr_code))
          ],
        ),
        centerTitle: false,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(()=>UserProfile());
                    },
                    child: const HomePageHeader(
                      title: 'Attendance Monitoring',
                      userType: "Tutor",
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.18,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Daily Attendance',
                      style: GoogleFonts.nunito(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const ChartApp(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    ' My Listings',
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.0,
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10 // Number of columns
                            ),
                    itemBuilder: (context, int index) {
                      final item = controller.monitor[index];
                      return InkWell(
                        onTap: () {
                          // Navigate to different screens based on the title
                          if (item['title'] == 'Batches') {
                            Get.to(() =>
                                TutorBatchList()); // Navigate to the batch screen
                          } else if (item['title'] == 'Courses') {
                            Get.to(() =>
                                const TutorCourseList(type: 'Tutor',)); // Navigate to the course screen

                                } else if (item['title'] == 'Attendance') {
                            Get.to(() => StudentAttendanceList(type: 'Tutor',)); // Navigate to the course screen

                            }  else if (item['title'] == 'Classes') {
                            Get.to(() => TutorClassList()); // Navigate to the course screen

                                
                          }  
                          else if (item['title'] == 'Enquiries') {
                             classController.onInit();
                            Get.to(() => Tutorenquirlist(type: 'Tutor', fromBottomNav: true,));  Get.to(() => Tutorenquirlist(type: 'Tutor', fromBottomNav: true,)); // Navigate to the course screen

                                
                          }  
 else if (item['title'] == 'Enrollment') {
  enrollmentController.onInit();
                           Get.to(()=> EnrollmentScreen(type: 'Tutor', fromBottomNav: true,)); // Navigate to the course screen

                                
                          }  
                           
                           else {
                            // Handle other cases or do nothing
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
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: item['color']),
                                  child: Image.asset(
                                    item['image'],
                                    color: Colors.white,
                                    height: 30,
                                  ),
                                ),
                                Text(item['title'],style: TextStyle(fontSize: 16),)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.monitor.length,
                  ),
                ],
              ),
            ),
            Positioned(
                left: 20,
                right: 20,
                top: MediaQuery.sizeOf(context).height * 0.18,
                child: const LineChartSample(userType: 'Tutor',)),
          ],
        ),
      ),
    );
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
  const HomePageHeader(
      {super.key, required this.title, required this.userType});
  final String title;
  final String userType;

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthControllers>();
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
                             Text('${authController.otpResponse.value.data!.firstName} ${authController.otpResponse.value.data!.lastName}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 24.0,
                                  color: Colors.white,
                                )),
                                  Text("${userType}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20.0,
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
                        Text(
                            '${authController.otpResponse.value.data!.wowId!}',
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
            if(userType == "Tutor")
            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
