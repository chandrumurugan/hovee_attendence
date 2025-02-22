import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/hosteller_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/widget/attendanceCourseList_container.dart';

class HostellerAttendancelist extends StatelessWidget {
   HostellerAttendancelist({super.key});
    final HostellerController attendanceCourseListController = Get.put(HostellerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  resizeToAvoidBottomInset: true,
  appBar: AppBarHeader(
    needGoBack: true,
    navigateTo: () {
      Get.back();
      attendanceCourseListController.onInit();
    },
  ),
  body: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Text(
          'My classes',
          style: GoogleFonts.nunito(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.black),
        ),
      ),
      Expanded(
        child: GetBuilder<HostellerController>(
          builder: (controller) {
            if (attendanceCourseListController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (attendanceCourseListController.homeDashboardHostelList.isEmpty) {
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
              return ListView.builder(
                itemCount: attendanceCourseListController.homeDashboardHostelList.length,
                itemBuilder: (context, index) {
                  return AttendanceHostellistContainer(
                    attendanceCourse: attendanceCourseListController.homeDashboardHostelList[index], hostellerObjectIdDetails: attendanceCourseListController.hostellerObjectIdDetails, hostelObjectIdDetails: attendanceCourseListController.hostelObjectIdDetails,
                  );
                },
              );
            }
          },
        ),
      ),
    ],
  ),
);

  }
}