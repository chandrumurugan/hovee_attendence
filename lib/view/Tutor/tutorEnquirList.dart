import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/enquir_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
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
            title: 'Enquir List',
            searchOnTap: () {},
            filterOnTap: () {},
          ),
          //Tabs for Active and Inactive
          TabBar(
            controller: classController.tabController,
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Apporoved'),
              Tab(text: 'Reject'),
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
                    if (classController.selectedTabIndex.value == 0 && type=='Tutor')
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: InkWell(
        onTap: () {
         classController.updateEnquire(tutionCourseDetailsList.enquiryId!,'Approved');
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
          classController.updateEnquire(tutionCourseDetailsList.enquiryId!,'Rejected');
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
}
