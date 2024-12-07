import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/modals/getAttendanceCourseList_model.dart';
import 'package:hovee_attendence/modals/getHomeDashboardModel.dart';
import 'package:hovee_attendence/view/punch_view.dart';

class AttendancecourselistContainer extends StatelessWidget {
  final CourseList? attendanceCourse;

  AttendancecourselistContainer(
      {super.key, required this.attendanceCourse, required});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
      child: Card(
        elevation: 10,
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/tuteeHomeImg/image 193.png',
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    attendanceCourse!.course!.courseCode??'',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  attendanceCourse!.course!.className!=null?
                  SizedBox(
                       width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      "${attendanceCourse!.course!.className!} - ${attendanceCourse!.course!.subject!}",
                      maxLines: 2, // Restrict to one line
                      overflow: TextOverflow
                          .ellipsis, // Add ellipsis if the text overflows
                      style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ):SizedBox.shrink(),
                  Text(
                    "${attendanceCourse!.batch!.batchTimingStart} - ${attendanceCourse!.batch!.batchTimingEnd}",
                    
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      //Get.to(() =>QRScannerScreen(className: attendanceCourse.course!.className!, courseId:attendanceCourse.course!.sId!, batchId:attendanceCourse.batch!.sId!, batchStartTime: attendanceCourse.batch!.batchTimingStart!, batchEndTime: attendanceCourse.batch!.batchTimingEnd!, subjectName: attendanceCourse.course!.subject!, courseCode: attendanceCourse.course!.courseCode!,));
                      Get.to(() => PunchView(
                            className: attendanceCourse!.course!.className!,
                            courseId: attendanceCourse!.course!.sId!,
                            batchId: attendanceCourse!.batch!.sId!,
                            batchStartTime:
                                attendanceCourse!.batch!.batchTimingStart!,
                            batchEndTime:
                                attendanceCourse!.batch!.batchTimingEnd!,
                            subjectName: attendanceCourse!.course!.subject!,
                            courseCode: attendanceCourse!.course!.courseCode!,
                          ));
                    },
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundColor: AppConstants.primaryColor,
                      child: Text(
                        'Start',
                        style: TextStyle(fontSize: 11, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: Colors.green,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        'LIVE',
                        style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
