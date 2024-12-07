import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/holiday_controller.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class TuteeHolidayScreen extends StatelessWidget {
  final String type;
   TuteeHolidayScreen({super.key, required this.type});
final HolidayController holidayController = Get.put(HolidayController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            height: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(0)),
              image: DecorationImage(
                image: AssetImage(
                  'assets/Course_BG_Banner.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 25, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.offAll(DashboardScreen(
                                rolename: type,
                              ));
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/headerIcons/holiday 1 (1).png',
                        height: 35,
                      ),
                      Text(
                        'Holiday',
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 15),
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text(
                          'Here, you can see the holidays declared for the year, helping you stay informed and plan your schedule accordingly.',
                          overflow: TextOverflow.clip,
                          maxLines: 2,
                          style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Search and Filter Section
          SearchfiltertabBar(
            title: 'Holiday List',
            onSearchChanged: (searchTerm) {
              // Trigger the search functionality by passing the search term
              //batchController.fetchBatchList(searchTerm: searchTerm);
            },
            filterOnTap: () {
              // Implement filter logic here if needed
            },
          ),
          // Header Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Text('S. Name', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Batch Name',
                    style: TextStyle(fontWeight: FontWeight.bold)),

                Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Holiday Name',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          //const SizedBox(height: 10),
          Obx(() {
            if (holidayController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (holidayController.holidayTuteeDataList.value.isEmpty) {
              return Center(child: Text("No data found"));
            }
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: holidayController
                        .holidayTuteeDataList.value.length, // Number of items
                    itemBuilder: (context, index) {
                      final holidayData =
                          holidayController.holidayTuteeDataList.value[index];
                          DateTime dateTime = DateFormat("dd-MM-yyyy").parse(holidayData.holidayFromDate!);
                          Logger().i("123456===>$dateTime");
                           String formattedDate = DateFormat("ddMMMyy").format(dateTime);
                           Logger().i("0987654===>$formattedDate");
                            DateTime dateTime2 = DateFormat("dd-MM-yyyy").parse(holidayData.holidayEndDate!);
                          Logger().i("123456===>$dateTime");
                           String formattedDate2 = DateFormat("ddMMMyy").format(dateTime2);
                           Logger().i("0987654===>$formattedDate");
                      return Card(
                        elevation: 2,
                        margin: EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                    onPressed: () {
                                      // Add delete functionality
                                      _showConfirmationDialog(
                                          context, holidayData.sId!);
                                      // holidayController.deleteHoliday(
                                      //     context, holidayData.sId!);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    holidayData.batchName ?? '',
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  // Reason
                              
                                  // Date
                                  Text(
                                '$formattedDate - $formattedDate2',
                                style: TextStyle(fontSize: 16),
                              ),
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      holidayData.holidayName ?? '',
                                      maxLines: 1,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      
    );
  }

   void _showConfirmationDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          title1: 'Do you want to delete this holiday?',
          title2: '',
          subtitle: 'Do you want to delete this holiday?',
          icon: const Icon(
            Icons.help_outline,
            color: Colors.white,
          ),
          color: Color(0xFF833AB4), // Set the primary color
          color1: const Color(0xFF833AB4), // Optional gradient color
          singleBtn: false, // Show both 'Yes' and 'No' buttons
          btnName: 'No',
          onTap: () {
            // Call the updateClass method when 'Yes' is clicked
            // Close the dialog after update
            Navigator.of(context).pop();
          },
          btnName2: 'Yes',
          onTap2: () {
            // Close the dialog when 'No' is clicked
            holidayController.deleteHoliday(context, id);
            // classController.tabController.animateTo(1);
            // classController.handleTabChange(1);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

}