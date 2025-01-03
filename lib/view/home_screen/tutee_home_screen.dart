import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/components/tutorHomeComponents.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/enquir_controller.dart';
import 'package:hovee_attendence/controllers/enrollment_controller.dart';
import 'package:hovee_attendence/controllers/notification_controller.dart';
import 'package:hovee_attendence/controllers/tuteeHome_controllers.dart';
import 'package:hovee_attendence/controllers/tutorHome_controllers.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/view/Tutee/tuteeAttendanceList.dart';
import 'package:hovee_attendence/view/Tutee/tutee_courseList.dart';
import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';
import 'package:hovee_attendence/view/announcement_screen.dart';
import 'package:hovee_attendence/view/attendanceCourseList_screen.dart';
import 'package:hovee_attendence/view/enrollment_screen.dart';
import 'package:hovee_attendence/view/leave_screen.dart';
import 'package:hovee_attendence/view/msp_screen.dart';
import 'package:hovee_attendence/view/notification_screen.dart';
import 'package:hovee_attendence/view/parent_login_screen.dart';
import 'package:hovee_attendence/view/profile_card.dart';
import 'package:hovee_attendence/view/sidemenu.dart';
import 'package:hovee_attendence/view/tutee_holiday_screen.dart';
import 'package:hovee_attendence/view/userProfile.dart';
import 'package:hovee_attendence/widget/gifController.dart';
import 'package:hovee_attendence/widget/subjectContainer.dart';
import 'package:logger/logger.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TuteeHome extends StatelessWidget {
  final String? firstname, lastname, wowid;
    final VoidCallback onDashBoardBack;
  const TuteeHome({super.key, this.firstname, this.lastname, this.wowid, required this.onDashBoardBack});

  @override
  Widget build(BuildContext context) {
    final TuteeHomeController controller = Get.put(TuteeHomeController());
    final EnquirDetailController classController =
        Get.put(EnquirDetailController());
    final EnrollmentController enrollmentController =
        Get.put(EnrollmentController());
    final TutorHomeController controller1 = Get.put(TutorHomeController());
    final NotificationController noticontroller =
        Get.put(NotificationController());
        final userProfileData = Get.put(UserProfileController());
    return Scaffold(
      key: controller.tuteeScaffoldKey,
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
                    controller.tuteeScaffoldKey.currentState!.openDrawer();
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
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => NotificationScreen(
                                type: 'Tutee',
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
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const ChatScreen()));
                    },
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
                        Get.to(() => UserProfile());
                      },
                      child: HomePageHeader(
                        title: 'Attendance Monitoring',
                        userType: "Tutee",
                        firstName: firstname,
                        lastName: lastname,
                        wowId: wowid,
                      ),
                    ),
                    // SizedBox(
                    //   height: MediaQuery.sizeOf(context).height * 0.8,
                    // ),

                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Attendance',
                        style: GoogleFonts.nunito(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Card(
                        elevation: 10,
                        shadowColor: Colors.grey.shade100,
                        surfaceTintColor: Colors.white,
                        child: Container(
                          // padding: const EdgeInsets.symmetric(
                          //     horizontal: 12, vertical: 10),
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          // decoration: const BoxDecoration(
                          //   borderRadius: BorderRadius.all(Radius.circular(8)),
                          //   image: DecorationImage(
                          //       image:
                          //           AssetImage('assets/Course_BG_Banner.png'),
                          //       fit: BoxFit.cover),
                          // ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // const SizedBox(height: 10),
                              Obx(() {
                                if (controller1.isLoading.value) {
                                  return const CircularProgressIndicator(); // Show loading indicator if no batches are fetched
                                } else {
                                  return CustomDropdown(
                                    hintText: 'Select batch',
                                    items: controller1.batchList
                                        .map((batch) => batch.batchName ?? '')
                                        .toSet() // Remove duplicates
                                        .toList(),
                                    initialItem: controller1
                                        .selectedBatchIN.value?.batchName,
                                    onChanged: (String? selectedValue) {
                                      if (selectedValue != null) {
                                        final selectedBatch =
                                            controller1.batchList.firstWhere(
                                          (batch) =>
                                              batch.batchName == selectedValue,
                                        );
                                        controller1.selectBatch(selectedBatch);
                                        controller1.isBatchSelected.value =
                                            true;
                                        controller1.fetchBatchList(
                                            selectedBatch.batchId!);
                                      }
                                    },
                                  );
                                }
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    controller1.dailyattendance.value != null
                        ? ChartApp()
                        : ChartApp1(),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const SizedBox.shrink();
                      } else if (controller
                          .homeDashboardCourseList.value.isEmpty) {
                        return const SizedBox.shrink();
                      } else {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'My Classes',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(() => AttendanceCourseListScreen());
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
                            SubjectContainer(),
                          ],
                        );
                      }
                    }),

                    const SizedBox(
                      height: 10,
                    ),
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
                              'My Listings',
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
                                    if (index == controller.homeDashboardNavList.value
                                  .where((item) => item.name != 'Dashboard')
                                  .length ) {
        // Logic for the additional item at the end
        return InkWell(
          onTap: () {
            // // Handle tap for the additional item
            Get.to(() => ParentLoginScreen(rolename: 'Tutee',   firstname:firstname ,lastname:lastname ,wowid: wowid,));
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey, // Custom color for the additional item
                    ),
                    child: const Icon(
                      Icons.add, // Use an icon for the additional item
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      "Invite Parent", // Label for the additional item
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
                                // final filteredList = controller
                                //     .homeDashboardNavList.value
                                //     .where((item) => item.name != 'Dashboard')
                                //     .toList();
                                final item = filteredList[index];
                                Color myColor = Color(
                                  int.parse((item.color ?? "#FFFFFF")
                                      .replaceAll("#", "0xFF")),
                                );
                            
                                return InkWell(
                                  onTap: () {
                                    if (item.name == 'Course list') {
                                      var box = GetStorage();
                                      Logger().i("${box.read('Token')}");
                                      Get.to(() =>  GetTopicsCourses(
                                            type: 'Tutee',
                                            firstname:firstname ,lastname:lastname ,wowid: wowid,
                                          ));
                                    }
                                    if (item.name == 'Enquires') {
                                      classController.onInit();
                                      Get.to(() => Tutorenquirlist(
                                            type: 'Tutee',
                                            fromBottomNav: true,
                                            firstname:firstname ,lastname:lastname ,wowid: wowid,
                                          ));
                                    }
                                    if (item.name == 'Enrollments') {
                                      enrollmentController.onInit();
                                      Get.to(() => EnrollmentScreen(
                                            type: 'Tutee',
                                            fromBottomNav: true,
                                            firstname:firstname ,lastname:lastname ,wowid: wowid,
                                          ));
                                    }
                                    if (item.name == 'Attendance') {
                                      Get.to(
                                          () => TuteeAttendanceList(
                                                type: 'Tutee',
                                                 firstname:firstname ,lastname:lastname ,wowid: wowid,
                                              ),
                                          arguments: "Tutee");
                                    }
                                    if (item.name == 'Leave') {
                                      Get.to(() => TuteeLeaveScreen(
                                            type: 'Tutee',
                                            fromBottomNav: true,
                                             firstname:firstname ,lastname:lastname ,wowid: wowid,
                                          ));
                                    }
                                    if (item.name == 'Miss Punch') {
                                      Get.to(() => MspScreen(
                                            type: 'Tutee',
                                            fromBottomNav: true,
                                             firstname:firstname ,lastname:lastname ,wowid: wowid,
                                          ));
                                    }
                                    if (item.name == 'Holiday') {
                                      Get.to(() =>
                                          TuteeHolidayScreen(type: 'Tutee',firstname: firstname,
            lastname: lastname,
            wowid: wowid,));
                                    }
                                    if (item.name == 'Announcement') {
                                      Get.to(() => AnnouncementScreen(
                                            type: 'Tutee',
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
                                )
                                  
                                  ;
                              },
                              itemCount: controller.homeDashboardNavList.value
                                  .where((item) => item.name != 'Dashboard')
                                  .length + 1,
                            ),
                          ) .animate().shimmer().slide()
                                  ,
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
