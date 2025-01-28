import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/hosteller_controller.dart';
import 'package:hovee_attendence/modals/getHostelFilterListModel.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/view/Hosteller/hoster_preview_screen.dart';
import 'package:hovee_attendence/widget/doubleCustombtn.dart';
import 'package:hovee_attendence/widgets/details_header.dart';

class HostelDetailsScreen extends StatelessWidget {
   final Datum? data;
   HostelDetailsScreen({super.key, this.data});
 final HostellerController controller = Get.put(HostellerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: DoubleCustomButtom(
          btnName1: "Call now",
          isPadded: false,
          onTap1: () {
            _showConfirmationDialog(
              context,
              () {
                //controller.makePhoneCall(controller.phoneNumber!);
              },
            );
          },
          btnName2: "Enquire Now",
          onTap2:  () {
              _showConfirmationDialog1(
                    context,
                    () {
                      Get.to(HosterPreviewScreen(
                        data: data,
                      ));
                    },
                  );
                 
                },
          isButton2Enabled: 
              true, // Disable the button if alreadyExits is true
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DeatilHeader(
                  subject: "Hostel name",
                  Coursecode:
                     data!.hostelName ?? '',
                  address: '',
                ),
               Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ' About',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ),
                     Padding(
                  padding: const EdgeInsets.all(10.0),
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
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hostel name',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            data!.hostelName ?? '',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Specifications',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hostel type',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            data!.hostelType ?? '',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                  Padding(
                  padding: const EdgeInsets.all(10.0),
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
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Food',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            data!.food ?? '',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
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
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Room type',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            data!.hostelPriceDetails!.roomType ?? '',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                    Padding(
                  padding: const EdgeInsets.all(10.0),
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
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Room type',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            data!.hostelPriceDetails!.roomType ?? '',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                    Padding(
                  padding: const EdgeInsets.all(10.0),
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
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            data!.hostelPriceDetails!.price.toString() ?? '',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(10.0),
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
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Room count',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            data!.hostelPriceDetails!.roomCount.toString() ?? '',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(10.0),
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
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hostel timing',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '${data!.hostelTimingStart ?? ''} -${data!.hostelTimingEnd ?? ''}',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                    Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  ' Location',
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

  void _showConfirmationDialog(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          title1: 'Would you like to call now?',
          title2: '',
          subtitle: 'Do you want to call now?',
          icon: const Icon(Icons.help_outline, color: Colors.white),
          color: const Color(0xFF833AB4), // Set the primary color
          color1: const Color(0xFF833AB4), // Optional gradient color
          singleBtn: false, // Show both 'Yes' and 'No' buttons
          btnName: 'No',
          onTap: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          btnName2: 'Yes',
          onTap2: () {
            Navigator.of(context).pop(); // Close the dialog
            onConfirm(); // Execute the confirm action
          },
        );
      },
    );
  }

   void _showConfirmationDialog1(BuildContext context, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          title1: 'Would you like to enquiry now?',
          title2: '',
          subtitle: 'Do you want to enquiry now?',
          icon: const Icon(Icons.help_outline, color: Colors.white),
          color: const Color(0xFF833AB4), // Set the primary color
          color1: const Color(0xFF833AB4), // Optional gradient color
          singleBtn: false, // Show both 'Yes' and 'No' buttons
          btnName: 'No',
          onTap: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          btnName2: 'Yes',
          onTap2: () {
            Navigator.of(context).pop(); // Close the dialog
            onConfirm(); // Execute the confirm action
          },
        );
      },
    );
  }
}