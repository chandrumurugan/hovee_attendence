
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/attendance_controller.dart';
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
    //  Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
    //   child: Card(
    //     elevation: 10,
    //     shadowColor: Colors.grey,
    //     surfaceTintColor: Colors.white,
    //     child: Container(
    //       padding: const EdgeInsets.all(5),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(12),
    //       ),
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Image.asset(
    //             'assets/tuteeHomeImg/image 193.png',
    //           ),
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 'Mathematics',
    //                 style: GoogleFonts.nunito(
    //                     fontSize: 14,
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.black),
    //               ),
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               Text(
    //                 '12th std',
    //                 style: GoogleFonts.nunito(
    //                     fontSize: 14,
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.black),
    //               ),
    //               SizedBox(
    //                 height: 10,
    //               ),
    //               Text(
    //                 'CBSE',
    //                 style: GoogleFonts.nunito(
    //                     fontSize: 14,
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.black),
    //               ),
    //             ],
    //           ),
    //           Column(
    //             children: [
    //               InkWell(
    //                 onTap: () {
    //                  Get.to(() =>
    //                             PunchView(className: '12th std',)); 
    //                 },
    //                 child: const CircleAvatar(
    //                   radius: 25,
    //                   backgroundColor: AppConstants.primaryColor,
    //                   child: Text(
    //                     'Punch',
    //                     style: TextStyle(fontSize: 11, color: Colors.white),
    //                   ),
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 15,
    //               ),
    //               Row(
    //                 children: [
    //                  CircleAvatar(radius: 3,backgroundColor: Colors.green,),
    //                  SizedBox(width: 2,),
    //                   Text(
    //                     'LIVE',
    //                     style: GoogleFonts.nunito(
    //                         fontSize: 14,
    //                         fontWeight: FontWeight.bold,
    //                         color: Colors.green),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );

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