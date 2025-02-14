import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/hostel_controller.dart';
import 'package:hovee_attendence/controllers/hosteller_controller.dart';
import 'package:hovee_attendence/controllers/notification_controller.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_attendance_screen.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_enquiry_list.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_enrollment_screen.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_list.dart';
import 'package:hovee_attendence/view/Tutee/tuteeAttendanceList.dart';
import 'package:hovee_attendence/view/leave_screen.dart';
import 'package:hovee_attendence/view/msp_screen.dart';
import 'package:hovee_attendence/view/notification_screen.dart';
import 'package:hovee_attendence/view/profile_card.dart';
import 'package:hovee_attendence/view/sidemenu.dart';
import 'package:hovee_attendence/view/userProfile.dart';
import 'package:hovee_attendence/widget/gifController.dart';

class HostelHomeScreen extends StatelessWidget {
  final String? firstname, lastname, wowid;
  final VoidCallback onDashBoardBack;
  const HostelHomeScreen(
      {super.key,
      this.firstname,
      this.lastname,
      this.wowid,
      required this.onDashBoardBack});

  @override
  Widget build(BuildContext context) {
    final HostelController controller = Get.put(HostelController());
    final NotificationController noticontroller =
        Get.put(NotificationController());
    final userProfileData = Get.put(UserProfileController());
    return Scaffold(
      key: controller.hostelScaffoldKey,
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
                    controller.hostelScaffoldKey.currentState!.openDrawer();
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
                          Get.to(() => NotificationScreen(
                              type: 'Hostel',
                              firstname: firstname,
                              lastname: lastname,
                              wowid: wowid));
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
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.message,
                      color: Colors.black.withOpacity(0.4),
                    ),
                  )
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
                        Get.to(() => UserProfile(
                              type: 'Hostel',
                            ));
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
                    // Obx(() {
                    //   if (controller.isLoading.value) {
                    //     return const SizedBox.shrink();
                    //   } else if (controller
                    //       .homeDashboardCourseList.value.isEmpty) {
                    //     return const SizedBox.shrink();
                    //   } else {
                    //     return Column(
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             const Text(
                    //               'My Classes',
                    //               style: TextStyle(
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.w500,
                    //                   color: Colors.black),
                    //             ),
                    //             InkWell(
                    //               onTap: () {
                    //                 Get.to(() => AttendanceCourseListScreen());
                    //               },
                    //               child: const Text(
                    //                 'See All',
                    //                 style: TextStyle(
                    //                     fontSize: 16,
                    //                     fontWeight: FontWeight.w500,
                    //                     color: Colors.black),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         SubjectContainer(),
                    //       ],
                    //     );
                    //   }
                    // }),

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
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1.0,
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10 // Number of columns
                                      ),
                              itemBuilder: (context, int index) {
                                if (index ==
                                    controller.homeDashboardNavList.value
                                        .where(
                                            (item) => item.name != 'Dashboard')
                                        .length) {
                                  // Logic for the additional item at the end
                                }

                                final item = filteredList[index];
                                Color myColor = Color(
                                  int.parse((item.color ?? "#FFFFFF")
                                      .replaceAll("#", "0xFF")),
                                );

                                return InkWell(
                                  onTap: () {
                                    if (item.name == 'Hostel List') {
                                      Get.to(() => HostelList());
                                    }
                                    if (item.name == 'Verifications') {
                                      // classController.onInit();
                                      Get.to(() => HostelEnquiryList(
                                            type: 'Hostel',
                                            fromBottomNav: true,
                                            firstname: firstname,
                                            lastname: lastname,
                                            wowid: wowid,
                                          ));
                                    }
                                    if (item.name == 'Enrollments') {
                                      // enrollmentController.onInit();
                                      Get.to(() => HostelEnrollmentScreen(
                                            type: 'Hostel',
                                            fromBottomNav: true,
                                            firstname: firstname,
                                            lastname: lastname,
                                            wowid: wowid,
                                          ));
                                    }
                                    if (item.name == 'Attendance') {
                                      Get.to(
                                          () => HostelAttendanceScreen(
                                                type: 'Hostel',
                                                firstname: firstname,
                                                lastname: lastname,
                                                wowid: wowid,
                                              ),
                                          arguments: "Hostel");
                                    }
                                    if (item.name == 'Leave') {
                                      Get.to(() => TuteeLeaveScreen(
                                            type: 'Tutee',
                                            fromBottomNav: true,
                                            firstname: firstname,
                                            lastname: lastname,
                                            wowid: wowid,
                                          ));
                                    }
                                    if (item.name == 'Miss Punch') {
                                      Get.to(() => MspScreen(
                                            type: 'Tutee',
                                            fromBottomNav: true,
                                            firstname: firstname,
                                            lastname: lastname,
                                            wowid: wowid,
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: const Color.fromRGBO(
                                              246, 244, 254, 1)),
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
                                                color: myColor),
                                            child: item.image != null
                                                ? Image.asset(
                                                    item.image!,
                                                    color: Colors.white,
                                                    height: 30,
                                                  )
                                                : const SizedBox.shrink(),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Text(
                                              item.name!,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount: controller.homeDashboardNavList.value
                                      .where((item) => item.name != 'Dashboard')
                                      .length +
                                  1,
                            ),
                          ).animate().shimmer().slide(),
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
}
