import 'dart:typed_data';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/components/tutorHomeComponents.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/hostel_enquiry_controller.dart';
import 'package:hovee_attendence/controllers/hostel_enrollement_controller.dart';
import 'package:hovee_attendence/controllers/notification_controller.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_announcement_screen.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_attendance_screen.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_enquiry_list.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_enrollment_screen.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_list.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_msp_screen.dart';
import 'package:hovee_attendence/view/Tutee/tuteeAttendanceList.dart';
import 'package:hovee_attendence/view/announcement_screen.dart';
import 'package:hovee_attendence/view/attendanceCourseList_screen.dart';
import 'package:hovee_attendence/view/leave_screen.dart';
import 'package:hovee_attendence/view/msp_screen.dart';
import 'package:hovee_attendence/view/notification_screen.dart';
import 'package:hovee_attendence/view/profile_card.dart';
import 'package:hovee_attendence/view/sidemenu.dart';
import 'package:hovee_attendence/view/userProfile.dart';
import 'package:hovee_attendence/widget/gifController.dart';
import 'package:hovee_attendence/widget/subjectContainer.dart';
import 'package:logger/logger.dart';
import 'package:share_plus/share_plus.dart';

import '../../controllers/hosteller_controller.dart';

class HostellerHomeScreen extends StatelessWidget {
  final String? firstname, lastname, wowid;
    final VoidCallback onDashBoardBack;
  const HostellerHomeScreen({super.key, this.firstname, this.lastname, this.wowid, required this.onDashBoardBack});

  @override
  Widget build(BuildContext context) {
     final HostellerController controller = Get.put(HostellerController());
      final NotificationController noticontroller =
        Get.put(NotificationController());
         final userProfileData = Get.put(UserProfileController());
          final HostelEnquiryController hostelEnquiryController =
        Get.put(HostelEnquiryController());
    final HostelEnrollementController hostelEnrollmentController =
        Get.put(HostelEnrollementController());
    return Scaffold(
      key: controller.hostellerScaffoldKey,
      drawer: SideMenu(
        isGuest: false,
      ),
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
                    controller.hostellerScaffoldKey.currentState!.openDrawer();
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
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          noticontroller.onInit();
                          Get.to(() => NotificationScreen(
                                type: 'Hosteller',
                                  firstname: firstname,
              lastname: lastname,
              wowid: wowid
                              ));
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
                            child: 
                            noticontroller.notificationCount.value > 0
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
                  const SizedBox(
                    width: 10,
                  ),
                 
                  Obx(() {
                    if(controller.role.value=='Hosteller'){
                      return InkWell(
                      onTap: () {
                      },
                      child: Icon(
                        Icons.message,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    );
                    }
                    else{
                      return InkWell(
                      onTap: () {
                          _showQrCodeBottomSheet(
                        context, controller.qrcodeImageData!);
                      },
                      child: Icon(
                        Icons.qr_code,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    );
                    }
                  })
                ],
              ),
            ),
          ],
        ),
        centerTitle: false,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value || userProfileData.isLoading.value) {
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
                        Get.to(() => UserProfile(type: 'Hosteller',));
                      },
                      child: HomePageHeader(
                        title: 'Attendance Monitoring',
                        userType: "Hosteller",
                        firstName: firstname,
                        lastName: lastname,
                        wowId: wowid,
                      ),
                    ),
                    // SizedBox(
                    //   height: MediaQuery.sizeOf(context).height * 0.8,
                    // ),

                    // Padding(
                    //   padding: const EdgeInsets.all(5.0),
                    //   child: Text(
                    //     'Attendance',
                    //     style: GoogleFonts.nunito(
                    //         fontSize: 18, fontWeight: FontWeight.w700),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.all(0),
                    //   child: Card(
                    //     elevation: 10,
                    //     shadowColor: Colors.grey.shade100,
                    //     surfaceTintColor: Colors.white,
                    //     child: Container(
                    //       width: MediaQuery.sizeOf(context).width * 0.9,
                    //       child: Column(
                    //         mainAxisSize: MainAxisSize.min,
                    //         children: [
                    //           // const SizedBox(height: 10),
                    //           Obx(() {
                    //             if (controller.isLoading.value) {
                    //               return const CircularProgressIndicator(); // Show loading indicator if no batches are fetched
                    //             } else {
                    //               return CustomDropdown(
                    //                 hintText: 'Select batch',
                    //                 items: controller.batchList
                    //                     .map((batch) => batch.batchName ?? '')
                    //                     .toSet() // Remove duplicates
                    //                     .toList(),
                    //                 initialItem: controller
                    //                     .selectedBatchIN.value?.batchName,
                    //                 onChanged: (String? selectedValue) {
                    //                   if (selectedValue != null) {
                    //                     final selectedBatch =
                    //                         controller.batchList.firstWhere(
                    //                       (batch) =>
                    //                           batch.batchName == selectedValue,
                    //                     );
                    //                     controller.selectBatch(selectedBatch);
                    //                     controller.isBatchSelected.value =
                    //                         true;
                    //                     controller.fetchBatchList(
                    //                         selectedBatch.batchId!);
                    //                   }
                    //                 },
                    //               );
                    //             }
                    //           }),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // controller.dailyattendance.value != null
                    //     ? ChartApp()
                    //     : ChartApp1(),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    controller.role!='Hostel'?
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const SizedBox.shrink();
                      } else if (controller
                          .homeDashboardHostelList.isEmpty) {
                        return const SizedBox.shrink();
                      } else {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'My hostel',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => AttendanceHostelListScreen());
                                  },
                                  child: const Text(
                                    'See All',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            SubjectContainerHostel(),
                          ],
                        );
                      }
                    }):SizedBox.shrink(),

                    // const SizedBox(
                    //   height: 10,
                    // ),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const SizedBox.shrink();
                      }
                      final filteredList = controller.homeDashboardNavList.value
                          .where((item) => item.name != 'Dashboard')
                          .toList();
                      if (filteredList.isEmpty) {
                        return const Center(child: Text('No items to display'));
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              'My listings',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                          Animate(
  child: GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      childAspectRatio: 1.0,
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
    ),
    itemCount: controller.homeDashboardNavList.value
            .where((item) => item.name != 'Dashboard' && item.name != 'Ratings')
            .length + 1, // Extra item
    itemBuilder: (context, index) {
      final filteredList = controller.homeDashboardNavList.value
          .where((item) => item.name != 'Dashboard' && item.name != 'Ratings')
          .toList();

      // Handle the additional item separately
      if (index == filteredList.length) {
        return SizedBox.shrink(); // Add a separate widget for the extra item
      }

      final item = filteredList[index];

      Color myColor = Color(
        int.parse((item.color ?? "#FFFFFF").replaceAll("#", "0xFF")),
      );

      return InkWell(
        onTap: () {
          if (item.name == 'Hostel List') {
            Get.to(() => HostelList());
          } else if (item.name == 'Verifications') {
             hostelEnquiryController.onInit();
            Get.to(() => HostelEnquiryList(
                  type: controller.role.value ?? '',
                  fromBottomNav: true,
                  firstname: firstname,
                  lastname: lastname,
                  wowid: wowid,
                ));
          } else if (item.name == 'Enrollments') {
             hostelEnrollmentController.onInit();
            Get.to(() => HostelEnrollmentScreen(
                  type: controller.role.value ?? '',
                  fromBottomNav: true,
                  firstname: firstname,
                  lastname: lastname,
                  wowid: wowid,
                ));
          } else if (item.name == 'Attendance') {
            Get.to(() => HostelAttendanceScreen(
                  type: controller.role.value.obs,
                  firstname: firstname,
                  lastname: lastname,
                  wowid: wowid,
                ),arguments: controller.role.value);
          } else if (item.name == 'Leave') {
          } else if (item.name == 'Miss punch') {
            Get.to(() => HostelMspScreen(
                                            type: controller.role.value,
                                            fromBottomNav: true,
                                            firstname: firstname,
                                            lastname: lastname,
                                            wowid: wowid,
                                          ));
          }
         else if (item.name == 'Announcement') {
                                      Get.to(() => HostelAnnouncementScreen(
                                            type: controller.role.value,
                                            firstname:firstname ,lastname:lastname ,wowid: wowid,
                                          ));
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
              color: const Color.fromRGBO(246, 244, 254, 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: myColor,
                  ),
                  child: item.image != null
                      ? Image.asset(
                          item.image!,
                          color: Colors.white,
                          height: 30,
                        )
                      : const SizedBox.shrink(),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    item.name!,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ),
).animate().shimmer().slide()
 ],
                      );
                    }),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
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
              Image.memory(qrCodeUrl),
              const SizedBox(height: 10),
              Text('Please scan the QR code to mark attendance',style:  GoogleFonts.nunito(
                            fontSize: 14, fontWeight: FontWeight.w700)),
                             const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Share.share(qrCodeUrl.toString(), subject: 'QR Code');
                },
                icon: const Icon(Icons.share),
                label: const Text('Share'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}