
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/attendance_controller.dart';
import 'package:hovee_attendence/controllers/hosteller_controller.dart';
import 'package:hovee_attendence/controllers/punch_controller.dart';
import 'package:hovee_attendence/controllers/tuteeHome_controllers.dart';
import 'package:hovee_attendence/view/attendanceCourseList_screen.dart';
import 'package:hovee_attendence/view/punch_view.dart';
import 'package:hovee_attendence/widget/attendanceCourseList_container.dart';
import 'package:logger/web.dart';

class SubjectContainer extends StatelessWidget {
   SubjectContainer({super.key});
  final AttendanceCourseListController attendanceCourseListController = Get.put(AttendanceCourseListController());
   final TuteeHomeController attendanceListController = Get.put(TuteeHomeController());
  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        height: 140,
        child: Obx(() {
          if (attendanceCourseListController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (attendanceListController.homeDashboardCourseList.isEmpty) {
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
            Logger().i("getting values for tyhe api");
            // Display the list of batches
            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: attendanceListController.homeDashboardCourseList.length,
              itemBuilder: (context, index) {
                print("gettiunhs calye123456==>${attendanceListController.homeDashboardCourseList.length}");
                final attendanceCourse = attendanceListController.homeDashboardCourseList[index];
                return SizedBox(
                  
                  width: MediaQuery.of(context).size.width,
                  child: AttendancecourselistContainer(attendanceCourse: attendanceCourse));
              },
            );
          }
        }),
      );
  }
}


class SubjectContainerHostel extends StatelessWidget {
   SubjectContainerHostel({super.key});
  final AttendanceCourseListController attendanceCourseListController = Get.put(AttendanceCourseListController());
   final HostellerController attendanceListController = Get.put(HostellerController());
  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        height: 140,
        child: Obx(() {
          if (attendanceCourseListController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (attendanceListController.homeDashboardHostelList.isEmpty) {
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
            Logger().i("getting values for tyhe api");
            // Display the list of batches
            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: attendanceListController.homeDashboardHostelList.length,
              itemBuilder: (context, index) {
                print("gettiunhs calye123456==>${attendanceListController.homeDashboardHostelList.length}");
                final attendanceCourse = attendanceListController.homeDashboardHostelList[index];
                return SizedBox(
                  
                  width: MediaQuery.of(context).size.width,
                  child: AttendanceHostellistContainer(attendanceCourse: attendanceCourse, hostellerObjectIdDetails: attendanceListController.hostellerObjectIdDetails, hostelObjectIdDetails: attendanceListController.hostelObjectIdDetails,));
              },
            );
          }
        }),
      );
  }
}