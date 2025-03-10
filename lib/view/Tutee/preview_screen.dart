import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/courseDetails_controller.dart';
import 'package:hovee_attendence/controllers/enquir_controller.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/modals/getClassTuteeById_model.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';
import 'package:hovee_attendence/widget/doubleCustombtn.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';
import 'package:hovee_attendence/widgets/preview_header.dart';
import 'package:hovee_attendence/modals/getClassTuteeById_model.dart';

class PreviewScreen extends StatelessWidget {
  final dynamic data;
  final String type;
  final String type1;
  final String tutorname;
  final String tuteename;
  final String tuteeemail;
  final String tuteephn;
  final String tutionName;
  final String email;
  final String phno;
  final VoidCallback? onPreviewCallbackAccept;
  final VoidCallback? onPreviewCallbackReject;
  final VoidCallback? onPreviewCallbackEnroll;

  PreviewScreen(
      {super.key,
      required this.data,
      required this.type,
      required this.tutorname,
      required this.type1,
      required this.tuteename,
      required this.tuteeemail,
      required this.tuteephn,
      this.onPreviewCallbackAccept,
      this.onPreviewCallbackReject,
      this.onPreviewCallbackEnroll,
      required this.tutionName,
      required this.email,
      required this.phno});

  final CourseDetailController controller = Get.put(CourseDetailController());
  final EnquirDetailController classController =
      Get.put(EnquirDetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          Navigator.pop(context);
          print(data);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PreviewHeader(
              bgImage:
                  'assets/bgImage/teacherModel-removebg-preview-removebg-preview.jpg',
              title: data!.subject!,
              subtitle: 'Tutor name: ${tutorname}',
              ratingCount: '4.8',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Tutee details',
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
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
                      "Name",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    type == 'Course'
                        ? Text(
                            controller.username ?? '',
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          )
                        : Text(
                            tuteename ?? '',
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
                      "Email",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    type == 'Course'
                        ? Text(
                            data.tuteeInformation.email ?? '',
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          )
                        : Text(
                            data.studentEmail ?? '',
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
                      "Phone",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    type == 'Course'
                        ? Text(
                            data.tuteeInformation.phoneNumber ?? '',
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          )
                        : Text(
                            data.studentPhoneNo ?? '',
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
                      "Class",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    Text(
                      data!.className!,
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            type1 == 'Tutee'
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(color: Colors.grey.shade300),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "School/Institute Name:",
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                          Text(
                            controller.organizationName!,
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Location',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Container(
                      height: 44,
                      width: 47,
                      decoration: BoxDecoration(
                          color: Color(0xffD9D9D9).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8)),
                      child: Icon(
                        Icons.location_on,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                     type == 'Course'
                     ?  controller.storedAddress ?? '' : data!.studentAddress,
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Tution details',
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
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
                      "Subject",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    Text(
                      data!.subject ?? '',
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
                      "Class",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    Text(
                      data!.className! ?? '',
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
                      "Board",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    Text(
                      data!.board! ?? '',
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
                      "Batch days",
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                    Container(
                      //color: Colors.amber,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        textAlign: TextAlign.right,
                        type == 'Course'
                            ? (data!.batches!.batchDays.join(', ') ?? '')
                            : (data!.batchDays?.join(', ') ?? ''),
                        style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
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
                      (() {
                        if (type == "Course") {
                          if (data.institudesDetails != null) {
                            return "Institute name";
                          } else {
                            return "Tution name";
                          }
                        } else {
                          if (data.institudeId != null) {
                            return "Institute name";
                          } else {
                            return "Tution name";
                          }
                        }
                      })(),
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    type == "Course" && data.institudesDetails != null
                        ? Text(
                            data.institudesDetails.institudeName,
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          )
                        : Text(
                            tutionName ?? '',
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          )
                  ],
                ),
              ),
            ),
            type == "Course"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Location',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Container(
                                height: 44,
                                width: 47,
                                decoration: BoxDecoration(
                                    color: Color(0xffD9D9D9).withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Icon(
                                  Icons.location_on,
                                  size: 40,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              data!.address ?? '',
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Location',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Container(
                                height: 44,
                                width: 47,
                                decoration: BoxDecoration(
                                    color: Color(0xffD9D9D9).withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Icon(
                                  Icons.location_on,
                                  size: 40,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: Text(
                              data!.tutorAddress ?? '',
                              style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
            // :Container()
            SizedBox(
              height: 8,
            ),
            if ((type1 == 'Tutor' && data.status == 'Pending' &&data.institudeId==null))
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          onPreviewCallbackAccept!();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFBA0161), Color(0xFF510270)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Text("Accept",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Spacing between buttons
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          onPreviewCallbackReject!();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                              colors: [Color(0xFFBA0161), Color(0xFF510270)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Text("Reject",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(
              height: 10,
            ),
            //   if(type!= 'Course')
            //    if ((data.status=='Approved' &&
            //   type1 == 'Tutor'))
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Expanded(
            //       child: InkWell(
            //         onTap: () {

            //          onPreviewCallbackEnroll!();
            //         },
            //         child: Container(
            //           width: double.infinity,
            //           padding: const EdgeInsets.symmetric(
            //               vertical: 10),
            //           decoration: BoxDecoration(
            //             borderRadius:
            //                 BorderRadius.circular(8),
            //             gradient: const LinearGradient(
            //               colors: [
            //                 Color(0xFFBA0161),
            //                 Color(0xFF510270)
            //               ],
            //               begin: Alignment.topCenter,
            //               end: Alignment.bottomCenter,
            //             ),
            //           ),
            //           child: Text("Enroll now",
            //               textAlign: TextAlign.center,
            //               style: GoogleFonts.nunito(
            //                   fontWeight: FontWeight.w500,
            //                   fontSize: 20,
            //                   color: Colors.white)),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(
            //         width: 10), // Spacing between buttons
            //   ],
            // ),
            // SizedBox.shrink()
          ],
        ),
      ),
      bottomNavigationBar: type == 'Course'
          ? SingleCustomButtom(
              btnName: 'Submit',
              isPadded: false,
              onTap: () {
                final storage = GetStorage();
                final studentId = storage.read('id');
                print(data!.courseId!);
                print(studentId);
                print(data!.tutorId!);
                _showConfirmationDialog(
                    context, data!.courseId!, studentId, data!.tutorId!,data!.batches!.batchName! ?? '',data!.subject ?? '',tutorname ?? '');
                  
              },
            )
          : data.status == 'Approved' &&
                  type1 == 'Tutor' &&
                  data.alreadyEnrollment == false &&data.institudeId==null
              ? SingleCustomButtom(
                  btnName: 'Enroll now',
                  isPadded: false,
                  onTap: () {
                    onPreviewCallbackEnroll!();
                  },
                  isDisabled:
                      false, // The button is always enabled since it's not displayed when already enrolled
                )
              : SizedBox.shrink(),
    );
  }

  void _showConfirmationDialog(
      BuildContext context, String courseId, String studentId, String tutorId,String batch,subject,tutorname) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          title1: 'Do you want to submit the enquiry?',
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
            // Close the dialog when 'No' is clicked
            Navigator.of(context).pop();
          },
          btnName2: 'Yes',
          onTap2: () async {
            // Call the addEnquirs method with the parent context
           Get.back();
                  final response = await  controller.addEnquirs(
              Get.context!, // Use Get.context instead of dialog context
              courseId,
              studentId,
              tutorId,
              batch,
              subject,
              tutorname
            );
           // Navigator.of(context).pop();
             if (response) {
                     showConfirmationDialog1(Get.context!,data!.batches!.batchName! ?? '',data!.subject ?? '',tutorname ?? '');
                  }
             
          },
        );
      },
    );
  }

    void showConfirmationDialog1(BuildContext context,String batch,subject,tutorname ) {
    showModalBottomSheet(
                                                        isDismissible: false,
                                                        enableDrag: false,
                                                        context: context,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        builder: (context) {
                                                          return CustomDialogBox1(
                                                            title1:
                                                                "Enquiry sent successfully! for $batch($subject)",
                                                            title2: '',
                                                            subtitle: 'Note: $tutorname will receive your enquiry request',
                                                            btnName: 'Ok',
                                                            onTap: () async {
                                                               Get.delete<EnquirDetailController>();
         Get.off(() => Tutorenquirlist(type: 'Tutee', fromBottomNav: true,)); 
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
