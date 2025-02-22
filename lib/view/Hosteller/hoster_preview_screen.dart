import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/courseDetails_controller.dart';
import 'package:hovee_attendence/controllers/enquir_controller.dart';
import 'package:hovee_attendence/controllers/hostel_enquiry_controller.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/modals/getHostelFilterListModel.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_enquiry_list.dart';
import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';
import 'package:hovee_attendence/widgets/preview_header.dart';
import 'package:intl/intl.dart';

class HosterPreviewScreen extends StatelessWidget {
  final Datum? data;
  HosterPreviewScreen({super.key, this.data});
  final UserProfileController userProfileData =
      Get.put(UserProfileController());
  final CourseDetailController enquiryController =
      Get.put(CourseDetailController());
       final HostelEnquiryController hostelEnquiryController =
        Get.put(HostelEnquiryController());
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
              PreviewHeaderHostel(
                bgImage:data!.profileUrl?? '',
                title: 'Hostel name',
                subtitle: data!.hostelName ?? '',
                ratingCount: '',
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Personal information',
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
                      Text(
                        '${userProfileData.userProfileResponse.value.data!.firstName ?? ''} ${userProfileData.userProfileResponse.value.data!.lastName ?? ''}',
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
                      Text(
                        userProfileData.userProfileResponse.value.data!.email ??
                            '',
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
                      Text(
                        userProfileData
                                .userProfileResponse.value.data!.phoneNumber ??
                            '',
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
                        "DOB",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                      Text(
                       formatDate(userProfileData
                                .userProfileResponse.value.data!.dob!),
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
              ),
              Column(
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
                             '${userProfileData
                                .userProfileResponse.value.data!.doorNo!.toString()} ${userProfileData
                                .userProfileResponse.value.data!.street!.toString()} ${userProfileData
                                .userProfileResponse.value.data!.city!.toString()} ${userProfileData
                                .userProfileResponse.value.data!.state!.toString()} ${userProfileData
                                .userProfileResponse.value.data!.country!.toString()} -${userProfileData
                                .userProfileResponse.value.data!.pincode.toString()}',
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
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Hostel information',
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
                        "Hostel name",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                      Text(
                        data!.hostelName ?? '',
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
                        "Hostel type",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                      Text(
                        data!.hostelType ?? '',
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
                        "Hostel price",
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                      data!.hostelPriceDetails!=null?
                      Text(
                        '₹ ${data!.hostelPriceDetails!.price.toString()} /month' ??
                            '',
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ):SizedBox.shrink()
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 14.0),
              //   child: Container(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              //     decoration: BoxDecoration(color: Colors.white),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           "Phone",
              //           style: GoogleFonts.nunito(
              //               color: Colors.black,
              //               fontWeight: FontWeight.w400,
              //               fontSize: 16),
              //         ),
              //         SizedBox(
              //           width: MediaQuery.of(context).size.width * 0.6,
              //           child: Text(
              //             '',
              //             style: GoogleFonts.nunito(
              //               color: Colors.black,
              //               fontWeight: FontWeight.w400,
              //               fontSize: 16,
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              Column(
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
                          '${data!.doorNo!.toString()} ${data!.street!.toString()} ${data!.city!.toString()} ${data!.state!.toString()} ${data!.country!.toString()} -${data!.pincode!.toString()}',
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

              // :Container()
            ],
          ),
        ),
        bottomNavigationBar: SingleCustomButtom(
          btnName: 'Submit',
          isPadded: false,
          onTap: () {
            final storage = GetStorage();
            final studentId = storage.read('id');
            _showConfirmationDialog(context, data!.id!, data!.hostelObjectId!,
                userProfileData.userProfileResponse.value.data!.id ?? '');
          },
        ));
  }

  void _showConfirmationDialog(BuildContext context, String hostelId,
      String hostelObjectId, String hostellerObjectId) {
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
            final response = await enquiryController.addHostelEnquirs(
              Get.context!, // Use Get.context instead of dialog context
              hostelId,
              hostelObjectId,
              hostellerObjectId,
            );
            if (response) {
              showConfirmationDialog1(Get.context!);
           }
          },
        );
      },
    );
  }

  void showConfirmationDialog1(
    BuildContext context,
  ) {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return CustomDialogBox2(
          title1: "Enquiry sent successfully!",
          title2: '',
          subtitle: '',
          btnName: 'Ok',
          onTap: () async {
            Get.delete<EnquirDetailController>();
            hostelEnquiryController.onInit();
            Get.off(() => HostelEnquiryList(
                  type: 'Hosteller',
                  fromBottomNav: true,
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

   String formatDate(String dob) {
  try {
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(dob);
    return DateFormat('dd-MM-yyyy').format(parsedDate);
  } catch (e) {
    return dob; // Return original string if parsing fails
  }
}
}
