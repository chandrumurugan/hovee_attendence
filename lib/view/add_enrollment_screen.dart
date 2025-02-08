import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/enrollment_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/utils/inputTextField.dart';
import 'package:hovee_attendence/view/enrollment_screen.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';
import 'package:hovee_attendence/widgets/preview_header.dart';

class AddEnrollmentScreen extends StatelessWidget {
  final String tuteename,
      batchname,
      classname,
      subject,
      board,
      batchStartingTime,
      batchEndingTime,
      tutorname,
      courseCodeName,
      fees,
      tutorId,
      tuteeId,
      courseId,
      batchId,
      enrollmentType,
      type,
      batchEndDate,
      batchMode;
  AddEnrollmentScreen(
      {super.key,
      required this.tuteename,
      required this.batchname,
      required this.classname,
      required this.subject,
      required this.board,
      required this.batchStartingTime,
      required this.batchEndingTime,
      required this.tutorname,
      required this.courseCodeName,
      required this.fees,
      required this.tutorId,
      required this.tuteeId,
      required this.courseId,
      required this.batchId,
      required this.enrollmentType,
      required this.type,
      required this.batchEndDate,
      required this.batchMode});
  final EnrollmentController controller = Get.put(EnrollmentController());
  @override
  Widget build(BuildContext context) {
    controller.feesController.text = fees;
    controller.tuteeController.text = tuteename;
    controller.tutorController.text = tutorname;
    controller.boardController.text = board;
    controller.classController.text = classname;
    controller.subjectController.text = subject;
    controller.coureseCodeController.text = courseCodeName;
    controller.batchTimingController.text =
        '$batchStartingTime - $batchEndingTime';
    controller.branchController.text = batchname;
    controller.endDateController.text = batchEndDate;
    controller.modeController.text = batchMode;
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PreviewHeader(
              bgImage:
                  'assets/bgImage/teacherModel-removebg-preview-removebg-preview.jpg',
              title: subject,
              subtitle: tutorname,
              ratingCount: '4.8',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'Tutee name',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: InputTextField(
                  suffix: false,
                  readonly: true,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r"[a-zA-Z0-9@&_,-\/.']",
                      ),
                    ),
                  ],
                  hintText: 'Enter here...',
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.tuteeController),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Row(
                children: [
                  const Text(
                    'Start date',
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
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: InputTextField(
                suffix: true,
                readonly: false,
                isDate: true,
                hintText: 'Select',
                initialDate: DateTime.now(),
                firstDate:
                    DateTime.now(), // Sets the minimum selectable date to today
                lastDate:
                    DateTime(2100), // You can set this to a far future date
                keyboardType: TextInputType.datetime,
                controller: controller.startDateController,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'End date',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  // Text(
                  //   '*',
                  //   style: GoogleFonts.nunito(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w600,
                  //     color: Colors.red.withOpacity(0.6),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: InputTextField(
                  suffix: false,
                  readonly: true,
                  isDate: true,
                  hintText: 'Select',
                  initialDate: DateTime.now(),
                  firstDate: DateTime
                      .now(), // Sets the minimum selectable date to today
                  lastDate: DateTime(2100),
                  keyboardType: TextInputType.datetime,
                  controller: controller.endDateController),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'Batch name',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  // Text(
                  //   '*',
                  //   style: GoogleFonts.nunito(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w600,
                  //     color: Colors.red.withOpacity(0.6),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: InputTextField(
                  suffix: false,
                  readonly: true,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r"[a-zA-Z0-9@&_,-\/.']",
                      ),
                    ),
                  ],
                  hintText: 'Enter here...',
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.branchController),
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'Board',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  // Text(
                  //   '*',
                  //   style: GoogleFonts.nunito(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w600,
                  //     color: Colors.red.withOpacity(0.6),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: InputTextField(
                  suffix: false,
                  readonly: true,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r"[a-zA-Z0-9@&_,-\/.']",
                      ),
                    ),
                  ],
                  hintText: 'Enter here...',
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.boardController),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'Class',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  // Text(
                  //   '*',
                  //   style: GoogleFonts.nunito(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w600,
                  //     color: Colors.red.withOpacity(0.6),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: InputTextField(
                  suffix: false,
                  readonly: true,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r"[a-zA-Z0-9@&_,-\/.']",
                      ),
                    ),
                  ],
                  hintText: 'Enter here...',
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.classController),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'Subject',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  // Text(
                  //   '*',
                  //   style: GoogleFonts.nunito(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w600,
                  //     color: Colors.red.withOpacity(0.6),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: InputTextField(
                  suffix: false,
                  readonly: true,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r"[a-zA-Z0-9@&_,-\/.']",
                      ),
                    ),
                  ],
                  hintText: 'Enter here...',
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.subjectController),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'Tutor',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  // Text(
                  //   '*',
                  //   style: GoogleFonts.nunito(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w600,
                  //     color: Colors.red.withOpacity(0.6),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: InputTextField(
                  suffix: false,
                  readonly: true,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r"[a-zA-Z0-9@&_,-\/.']",
                      ),
                    ),
                  ],
                  hintText: 'Enter here...',
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.tutorController),
            ),
            const SizedBox(
              height: 5,
            ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
            //   child: Row(
            //     children: [
            //       const Text(
            //         'Class course code',
            //         style: TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w500,
            //           color: Colors.black,
            //         ),
            //       ),
            //       Text(
            //         '*',
            //         style: GoogleFonts.nunito(
            //           fontSize: 18,
            //           fontWeight: FontWeight.w600,
            //           color: Colors.red.withOpacity(0.6),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 5,
            // ),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            //   child: InputTextField(
            //       suffix: false,
            //       readonly: true,
            //       inputFormatter: [
            //         FilteringTextInputFormatter.allow(
            //           RegExp(
            //             r"[a-zA-Z0-9@&_,-\/.']",
            //           ),
            //         ),
            //       ],
            //       hintText: 'Enter here...',
            //       keyboardType: TextInputType.emailAddress,
            //       controller: controller.coureseCodeController),
            // ),
            // const SizedBox(
            //   height: 5,
            // ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'Batch timings',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  // Text(
                  //   '*',
                  //   style: GoogleFonts.nunito(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w600,
                  //     color: Colors.red.withOpacity(0.6),
                  //   ),
                  // ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: InputTextField(
                  suffix: false,
                  readonly: true,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r"[a-zA-Z0-9@&_,-\/.']",
                      ),
                    ),
                  ],
                  hintText: 'Enter here...',
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.batchTimingController),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'Fees',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: InputTextField(
                  suffix: false,
                  readonly: true,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r"[a-zA-Z0-9@&_,-\/.']",
                      ),
                    ),
                  ],
                  hintText: 'Enter here...',
                  keyboardType: TextInputType.emailAddress,
                  prefixText: '₹ ', // Add the rupee symbol as prefix
                  suffixText: '/month',
                  controller: controller.feesController),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: Row(
                children: [
                  Text(
                    'Batch mode',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: InputTextField(
                  suffix: false,
                  readonly: true,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r"[a-zA-Z0-9@&_,-\/.']",
                      ),
                    ),
                  ],
                  hintText: 'Enter here...',
                  keyboardType: TextInputType.emailAddress,
                  prefixText: '', // Add the rupee symbol as prefix
                  suffixText: '',
                  controller: controller.modeController),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SingleCustomButtom(
        btnName: 'Submit',
        isPadded: false,
        onTap: () {
          if (controller.validateFields(context)) {
            _showConfirmationDialog(context, tutorId, tuteeId, courseId,
                batchId, tuteename, type, batchname, subject, tutorname);
          }
          // controller.addEnrollment(
          //     context, tutorId, tuteeId, courseId, batchId, tuteename, type);
        },
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String tutorId, tuteeId,
      courseId, batchId, tuteename, type, batch, subject, tutorname) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          title1: 'Do you want to submit the enrollment?',
          title2: '',
          subtitle: 'Do you want to live this class?',
          icon: const Icon(
            Icons.help_outline,
            color: Colors.white,
          ),
          color: const Color(0xFF833AB4), // Set the primary color
          color1: const Color(0xFF833AB4), // Optional gradient color
          singleBtn: false, // Show both 'Yes' and 'No' buttons
          btnName: 'No',
          onTap: () {
            // Call the updateClass method when 'Yes' is clicked
            // Close the dialog after update
            Navigator.of(context).pop();
          },
          btnName2: 'Yes',
          onTap2: () async {
            // Close the dialog when 'No' is clicked
             Get.back();
                  final response = await controller.addEnrollment(context, tutorId, tuteeId, courseId,
                batchId, tuteename, type, batch, subject, tutorname);
             if(response){
            showConfirmationDialog1(Get.context!, batch, subject, tuteename, type);
             }
          },
        );
      },
    );
  }

  void showConfirmationDialog1(
      BuildContext context, String batch, subject, tutorname, type) {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CustomDialogBox1(
          title1: "Enrollment Initiated! for $batch($subject)",
          title2: '',
          subtitle:
              'Note: You’ve successfully initiated the enrollment for $tuteename',
          btnName: 'Ok',
          onTap: () async {
            Get.delete<EnrollmentController>();
            Get.off(() => EnrollmentScreen(
                  type: type,
                ));
          },
          icon: const Icon(
            Icons.check,
            color: Colors.white,
          ),
          color: const Color(0xFF833AB4),
          singleBtn: true,
        );
      },
    );
  }
}
