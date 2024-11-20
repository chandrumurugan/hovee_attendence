import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/courseDetails_controller.dart';
import 'package:hovee_attendence/modals/getClassTuteeById_model.dart';
import 'package:hovee_attendence/modals/getEnrollment_model.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/widgets/preview_header.dart';

class EnRollmentPreviewScreen extends StatelessWidget {
  final Data? data;
  final String type;
  EnRollmentPreviewScreen({super.key, this.data, required this.type});
  final CourseDetailController controller = Get.put(CourseDetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PreviewHeader(
              bgImage:
                  'assets/bgImage/teacherModel-removebg-preview-removebg-preview.jpg',
              title: data!.courseId!.subject!,
              subtitle: data!.tutorName ?? '',
              ratingCount: '4.8',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Preview Details',
                style: GoogleFonts.nunito(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(color: Colors.grey.shade300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Student name",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    Text(
                      '${data!.studentId!.firstName} ${data!.studentId!.lastName}',
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Start Date",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    Text(
                      data!.startDate ?? '',
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(color: Colors.grey.shade300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "End Date",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    Text(
                      data!.endDate ?? '',
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tutor name",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    Text(
                      '${data!.tutorId!.firstName} ${data!.tutorId!.lastName}',
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(color: Colors.grey.shade300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Batch name",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    Text(
                      data!.batchId!.batchName!,
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Board",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    Text(
                      data!.courseId!.board!,
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(color: Colors.grey.shade300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Class",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    Text(
                      data!.courseId!.className!,
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Batch timing",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    Text(
                      '${data!.batchId!.batchTimingStart} -  ${data!.batchId!.batchTimingEnd}',
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(color: Colors.grey.shade300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹ Fees",
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "${data!.batchId!.fees!} /month",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            // Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 14.0),
            //           child: Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 10, vertical: 20),
            //             decoration: BoxDecoration(
            //                 color:

            //                      Colors.grey.shade300),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text(
            //                   "School/Institute Name:",
            //                   style: GoogleFonts.nunito(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.w400,
            //                       fontSize: 16),
            //                 ),
            //                 Text(
            //                 controller.organizationName!,
            //                   style: GoogleFonts.nunito(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.w400,
            //                       fontSize: 14),
            //                 )
            //               ],
            //             ),
            //           ),
            //         )
            // ,
            // Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 14.0),
            //           child: Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 10, vertical: 20),
            //             decoration: BoxDecoration(
            //                 color:

            //                      Colors.white),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text(
            //                   "Board",
            //                   style: GoogleFonts.nunito(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.w400,
            //                       fontSize: 16),
            //                 ),
            //                 Text(
            //                   data!.board!,
            //                   style: GoogleFonts.nunito(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.w400,
            //                       fontSize: 16),
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //  Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Text(
            //       'Location',
            //       style: GoogleFonts.nunito(
            //         fontSize: 18,
            //         fontWeight: FontWeight.w500,
            //         color: Colors.grey,
            //       ),
            //     ),
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       children: [
            //         Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //             child: Container(
            //               height: 44,
            //               width: 47,
            //               decoration: BoxDecoration(
            //                   color: Color(0xffD9D9D9).withOpacity(0.4),
            //                   borderRadius: BorderRadius.circular(8)),
            //                   child: Icon(Icons.location_on,size: 40,color: Colors.red,),
            //             ),
            //           ),
            //         const SizedBox(
            //           width: 10,
            //         ),
            //         Expanded(
            //           child: Text(
            //            controller!.storedAddress!,
            //             style: GoogleFonts.nunito(
            //               fontSize: 14,
            //               fontWeight: FontWeight.w500,
            //               color: Colors.black,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            //          SizedBox(height: 10,),
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //     child: Text(
            //       'Tution Details',
            //       style: GoogleFonts.nunito(
            //           color: Colors.grey,
            //           fontWeight: FontWeight.w400,
            //           fontSize: 18),
            //     ),
            //   ),
            //   SizedBox(height: 8,),
            //   Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 14.0),
            //           child: Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 10, vertical: 20),
            //             decoration: BoxDecoration(
            //                 color:

            //                      Colors.grey.shade300),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text(
            //                   "Subject",
            //                   style: GoogleFonts.nunito(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.w400,
            //                       fontSize: 16),
            //                 ),
            //                 Text(
            //                  data.subject?? '',
            //                   style: GoogleFonts.nunito(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.w400,
            //                       fontSize: 16),
            //                 )
            //               ],
            //             ),
            //           ),
            //         )
            // ,
            // Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 14.0),
            //           child: Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 10, vertical: 20),
            //             decoration: BoxDecoration(
            //                 color:

            //                      Colors.white),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text(
            //                   "Class",
            //                   style: GoogleFonts.nunito(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.w400,
            //                       fontSize: 16),
            //                 ),
            //                 Text(
            //                   data.className!??'',
            //                   style: GoogleFonts.nunito(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.w400,
            //                       fontSize: 16),
            //                 )
            //               ],
            //             ),
            //           ),
            //         )
            // ,
            // Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 14.0),
            //           child: Container(
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: 10, vertical: 20),
            //             decoration: BoxDecoration(
            //                 color:

            //                      Colors.grey.shade300),
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Text(
            //                   "Board",
            //                   style: GoogleFonts.nunito(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.w400,
            //                       fontSize: 16),
            //                 ),
            //                 Text(
            //                data.board!??'',
            //                   style: GoogleFonts.nunito(
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.w400,
            //                       fontSize: 16),
            //                 )
            //               ],
            //             ),
            //           ),
            // ),
            // Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Text(
            //       'Location',
            //       style: GoogleFonts.nunito(
            //         fontSize: 18,
            //         fontWeight: FontWeight.w500,
            //         color: Colors.grey,
            //       ),
            //     ),
            //   ),
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Row(
            //       children: [
            //         Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 12.0),
            //             child: Container(
            //               height: 44,
            //               width: 47,
            //               decoration: BoxDecoration(
            //                   color: Color(0xffD9D9D9).withOpacity(0.4),
            //                   borderRadius: BorderRadius.circular(8)),
            //                   child: Icon(Icons.location_on,size: 40,color: Colors.red,),
            //             ),
            //           ),
            //         const SizedBox(
            //           width: 10,
            //         ),
            //         Expanded(
            //           child: Text(
            //            data.adddress??'',
            //             style: GoogleFonts.nunito(
            //               fontSize: 14,
            //               fontWeight: FontWeight.w500,
            //               color: Colors.black,
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
