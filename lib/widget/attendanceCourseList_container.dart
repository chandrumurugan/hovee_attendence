import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/modals/getAttendanceCourseList_model.dart';
import 'package:hovee_attendence/modals/getEnrollmentDataModel.dart';
import 'package:hovee_attendence/modals/getHomeDashboardModel.dart';
import 'package:hovee_attendence/view/hostel_punch_view.dart';
import 'package:hovee_attendence/view/punch_view.dart';
import 'package:intl/intl.dart';

class AttendancecourselistContainer extends StatelessWidget {
  final CourseList? attendanceCourse;

  const AttendancecourselistContainer(
      {super.key, required this.attendanceCourse, required});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${attendanceCourse!.batch!.batchName}",
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    attendanceCourse!.course!.courseCode ?? '',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  attendanceCourse!.course!.className != null
                      ? SizedBox(
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
                        )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${attendanceCourse!.batch!.batchTimingStart} - ${attendanceCourse!.batch!.batchTimingEnd}",
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  //SizedBox(height: 5,),
                  // Text(
                  //   "ID:${attendanceCourse!.course!.tutorWowId??''}",
                  //   style: GoogleFonts.nunito(
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.black),
                  // ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // final currentTime = DateTime.now();
                      // final startTime = DateTime.parse(
                      //     attendanceCourse!.batch!.batchTimingStart!);

                      // // Calculate the allowed start time (30 minutes before the batch start time)
                      // final allowedStartTime =
                      //     startTime.subtract(Duration(minutes: 30));

                      // if (currentTime.isBefore(allowedStartTime)) {
                      // Get.snackbar(
                      //     'Attendance can only be started 30 minutes before the start time.');
                      // } else if (currentTime.isAfter(startTime)) {
                      // Get.snackbar(
                      //     'The class has already started. Proceeding with late attendance.');

                      //   //Get.to(() =>QRScannerScreen(className: attendanceCourse.course!.className!, courseId:attendanceCourse.course!.sId!, batchId:attendanceCourse.batch!.sId!, batchStartTime: attendanceCourse.batch!.batchTimingStart!, batchEndTime: attendanceCourse.batch!.batchTimingEnd!, subjectName: attendanceCourse.course!.subject!, courseCode: attendanceCourse.course!.courseCode!,));
                      //   Get.to(() => PunchView(
                      //         className: attendanceCourse!.course!.className!,
                      //         courseId: attendanceCourse!.course!.sId!,
                      //         batchId: attendanceCourse!.batch!.sId!,
                      //         batchStartTime:
                      //             attendanceCourse!.batch!.batchTimingStart!,
                      //         batchEndTime:
                      //             attendanceCourse!.batch!.batchTimingEnd!,
                      //         subjectName: attendanceCourse!.course!.subject!,
                      //         courseCode: attendanceCourse!.course!.courseCode!,
                      //       ));
                      // }
                      final currentTime = DateTime.now();
                      final dateFormat = DateFormat(
                          "HH:mm"); // Change this to match your date format

                      // Parse batch timing start
                      DateTime? startTime;
                      try {
                        startTime = dateFormat
                            .parse(attendanceCourse!.batch!.batchTimingStart!);
                        startTime = DateTime(
                            currentTime.year,
                            currentTime.month,
                            currentTime.day,
                            startTime.hour,
                            startTime.minute);
                      } catch (e) {
                        Get.snackbar(
                          'Attendance can only be started 30 minutes before the start time.',
                          icon: const Icon(Icons.check_circle,
                              color: Colors.white, size: 40),
                          colorText: Colors.white,
                          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
                          shouldIconPulse: false,
                          messageText: const SizedBox(
                            height: 40, // Set desired height here
                            child: Center(
                              child: Text(
                                'Attendance can only be started 30 minutes before the start time.',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        );

                        // Get.snackbar(
                        //     'Attendance can only be started 30 minutes before the start time.',backgroundColor: AppConstants.secondaryColor,colorText: Colors.white);
                        return;
                      }

                      // Calculate allowed start time (30 minutes before batch start time)
                      final allowedStartTime =
                          startTime.subtract(Duration(minutes: 30));

                      if (currentTime.isBefore(allowedStartTime)) {
                        // Too early to start
                        Get.snackbar(
                          'Attendance can only be started 30 minutes before the start time.',
                          icon: const Icon(Icons.check_circle,
                              color: Colors.white, size: 40),
                          shouldIconPulse: false,
                          colorText: Colors.white,
                          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
                          messageText: const SizedBox(
                            height: 40, // Set desired height here
                            child: Center(
                              child: Text(
                                'Attendance can only be started 30 minutes before the start time.',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        );
                        // Get.snackbar(
                        //     'Attendance can only be started 30 minutes before the start time.',backgroundColor: AppConstants.primaryColor,colorText: Colors.white);
                      } else if (currentTime.isAfter(startTime)) {
                        // Late attendance
                        // Get.snackbar(
                        //     'The class has already started. Proceeding with late attendance.',backgroundColor: AppConstants.primaryColor,colorText: Colors.white);

                        // Navigate to PunchView
                        Get.to(
                            () => PunchView(
                                  className:
                                      attendanceCourse!.course!.className!,
                                  courseId: attendanceCourse!.course!.sId!,
                                  batchId: attendanceCourse!.batch!.sId!,
                                  batchStartTime: attendanceCourse!
                                      .batch!.batchTimingStart!,
                                  batchEndTime:
                                      attendanceCourse!.batch!.batchTimingEnd!,
                                  subjectName:
                                      attendanceCourse!.course!.subject!,
                                  courseCode:
                                      attendanceCourse!.course!.courseCode!,
                                  batchname:
                                      attendanceCourse!.batch!.batchName!,
                                  wowId: attendanceCourse!.course!.tutorWowId,
                                ),
                            arguments: attendanceCourse!.course!.tutorWowId);
                      } else {
                        // On time to start
                        Get.to(
                            () => PunchView(
                                  className:
                                      attendanceCourse!.course!.className!,
                                  courseId: attendanceCourse!.course!.sId!,
                                  batchId: attendanceCourse!.batch!.sId!,
                                  batchStartTime: attendanceCourse!
                                      .batch!.batchTimingStart!,
                                  batchEndTime:
                                      attendanceCourse!.batch!.batchTimingEnd!,
                                  subjectName:
                                      attendanceCourse!.course!.subject!,
                                  courseCode:
                                      attendanceCourse!.course!.courseCode!,
                                  wowId: attendanceCourse!.course!.tutorWowId,
                                ),
                            arguments: attendanceCourse!.course!.tutorWowId);
                      }
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

class AttendanceHostellistContainer extends StatelessWidget {
  final HostelList? attendanceCourse;
 final HostelObjectIdDetails? hostellerObjectIdDetails;
  final   HostelObjectIdDetails? hostelObjectIdDetails;
  const AttendanceHostellistContainer(
      {super.key, required this.attendanceCourse, required, required this.hostellerObjectIdDetails,required this.hostelObjectIdDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
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
                'assets/v2.jpg',
                width: 100,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${attendanceCourse!.hostelName}",
                    style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    attendanceCourse!.categories ?? '',
                    style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  attendanceCourse!.hostelType != null
                      ? SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "${attendanceCourse!.hostelType} - ${attendanceCourse!.food}",
                            maxLines: 2, // Restrict to one line
                            overflow: TextOverflow
                                .ellipsis, // Add ellipsis if the text overflows
                            style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${attendanceCourse!.hostelTimingStart} - ${attendanceCourse!.hostelTimingEnd}",
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
                      final currentTime = DateTime.now();
                      final dateFormat = DateFormat(
                          "HH:mm"); // Change this to match your date format

                      // Parse batch timing start
                      DateTime? startTime;
                      try {
                        startTime = dateFormat.parse(
                            attendanceCourse!.hostelTimingStart.toString());
                        startTime = DateTime(
                            currentTime.year,
                            currentTime.month,
                            currentTime.day,
                            startTime.hour,
                            startTime.minute);
                      } catch (e) {
                        Get.snackbar(
                          'Attendance can only be started 30 minutes before the start time.',
                          icon: const Icon(Icons.check_circle,
                              color: Colors.white, size: 40),
                          colorText: Colors.white,
                          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
                          shouldIconPulse: false,
                          messageText: const SizedBox(
                            height: 40, // Set desired height here
                            child: Center(
                              child: Text(
                                'Attendance can only be started 30 minutes before the start time.',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        );

                        // Get.snackbar(
                        //     'Attendance can only be started 30 minutes before the start time.',backgroundColor: AppConstants.secondaryColor,colorText: Colors.white);
                        return;
                      }

                      // Calculate allowed start time (30 minutes before batch start time)
                      final allowedStartTime =
                          startTime.subtract(Duration(minutes: 30));

                      if (currentTime.isBefore(allowedStartTime)) {
                        // Too early to start
                        Get.snackbar(
                          'Attendance can only be started 30 minutes before the start time.',
                          icon: const Icon(Icons.check_circle,
                              color: Colors.white, size: 40),
                          shouldIconPulse: false,
                          colorText: Colors.white,
                          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
                          messageText: const SizedBox(
                            height: 40, // Set desired height here
                            child: Center(
                              child: Text(
                                'Attendance can only be started 30 minutes before the start time.',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        );
                        // Get.snackbar(
                        //     'Attendance can only be started 30 minutes before the start time.',backgroundColor: AppConstants.primaryColor,colorText: Colors.white);
                      } else if (currentTime.isAfter(startTime)) {
                        // Late attendance
                        // Get.snackbar(
                        //     'The class has already started. Proceeding with late attendance.',backgroundColor: AppConstants.primaryColor,colorText: Colors.white);

                        // Navigate to PunchView
                        Get.to(
                          () => HostelPunchView(
                            hostelName: attendanceCourse!.hostelName ?? '',
                            hostelId: attendanceCourse!.id ?? '',
                            hostelObjId:  hostelObjectIdDetails!.id ?? '',
                            hostelStartTime:
                                attendanceCourse!.hostelTimingStart ?? '',
                            hostelEndTime:
                                attendanceCourse!.hostelTimingEnd ?? '',
                            wowId: hostelObjectIdDetails!.wowId ?? '',
                            hostelType: attendanceCourse!.hostelType ?? '',
                            room: attendanceCourse!.food ?? '',
                          ),
                        );
                      } else {
                        // On time to start
                        Get.to(
                          () => HostelPunchView(
                            hostelName: attendanceCourse!.hostelName ?? '',
                            hostelId: attendanceCourse!.id ?? '',
                            hostelObjId:  hostelObjectIdDetails!.id ?? '',
                            hostelStartTime:
                                attendanceCourse!.hostelTimingStart ?? '',
                            hostelEndTime:
                                attendanceCourse!.hostelTimingEnd ?? '',
                            wowId:hostellerObjectIdDetails!.wowId ?? '',
                            hostelType: attendanceCourse!.hostelType ?? '',
                            room: attendanceCourse!.food ?? '',
                          ),
                        );
                      }
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
