import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/attendance_controller.dart';
import 'package:hovee_attendence/controllers/hosteller_controller.dart';
import 'package:hovee_attendence/controllers/tuteeHome_controllers.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/widget/attendanceCourseList_container.dart';

class AttendanceCourseListScreen extends StatelessWidget {
   AttendanceCourseListScreen({super.key});
    final TuteeHomeController attendanceCourseListController = Get.put(TuteeHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
     appBar:  AppBarHeader(
        needGoBack: true,
        navigateTo: () {
           Get.back();
           attendanceCourseListController.onInit();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SearchfiltertabBar(
          //   title: 'My Classes',
          //   onSearchChanged: (searchTerm) {
          //   },
          //   filterOnTap: () {
          //     // Implement filter logic here if needed
          //   },
          // ),
           Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text(
                  'My classes',
                  style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
          //  SearchfiltertabBar(
          //   title: 'My Classes',
          //   searchOnTap: () {},
          //   filterOnTap: () {},
          // ),
           Expanded(
            child: Obx(() {
              if (attendanceCourseListController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (attendanceCourseListController.homeDashboardCourseList.isEmpty) {
                // Display "No data found" when the list is empty
                return Center(
                  child: Text(
                    'No list found',
                    style: GoogleFonts.nunito(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                );
              } else {
                // Display the list of batches
                return ListView.builder(
                  itemCount: attendanceCourseListController.homeDashboardCourseList.length,
                  itemBuilder: (context, index) {
                    //final attendanceCourse = attendanceCourseListController.homeDashboardCourseList[index];
                    return AttendancecourselistContainer(attendanceCourse: attendanceCourseListController.homeDashboardCourseList[index]);
                  },
                );
              }
            }),
          )
        ],
      ),
    );
  }
}

class AttendanceHostelListScreen extends StatelessWidget {
   AttendanceHostelListScreen({super.key});
    final HostellerController attendanceCourseListController = Get.put(HostellerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
     appBar:  AppBarHeader(
        needGoBack: true,
        navigateTo: () {
           Get.back();
           attendanceCourseListController.onInit();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SearchfiltertabBar(
          //   title: 'My Classes',
          //   onSearchChanged: (searchTerm) {
          //   },
          //   filterOnTap: () {
          //     // Implement filter logic here if needed
          //   },
          // ),
           Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text(
                  'My hostel',
                  style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
          //  SearchfiltertabBar(
          //   title: 'My Classes',
          //   searchOnTap: () {},
          //   filterOnTap: () {},
          // ),
           Expanded(
            child: Obx(() {
              if (attendanceCourseListController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (attendanceCourseListController.homeDashboardHostelList.isEmpty) {
                // Display "No data found" when the list is empty
                return Center(
                  child: Text(
                    'No list found',
                    style: GoogleFonts.nunito(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                );
              } else {
                // Display the list of batches
                return ListView.builder(
                  itemCount: attendanceCourseListController.homeDashboardHostelList.length,
                  itemBuilder: (context, index) {
                    return AttendanceHostellistContainer(attendanceCourse: attendanceCourseListController.homeDashboardHostelList[index], hostellerObjectIdDetails: attendanceCourseListController.hostellerObjectIdDetails, hostelObjectIdDetails: attendanceCourseListController.hostelObjectIdDetails,hostelListDetail:attendanceCourseListController.homeDashboardHostelListDetails[index] ,);
                  },
                );
              }
            }),
          )
        ],
      ),
    );
  }
}