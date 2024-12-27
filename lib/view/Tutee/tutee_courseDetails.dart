import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/courseDetails_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/view/Tutee/preview_screen.dart';
import 'package:hovee_attendence/widget/doubleCustombtn.dart';
import 'package:hovee_attendence/modals/getClassTuteeById_model.dart';
import 'package:hovee_attendence/widgets/details_header.dart';

class CourseDetailScreen extends StatelessWidget {
  final Data1? data;
  final String tutorname,fees,maxSlots,startDate,endDate;
  
  CourseDetailScreen({super.key, required this.data,required this.tutorname, required this.fees, required this.maxSlots, required this.startDate, required this.endDate});

  final CourseDetailController controller = Get.put(CourseDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // bottomNavigationBar: DoubleCustomButtom(
        //     btnName1: "Call now",
        //     isPadded: false,
        //     onTap1: () {
        //       controller.makePhoneCall(
        //         controller.phoneNumber!,
        //       );
        //     },
        //     btnName2: "Enquire Now",
        //     onTap2: () {
        //       Get.off(PreviewScreen(
        //         data: data,
        //         type: 'Course', tutorname: tutorname, type1: '', tuteename: '', tuteeemail: '', tuteephn: '',
                
        //       ));
        //     }),
         bottomNavigationBar: DoubleCustomButtom(
    btnName1: "Call now",
    isPadded: false,
    onTap1: () {
      _showConfirmationDialog(
        context,
        () {
          // Navigate to the inquiry preview page
          // Proceed to submit the inquiry
          controller.makePhoneCall(
            controller.phoneNumber!,
          );
        },
      );
    },
    btnName2: "Enquire Now",
    onTap2: () {
       _showConfirmationDialog1(
        context,
        () {
          // Navigate to the inquiry preview page
          // Proceed to submit the inquiry
          Get.to(PreviewScreen(
        data: data,
        type: 'Course',
        tutorname: tutorname,
        type1: '',
        tuteename: '',
        tuteeemail: '',
        tuteephn: '',
      ));
        },
      );
     
    },
  ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DeatilHeader(
                  subject: data!.subject!, Coursecode: tutorname),
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
                          'Board / Class',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${data!.board} / ${data!.className}',
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
                          'Working days',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.7,
                          child: Text(
                            data!.workingDays?.join(', ') ??
                                'No working days available',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ),
                        ),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Batches',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          data!.batchList?.join('\n') ?? 'No batches available',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
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
                          'Fees',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "₹ $fees /month",
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
                          'Batch maximum slots',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          maxSlots,
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
                        data!.address!,
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
        ));
  }

  // Method for showing the confirmation dialog
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
