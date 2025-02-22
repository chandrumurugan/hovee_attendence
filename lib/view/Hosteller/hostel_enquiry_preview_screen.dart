import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/modals/getHostelEnquiryListModel.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/widgets/preview_header.dart';
import 'package:intl/intl.dart';

class HostelEnquiryPreviewScreen extends StatelessWidget {
  final Datum? data;
   HostelEnquiryPreviewScreen({super.key, this.data});
 final UserProfileController userProfileData =
        Get.put(UserProfileController());
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
              bgImage:
                 data!.hostelLists!.profileUrl ?? '',
              title: 'Hostel name',
              subtitle: data!.hostelLists!.hostelName ?? '',
              ratingCount: '',
            ),
            SizedBox(height: 5,),
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
                            userProfileData.userProfileResponse.value.data!.email ?? '',
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
                            userProfileData.userProfileResponse.value.data!.phoneNumber ?? '',
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
                                .userProfileResponse.value.data!.state!.toString()} ${data!.hostelLists!.country!.toString()} -${userProfileData
                                .userProfileResponse.value.data!.toString()}',
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
                       data!.hostelLists!.hostelName ?? '',
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
                      data!.hostelLists!.hostelType ?? '',
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
                     '₹ ${ data!.hostelPriceDetails!.price.toString()} /month' ?? '',
                      style: GoogleFonts.nunito(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ):SizedBox.shrink()
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
                             '${data!.hostelLists!.doorNo!.toString()} ${data!.hostelLists!.street!.toString()} ${data!.hostelLists!.city!.toString()} ${data!.hostelLists!.state!.toString()} ${data!.hostelLists!.country!.toString()} -${data!.hostelLists!.pincode!.toString()}',
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