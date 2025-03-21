import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/enquir_controller.dart';
import 'package:hovee_attendence/services/modalServices.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/Tutee/preview_screen.dart';
import 'package:hovee_attendence/view/add_enrollment_screen.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/view/enrollment_preview_screen.dart';
import 'package:hovee_attendence/widget/single_button.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';
import 'package:intl/intl.dart';

class Tutorenquirlist extends StatelessWidget {
  final String type;
  final bool fromBottomNav;
  final String? firstname, lastname, wowid, lastWord;
  final VoidCallback? onDashBoardBack;
  final EnquirDetailController classController;
  Tutorenquirlist(
      {super.key,
      required this.type,
      this.fromBottomNav = true,
      this.firstname,
      this.lastname,
      this.wowid,
      this.onDashBoardBack,
      this.lastWord})
      : classController = Get.put(EnquirDetailController(), permanent: true);

  // final EnquirDetailController classController =
  //     Get.put(EnquirDetailController());
  @override
  Widget build(BuildContext context) {
    classController.onInit();
    return WillPopScope(
      onWillPop: () async {
        return await ModalService.handleBackButtonN(context);
      },
      child: Scaffold(
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
                  'Enquiry list',
                  style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              GetBuilder<EnquirDetailController>(
                init: EnquirDetailController(),
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

              //Display List based on the selected tab
              Expanded(
                child: Obx(() {
                  if (classController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (classController.enquirList.isEmpty) {
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
                      itemCount: classController.enquirList.length,
                      itemBuilder: (context, index) {
                        final tutionCourseDetailsList =
                            classController.enquirList[index];
                        return Animate(
                          effects: [
                            SlideEffect(
                              begin: Offset(-1, 0), // Start from the left
                              end: Offset(0, 0), // End at the original position
                              curve: Curves.easeInOut,
                              duration:
                                  500.ms, // Consistent timing for each item
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
                              final storage = GetStorage();
                              String email = storage.read('email');
                              String phnno = storage.read('phoneNumber');
                              Get.to(PreviewScreen(
                                data: tutionCourseDetailsList,
                                type: 'Enquire',
                                tutorname:
                                    tutionCourseDetailsList.tutorName ?? '',
                                type1: type,
                                tuteename:
                                    tutionCourseDetailsList.studentName ?? '',
                                tuteeemail: '',
                                tuteephn: '',
                                onPreviewCallbackAccept: () {
                                  _showConfirmationDialog(
                                      context, tutionCourseDetailsList);
                                },
                                onPreviewCallbackReject: () {
                                  _showConfirmationDialog1(
                                      context, tutionCourseDetailsList);
                                },
                                onPreviewCallbackEnroll: () {
                                  Get.to(() => AddEnrollmentScreen(
                                        tuteename: tutionCourseDetailsList
                                                .studentName ??
                                            '',
                                        batchname: tutionCourseDetailsList
                                                .courseName ??
                                            '',
                                        classname:
                                            tutionCourseDetailsList.className ??
                                                '',
                                        subject:
                                            tutionCourseDetailsList.subject ??
                                                '',
                                        board:
                                            tutionCourseDetailsList.board ?? '',
                                        batchStartingTime:
                                            tutionCourseDetailsList
                                                    .batchTimingStart ??
                                                '',
                                        batchEndingTime: tutionCourseDetailsList
                                                .batchTimingEnd ??
                                            '',
                                        tutorname:
                                            tutionCourseDetailsList.tutorName ??
                                                '',
                                        courseCodeName: tutionCourseDetailsList
                                                .courseCode ??
                                            '',
                                        fees:
                                            tutionCourseDetailsList.fees ?? '',
                                        tutorId:
                                            tutionCourseDetailsList.tutorId ??
                                                '',
                                        tuteeId:
                                            tutionCourseDetailsList.studentId ??
                                                '',
                                        courseId:
                                            tutionCourseDetailsList.courseId ??
                                                '',
                                        batchId:
                                            tutionCourseDetailsList.batchId ??
                                                '',
                                        enrollmentType: tutionCourseDetailsList
                                                .enquiryType ??
                                            '',
                                        type: type,
                                        batchEndDate:
                                                           tutionCourseDetailsList
                                                                        .batchEndDate ?? '',
                                        batchMode:
                                            tutionCourseDetailsList.batchMode ??
                                                '',
                                      ));
                                },
                                tutionName:
                                    tutionCourseDetailsList.tutionName ?? '',
                                email: email,
                                phno: phnno,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 30, // Adjust size as needed
                                            backgroundColor:
                                                Colors.grey, // Customize color
                                            child: Icon(
                                              Icons
                                                  .person, // Customize icon if needed
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                              width:
                                                  10), // Space between avatar and details
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                _buildRow(
                                                    'Tutee name',
                                                    tutionCourseDetailsList
                                                        .studentName,context),
                                                _buildRow(
                                                    'Class',
                                                    tutionCourseDetailsList
                                                        .className,context),
                                                _buildRow(
                                                    'Board',
                                                    tutionCourseDetailsList
                                                        .board,context),
                                                _buildRow(
                                                    'Batch name',
                                                    tutionCourseDetailsList
                                                        .courseName,context),
                                                _buildRow(
                                                    'Subject',
                                                    tutionCourseDetailsList
                                                        .subject,context),
                                                _buildRow(
                                                    'Tutor',
                                                    tutionCourseDetailsList
                                                        .tutorName,context),
                                                _buildRow(
                                                    tutionCourseDetailsList
                                                                .institudeId !=
                                                            null
                                                        ? 'Institute name'
                                                        : 'Tution name',
                                                    tutionCourseDetailsList
                                                        .tutionName,context),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // Display "Accept" and "Reject" buttons outside the column
                                      if (classController
                                                  .selectedTabIndex.value ==
                                              0 &&
                                          type == 'Tutor' &&
                                          (classController.instituteId ==
                                                  null ||
                                              classController.instituteId ==
                                                  ""))
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  _showConfirmationDialog(
                                                      context,
                                                      tutionCourseDetailsList);
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
                                                    "Accept",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                                width:
                                                    10), // Spacing between buttons
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  _showConfirmationDialog1(
                                                      context,
                                                      tutionCourseDetailsList);
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
                                                    "Reject",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                      if (classController
                                                  .selectedTabIndex.value ==
                                              1 &&
                                          type == 'Tutor' &&
                                          !tutionCourseDetailsList
                                              .alreadyEnrollment! &&
                                          (classController.instituteId ==
                                                  null ||
                                              classController.instituteId ==
                                                  ''))
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  Get.to(
                                                      () => AddEnrollmentScreen(
                                                            tuteename:
                                                                tutionCourseDetailsList
                                                                        .studentName ??
                                                                    '',
                                                            batchname:
                                                                tutionCourseDetailsList
                                                                        .courseName ??
                                                                    '',
                                                            classname:
                                                                tutionCourseDetailsList
                                                                        .className ??
                                                                    '',
                                                            subject:
                                                                tutionCourseDetailsList
                                                                        .subject ??
                                                                    '',
                                                            board:
                                                                tutionCourseDetailsList
                                                                        .board ??
                                                                    '',
                                                            batchStartingTime:
                                                                tutionCourseDetailsList
                                                                        .batchTimingStart ??
                                                                    '',
                                                            batchEndingTime:
                                                                tutionCourseDetailsList
                                                                        .batchTimingEnd ??
                                                                    '',
                                                            tutorname:
                                                                tutionCourseDetailsList
                                                                        .tutorName ??
                                                                    '',
                                                            courseCodeName:
                                                                tutionCourseDetailsList
                                                                        .courseCode ??
                                                                    '',
                                                            fees:
                                                                tutionCourseDetailsList
                                                                        .fees ??
                                                                    '',
                                                            tutorId:
                                                                tutionCourseDetailsList
                                                                        .tutorId ??
                                                                    '',
                                                            tuteeId:
                                                                tutionCourseDetailsList
                                                                        .studentId ??
                                                                    '',
                                                            courseId:
                                                                tutionCourseDetailsList
                                                                        .courseId ??
                                                                    '',
                                                            batchId:
                                                                tutionCourseDetailsList
                                                                        .batchId ??
                                                                    '',
                                                            enrollmentType:
                                                                tutionCourseDetailsList
                                                                        .enquiryType ??
                                                                    '',
                                                            type: type,
                                                            batchEndDate:
                                                            tutionCourseDetailsList
                                                                        .batchEndDate ?? '',
                                                            batchMode:
                                                                tutionCourseDetailsList
                                                                        .batchMode ??
                                                                    '',
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
                                                    "Enroll now",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                                width:
                                                    10), // Spacing between buttons
                                          ],
                                        ),
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
              )
            ],
          )),
    );
  }

  Widget _buildRow(String title, String? value,BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.3,
          child: Text(
            value ?? '',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ),
      ],
    );
  }

  // Display the confirmation dialog
  // void _showConfirmationDialog(
  //     BuildContext context, dynamic tutionCourseDetailsList) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Are you sure?'),
  //         content: Text('Do you want to accept with this Enquiry?'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               // Close the dialog when 'No' is clicked
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('No'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               // Call the updateClass method when 'Yes' is clicked
  //              classController.updateEnquire(tutionCourseDetailsList.enquiryId!,'Approved');
  //               Navigator.of(context).pop(); // Close the dialog after update
  //             },
  //             child: Text('Yes'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _showConfirmationDialog(
      BuildContext context, dynamic tutionCourseDetailsList) {
    Get.dialog(
      CustomDialogBox(
        title1: 'Do you want to accept this enquiry?',
        title2: '',
        subtitle: 'Do you want to accept this Enquiry?',
        icon: const Icon(Icons.help_outline, color: Colors.white),
        color: const Color(0xFF833AB4), // Set the primary color
        color1: const Color(0xFF833AB4), // Optional gradient color
        singleBtn: false, // Show both 'Yes' and 'No' buttons
        btnName: 'No',
        onTap: () {
          // Close the dialog when 'No' is clicked
          Get.back();
        },
        btnName2: 'Yes',
        onTap2: () async {
          // Call the updateClass method when 'Yes' is clicked
         Get.back();
                  final response = await  classController.updateEnquire(
            context,
            tutionCourseDetailsList.enquiryId!,
            'Approved',
          );
          // Close the dialog after update
           if (response) {
          showConfirmationDialogAccept(Get.context!);
           }
        },
      ),
      barrierDismissible:
          false, // Prevent closing the dialog by tapping outside
    );
  }

  void _showConfirmationDialog1(
      BuildContext context, dynamic tutionCourseDetailsList) {
    Get.dialog(
      CustomDialogBox(
        title1: 'Would you like to ask a query or reject the enquiry request?',
        title2: '',
        subtitle: 'Would you like to ask a query or reject the enquiry request?',
        icon: const Icon(Icons.help_outline, color: Colors.white),
        color: const Color(0xFF833AB4), // Set the primary color
        color1: const Color(0xFF833AB4), // Optional gradient color
        singleBtn: false, // Show both 'Yes' and 'No' buttons
        btnName: 'No',
        onTap: () {
          // Close the dialog when 'No' is clicked
          Get.back();
        },
        btnName2: 'Yes',
        onTap2: () {
          // Call the updateClass method when 'Yes' is clicked
          classController.updateEnquire(
            context,
            tutionCourseDetailsList.enquiryId!,
            'Rejected',
          );
          classController.tabController.animateTo(2);
          // Close the dialog after update
          Get.back();
        },
      ),
      barrierDismissible: false, // Prevent accidental dismissal
    );
  }

 void showConfirmationDialogAccept(BuildContext context ) {
    showModalBottomSheet(
                                                        isDismissible: false,
                                                        enableDrag: false,
                                                        context: context,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        builder: (context) {
                                                          return CustomDialogBox1(
                                                            title1:
                                                                "Enquiry Accepted! ",
                                                            title2: '',
                                                            subtitle: 'Note: You may now begin the enrollment process',
                                                            btnName: 'Ok',
                                                            onTap: () async {
                                                               classController. tabController.animateTo(1);
                                   classController. handleTabChange(1);
                                    print(classController.selectedTabIndex.value);
                                     Navigator.of(context).pop();
                                                            },
                                                            icon: const Icon(
                                                              Icons.check,
                                                              color: Colors.white,
                                                            ),
                                                            color: const Color(
                                                                0xFF833AB4),
                                                            singleBtn: true,
                                                          );
                                                        },
                                                      );
  }
}
