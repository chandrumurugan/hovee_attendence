import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/enrollment_controller.dart';
import 'package:hovee_attendence/controllers/tuteeHome_controllers.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/addUserRatings.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/view/enrollment_preview_screen.dart';
import 'package:pinput/pinput.dart';

class EnrollmentScreen extends StatelessWidget {
  final String type;
  final bool fromBottomNav;
  final String? firstname, lastname, wowid, lastWord;
  final VoidCallback? onDashBoardBack;
  final EnrollmentController controller;
  EnrollmentScreen({
    super.key,
    required this.type,
    this.fromBottomNav = true,
    this.firstname,
    this.lastname,
    this.wowid,
    this.onDashBoardBack,
    this.lastWord,
  }) : controller = Get.put(EnrollmentController(), permanent: true);
  //final EnrollmentController controller = Get.put(EnrollmentController());
  //final NotificationController notificontroller = Get.put(NotificationController());
  final TuteeHomeController attendanceCourseListController =
      Get.put(TuteeHomeController());
  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final savedOtp = storage.read('otpCode') ?? '';
    attendanceCourseListController.otpController.text = savedOtp;
    controller.onInit();
    return Scaffold(
        appBar: AppBarHeader(
            needGoBack: fromBottomNav,
            navigateTo: () {
              if (fromBottomNav && onDashBoardBack != null) {
                // Call onDashBoardBack if navigating from bottom navigation
                onDashBoardBack!();
              } else {
                // Navigate to Dashboard if not from bottom navigation
                Get.offAll(DashboardScreen(
                  rolename: type,
                  firstname: firstname,
                  lastname: lastname,
                  wowid: wowid,
                ));
              }
            }),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Text(
                'Enrollment list',
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            // Tabs for Active and Inactive
            // TabBar(
            //   controller: controller.tabController,
            //   tabs: const [
            //     Tab(text: 'Pending'),
            //     Tab(text: 'Accepted'),
            //     Tab(text: 'Rejected'),
            //   ],
            //   onTap: (value) {
            //     controller.handleTabChange(value);
            //   },
            // ),
            GetBuilder<EnrollmentController>(
              init: EnrollmentController(),
              builder: (controller) {
                return TabBar(
                  controller: controller.tabController,
                  tabs: const [
                    Tab(text: 'Pending'),
                    Tab(text: 'Accepted'),
                    Tab(text: 'Rejected'),
                  ],
                  onTap: (value) {
                    controller.handleTabChange(value);
                  },
                );
              },
            ),
            // Display List based on the selected tab
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.enrollmentList.isEmpty) {
                  // Display "No data found" when the list is empty
                  return Center(
                    child: Text(
                      'No data found',
                      style: GoogleFonts.nunito(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: controller.enrollmentList.length,
                    itemBuilder: (context, index) {
                      final enrollmentList = controller.enrollmentList[index];
                      return Animate(
                        effects: [
                          SlideEffect(
                            begin: Offset(-1, 0), // Start from the left
                            end: Offset(0, 0), // End at the original position
                            curve: Curves.easeInOut,
                            duration: 500.ms, // Consistent timing for each item
                            delay: 100.ms * index, // Add delay between items
                          ),
                          FadeEffect(
                            begin: 0, // Start transparent
                            end: 1, // End opaque
                            duration: 500.ms,
                            delay: 100.ms * index,
                          ),
                        ],
                        child: GestureDetector(
                          onTap: () {
                            Get.to(EnRollmentPreviewScreen(
                              data: enrollmentList,
                              type: 'Enquire',
                              role: type,
                              onPreviewCallbackAccept: () {
                                _showOtpDialog(
                                    context,
                                    enrollmentList.sId!,
                                    enrollmentList.batchId!.batchName!,
                                    enrollmentList.courseId.subject,
                                    enrollmentList.tutorId.firstName);
                              },
                              onPreviewCallbackReject: () {
                                controller.updateEnrollment(enrollmentList.sId!,
                                    'Rejected', enrollmentList.enquiryCode!);
                              },
                            ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            child: Card(
                              elevation: 10,
                              shadowColor: Colors.black,
                              surfaceTintColor: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Colors.grey,
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              _buildRow(
                                                'Tutee name',
                                                '${enrollmentList.studentId.firstName} ${enrollmentList.studentId.lastName}',
                                              ),
                                              _buildRow(
                                                  'Class',
                                                  enrollmentList
                                                      .courseId.className),
                                              _buildRow(
                                                  'Board',
                                                  enrollmentList
                                                      .courseId.board),
                                              _buildRow(
                                                  'Subject',
                                                  enrollmentList
                                                      .courseId.subject),
                                              _buildRow(
                                                'Tutor',
                                                '${enrollmentList.tutorId.firstName} ${enrollmentList.tutorId.lastName}',
                                              ),
                                              _buildRow(
                                                  'Status',
                                                  enrollmentList.status ==
                                                          'Approved'
                                                      ? 'Accepted'
                                                      : enrollmentList.status),
                                              _buildRow(
                                                  'Start date',
                                                  enrollmentList
                                                          .batchId.startDate ??
                                                      ''),
                                              _buildRow(
                                                  'End date',
                                                  enrollmentList
                                                          .batchId.endDate ??
                                                      ''),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    // Display "Accept" and "Reject" buttons outide the column
                                    if ((controller.selectedTabIndex.value ==
                                                0 &&
                                            type == 'Tutee') ||
                                        (controller.selectedTabIndex.value ==
                                                1 &&
                                            type == 'Tutee'))
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          if (controller
                                                      .selectedTabIndex.value ==
                                                  0 &&
                                              type == 'Tutee') ...[
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  _showOtpDialog(
                                                      context,
                                                      enrollmentList.sId!,
                                                      enrollmentList
                                                          .batchId!.batchName!,
                                                      enrollmentList
                                                          .courseId.subject,
                                                      enrollmentList.tutorId
                                                          .firstName); //enrollmentList.id!
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    gradient: LinearGradient(
                                                      colors: const [
                                                        Color(0xFFBA0161),
                                                        Color(0xFF510270)
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Submit",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  controller.updateEnrollment(
                                                      enrollmentList.sId!,
                                                      'Rejected',
                                                      enrollmentList
                                                          .enquiryCode!);
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    gradient: LinearGradient(
                                                      colors: const [
                                                        Color(0xFFBA0161),
                                                        Color(0xFF510270)
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Reject",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ] else if (controller
                                                      .selectedTabIndex.value ==
                                                  1 &&
                                              type == 'Tutee') ...[
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  String address =
                                                      '${enrollmentList.tutorId.doorNo}, ${enrollmentList.tutorId.street}, ${enrollmentList.tutorId.city}, ${enrollmentList.tutorId.state}, ${enrollmentList.tutorId.country}';
                                                  Get.to(AddUserRatingsScreen(
                                                    firstName: enrollmentList
                                                        .tutorId.firstName,
                                                    lastName: enrollmentList
                                                        .tutorId.lastName,
                                                    address: address,
                                                    email: enrollmentList
                                                        .tutorId.email,
                                                    phNo: enrollmentList
                                                        .tutorId.phoneNumber,
                                                    tutorId: enrollmentList
                                                        .tutorId.sId,
                                                    batchId: enrollmentList
                                                        .batchId.sId,
                                                    courseId: enrollmentList
                                                        .courseId.sId,
                                                    classname: enrollmentList
                                                        .courseId.className,
                                                    board: enrollmentList
                                                        .courseId.board,
                                                    subject: enrollmentList
                                                        .courseId.subject,
                                                    courtsecode: enrollmentList
                                                        .courseId.courseCode,
                                                  ));
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color(0xFFBA0161),
                                                        Color(0xFF510270)
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  ),
                                                  child: Text(
                                                      "Share your ratings",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.nunito(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 20,
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ));
  }

  void _showOtpDialog(
      BuildContext context, String enrollmentId, batch, subject, tutorname) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 38,
      textStyle: const TextStyle(
        fontSize: 22,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border(right: BorderSide(color: Colors.grey.shade400)),
      ),
    );

    Get.dialog(
      AlertDialog(
        contentPadding: const EdgeInsets.only(top: 10, left: 16, right: 16),
        content: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      'Acceptance code',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please enter the acceptance code to confirm your enrollment.',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        length: 6,
                        controller:
                            attendanceCourseListController.otpController,
                        focusNode: attendanceCourseListController.focusNode,
                        defaultPinTheme: defaultPinTheme,
                        separatorBuilder: (index) => const SizedBox(width: 8),
                        onCompleted: (pin) {
                          debugPrint('onCompleted: $pin');
                        },
                        onChanged: (value) {
                          debugPrint('onChanged: $value');
                        },
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 0),
                              width: 22,
                              height: 1,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.grey.shade300,
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                final otp = attendanceCourseListController.otpController.text;
                if (otp.isNotEmpty) {
                  Get.back();
                  final response = await controller.updateEnrollment(
                      enrollmentId, 'Approved', otp);
                  if (response) {
                    showConfirmationDialog1(batch, subject, tutorname);
                  }
                } else {
                  SnackBarUtils.showSuccessSnackBar(
                    context,
                    'Please enter OTP',
                  );
                }
              },
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: const [Color(0xFFBA0161), Color(0xFF510270)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String title, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        Text(
          value ?? '',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
        ),
      ],
    );
  }

  void showConfirmationDialog1(String batch, String subject, String tutorname) {
    Get.dialog(
      CustomDialogBox1(
        title1: 'Enrollment Accepted! for $batch($subject)',
        title2: '',
        subtitle:
            'Note: You have successfully the accept the $tutorname request',
        icon: const Icon(
          Icons.help_outline,
          color: Colors.white,
        ),
        color: const Color(0xFF833AB4), // Set the primary color
        color1: const Color(0xFF833AB4), // Optional gradient color
        singleBtn: true, // Show only one button
        btnName: 'OK', // Set the button name
        onTap: () {
          // Call API to add enrollment
          controller.otpController.clear(); // Clear the OTP field
                  GetStorage().remove('otpCode');
                  Get.offAll(DashboardScreen(
                    rolename: type,
                    firstname: firstname,
                    lastname: lastname,
                    wowid: wowid,
                  ));
        },
      ),
      barrierDismissible: false, // Prevent dismissing by tapping outside
    );
  }
}
