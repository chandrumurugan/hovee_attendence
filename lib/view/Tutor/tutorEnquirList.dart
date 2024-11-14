import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/enquir_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/add_enrollment_screen.dart';
import 'package:hovee_attendence/widget/single_button.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';

class Tutorenquirlist extends StatelessWidget {
  final String type;
  
  Tutorenquirlist({super.key,required this.type});

  final EnquirDetailController classController =
      Get.put(EnquirDetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            classController.navigateBack();
          }),
      body: Column(
        children: [
          // Search and Filter Section
          SearchfiltertabBar(
            title: 'Enquiry list',
            onSearchChanged: (searchTerm) {
            },
            filterOnTap: () {
              // Implement filter logic here if needed
            },
          ),
          TabBar(
            controller: classController.tabController,
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Accepted'),
              Tab(text: 'Rejected'),
            ],
          ),
          //Display List based on the selected tab
          Expanded(
  child: Obx(() {
    if (classController.isLoading.value) {
      return Center(child: CircularProgressIndicator());
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
          final tutionCourseDetailsList = classController.enquirList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Card(
              elevation: 10,
              shadowColor: Colors.black,
              surfaceTintColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30, // Adjust size as needed
                          backgroundColor: Colors.grey, // Customize color
                          child: Icon(
                            Icons.person, // Customize icon if needed
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 10), // Space between avatar and details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildRow('Student name', tutionCourseDetailsList.studentName),
                              _buildRow('Course code', tutionCourseDetailsList.courseCode),
                              _buildRow('CourseName', tutionCourseDetailsList.courseName),
                              _buildRow('Subject', tutionCourseDetailsList.subject),
                              _buildRow('Date', tutionCourseDetailsList.batchDays),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    // Display "Accept" and "Reject" buttons outside the column
                    if ((classController.selectedTabIndex.value == 0 && type == 'Tutor') )
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: InkWell(
        onTap: () {
         _showConfirmationDialog(context, tutionCourseDetailsList);
        },
        child: Container(
          width: double.infinity,
          padding: 
               const EdgeInsets.symmetric(vertical: 10),   
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(8),
               gradient: LinearGradient(
                colors: [Color(0xFFBA0161), Color(0xFF510270)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),),
          child: 
          Text( "Accept",
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
            _showConfirmationDialog1(context, tutionCourseDetailsList);
        },
        child: Container(
          width: double.infinity,
          padding: 
               const EdgeInsets.symmetric(vertical: 10),   
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(8),
               gradient: LinearGradient(
                colors: [Color(0xFFBA0161), Color(0xFF510270)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),),
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
                       if ((classController.selectedTabIndex.value == 1 && type == 'Tutor') )
                       Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: InkWell(
        onTap: () {
         Get.off(() => AddEnrollmentScreen(tuteename:tutionCourseDetailsList.studentName! , batchname: tutionCourseDetailsList.courseName!, classname: tutionCourseDetailsList.className!, subject: tutionCourseDetailsList.subject!, board: tutionCourseDetailsList.board!, batchStartingTime: tutionCourseDetailsList.batchTimingStart!, batchEndingTime:tutionCourseDetailsList.batchTimingEnd!, tutorname: tutionCourseDetailsList.tutorName!, courseCodeName: tutionCourseDetailsList.courseCode!, fees: tutionCourseDetailsList.fees!, tutorId:tutionCourseDetailsList.tutorId!, tuteeId:tutionCourseDetailsList.studentId!, courseId:tutionCourseDetailsList.courseId!, batchId:tutionCourseDetailsList.batchId!, enrollmentType:tutionCourseDetailsList.enquiryType!, type: type,)); 
        },
        child: Container(
          width: double.infinity,
          padding: 
               const EdgeInsets.symmetric(vertical: 10),   
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(8),
               gradient: LinearGradient(
                colors: [Color(0xFFBA0161), Color(0xFF510270)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),),
          child: 
          Text( "Start Enroll",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.white)),
        ),
      ),
                          ),
                          const SizedBox(width: 10), // Spacing between buttons
                         
                        ],
                      ),
                  ],
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
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
        ),
      ],
    );
  }

  // Display the confirmation dialog
  void _showConfirmationDialog(
      BuildContext context, dynamic tutionCourseDetailsList) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to accept with this Enquiry?'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog when 'No' is clicked
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Call the updateClass method when 'Yes' is clicked
               classController.updateEnquire(tutionCourseDetailsList.enquiryId!,'Approved');
                Navigator.of(context).pop(); // Close the dialog after update
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

   void _showConfirmationDialog1(
      BuildContext context, dynamic tutionCourseDetailsList) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to reject with this Enquiry?'),
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog when 'No' is clicked
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Call the updateClass method when 'Yes' is clicked
               classController.updateEnquire(tutionCourseDetailsList.enquiryId!,'Rejected');
                Navigator.of(context).pop(); // Close the dialog after update
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}