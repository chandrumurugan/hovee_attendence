import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/controllers/class_controller.dart';
import 'package:hovee_attendence/controllers/course_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDropDownInputField.dart';
import 'package:hovee_attendence/widget/addteacher_inputfiled.dart';
import 'package:hovee_attendence/widget/input_form_filed.dart';
import 'package:hovee_attendence/widget/single_button.dart';
import 'package:hovee_attendence/widget/view_textfiled.dart';

class TutorClassForm extends StatefulWidget {
  const TutorClassForm({super.key});

  @override
  State<TutorClassForm> createState() => _TutorClassFormState();
}

class _TutorClassFormState extends State<TutorClassForm> {
  final ClassController controller = Get.put(ClassController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            controller.onInit();
            Navigator.pop(context);
          }),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.12,
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Image.asset('assets/bgImage/peopleTop.png'),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text(
                'Add Class',
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Choose course code',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '*',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  CommonDropdownInputField(
                    title: 'course code',
                    controllerValue: controller.courseCodeController,
                    selectedValue: controller.courseCodeController,
                    items: controller.courseCode,
                    onChanged: controller.onSelectCourseCode,
                  ),
                ],
              ),
            ),
            //           Obx(() {
            //   // Listen to changes in courseDetails
            //   final courseDetail = courseController.selectedCourseDetails.value;

            //   // Display loading indicator if course details are not yet fetched
            //   if (courseDetail == null || courseDetail.sId == null) {
            //     return Center(child: Container());
            //   }

            //   // Display course details
            //   return Padding(
            //       padding:
            //                 const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //            Row(
            //                     children: [
            //                       const Text(
            //                         'Course details',
            //                         style: TextStyle(
            //                           fontSize: 14,
            //                           fontWeight: FontWeight.w500,
            //                           color: Colors.black,
            //                         ),
            //                       ),

            //                     ],
            //                   ),
                    // Card(
                    //     elevation: 10,
                    //   shadowColor: Colors.black,
                    //   surfaceTintColor: Colors.white,
                    //   child: Container(
                    //      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    //       decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(8),
                    //       ),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text('Batch Name: ${courseDetail.batchName ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                    //         Text('Categories: ${courseDetail.categories ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                    //         Text('Board: ${courseDetail.board ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                    //         Text('Class Name: ${courseDetail.className ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                    //         Text('Subject: ${courseDetail.batchId ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                    //         // Add more fields as necessary
                    //       ],
                    //     ),
                    //   ),
                    // ),
            //       ],
            //     ),
            //   );
            // }),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Choose batch name',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '*',
                        style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
        return CommonInputField(
          controllerValue: controller.batchNameController.value.obs,  // Use the value of batchNameController
          selectedValue: controller.batchNameController.value.obs,    // Bind the TextField value to batchNameController
          keyboardType: TextInputType.text,
          hintText: 'Batch Name',  // Optional hint text
          onTap: () {},  // Action on tap, if needed
          controller: controller.batchNameController1,  // Additional controller if needed
        );
      }),
                ],
              ),
            ),
            //            Obx(() {
            //   // Listen to changes in courseDetails
            //   final courseDetail = controller1.selectedCourseDetails.value;

            //   // Display loading indicator if course details are not yet fetched
            //   if (courseDetail == null || courseDetail.sId == null) {
            //     return Center(child: Container());
            //   }

            //   // Display course details
            //   return Padding(
            //       padding:
            //                 const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //            Row(
            //                     children: [
            //                       const Text(
            //                         'Batch details',
            //                         style: TextStyle(
            //                           fontSize: 14,
            //                           fontWeight: FontWeight.w500,
            //                           color: Colors.black,
            //                         ),
            //                       ),

            //                     ],
            //                   ),
            //         Card(
            //             elevation: 10,
            //           shadowColor: Colors.black,
            //           surfaceTintColor: Colors.white,
            //           child: Container(
            //              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //               decoration: BoxDecoration(
            //                 color: Colors.white,
            //                 borderRadius: BorderRadius.circular(8),
            //               ),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text('Batch Name: ${courseDetail.batchName ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            //                 Text('BatchDays: ${courseDetail.batchDays ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            //                 Text('BatchMode: ${courseDetail.batchMode ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            //                 Text('BatchTimingStart: ${courseDetail.batchTimingStart ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            //                 Text('BatchTimingEnd: ${courseDetail.batchTimingEnd ?? 'N/A'}', style: TextStyle(fontSize: 18)),
            //                 // Add more fields as necessary
            //               ],
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   );
            // }),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            //   child: Text(
            //     'Location',
            //     style: GoogleFonts.nunito(
            //       fontSize: 18,
            //       fontWeight: FontWeight.w500,
            //       color: Colors.grey,
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            //   child: Row(
            //     children: [
            //       // Image.asset(
            //       //   'assets/location.jpeg',
            //       //   height: 40,
            //       // ),
            //       const SizedBox(
            //         width: 20,
            //       ),
            //       Expanded(
            //         child: Text(
            //           controller.fullAddress.value,
            //           style: GoogleFonts.nunito(
            //             fontSize: 14,
            //             fontWeight: FontWeight.w500,
            //             color: Colors.black,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SingleButton(
              btnName: 'Add',
              onTap: () {
                controller.addClass(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
