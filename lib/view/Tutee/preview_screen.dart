import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/courseDetails_controller.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/modals/getClassTuteeById_model.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
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
  PreviewScreen({super.key, required this.data, required this.type, required this.tutorname, required this.type1, required this.tuteename, required this.tuteeemail, required this.tuteephn});

   
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
              title: data!.subject!,
              subtitle: tutorname,
              ratingCount: '4.8',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Tutee Preview Details',
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
             Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          color: 
                             
                               Colors.grey.shade300),
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
                          type=='Course'?
                          Text(
                           controller.username?? '',
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ):
                          Text(
                           tuteename?? '',
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  )
          ,
          Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          color: 
                             
                               Colors.white),
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
                            controller.email!,
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  )
          ,
          Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          color: 
                             
                               Colors.grey.shade300),
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
                         controller.phoneNumber!,
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  )
          ,
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
          //                   "Gender",
          //                   style: GoogleFonts.nunito(
          //                       color: Colors.black,
          //                       fontWeight: FontWeight.w400,
          //                       fontSize: 16),
          //                 ),
          //                 Text(
          //                   '',
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
          //                   "Occupation Status",
          //                   style: GoogleFonts.nunito(
          //                       color: Colors.black,
          //                       fontWeight: FontWeight.w400,
          //                       fontSize: 16),
          //                 ),
          //                 Text(
          //                  '',
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
          Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          color: 
                             
                               Colors.white),
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
                  )
          ,
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
          //                   "Languages Known",
          //                   style: GoogleFonts.nunito(
          //                       color: Colors.black,
          //                       fontWeight: FontWeight.w400,
          //                       fontSize: 16),
          //                 ),
          //                 Text(
          //                  '',
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
           type1=='Tutee'
                          ?
          Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          color: 
                             
                               Colors.grey.shade300),
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
                  ):Container()
          ,
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
          //         )
          // ,
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
                            child: Icon(Icons.location_on,size: 40,color: Colors.red,),
                      ),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                     controller.storedAddress!??'',
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
             SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Tution Details',
                style: GoogleFonts.nunito(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            SizedBox(height: 8,),
            Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          color: 
                             
                               Colors.grey.shade300),
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
                           data!.subject?? '',
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  )
          ,
          Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          color: 
                             
                               Colors.white),
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
                            data!.className!??'',
                            style: GoogleFonts.nunito(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  )
          ,
          Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          color: 
                             
                               Colors.grey.shade300),
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
                         data!.board!??'',
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      decoration: BoxDecoration(
                          color: 
                             
                               Colors.white),
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
                          Text(
  type == 'Course'
      ? (data!.workingDays?.join(', ') ?? '')
      : (data!.batchDays  ?? ''),
  style: GoogleFonts.nunito(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  ),
)

                        ],
                      ),
                    ),
                  )
          ,
          type=="Course"?
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
                            child: Icon(Icons.location_on,size: 40,color: Colors.red,),
                      ),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: 
                    Text(
                     data!.address ??'',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    )
                  ),
                ],
              ),
            ),
            ],
          )
          :Column(
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
                            child: Icon(Icons.location_on,size: 40,color: Colors.red,),
                      ),
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: 
                    Text(
                     data!.tutorAddress ??'',
                      style: GoogleFonts.nunito(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    )
                  ),
                ],
              ),
            ),
            ],
          )
         // :Container()
           
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
            // controller.addEnquirs(
            //   context,
            //   data!.courseId!,
            //   studentId,
            //   data!.tutorId!,
            // );
            _showConfirmationDialog(context,data!.courseId!,studentId,data!.tutorId!);
          },
        )
      : null,
    );
    
  }

   void _showConfirmationDialog(
      BuildContext context, String courseId, String studentId, String tutorId) {
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
          onTap2: () {
            // Call the addEnquirs method with the parent context
            controller.addEnquirs(
              Get.context!, // Use Get.context instead of dialog context
              courseId,
              studentId,
              tutorId,
            );
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}