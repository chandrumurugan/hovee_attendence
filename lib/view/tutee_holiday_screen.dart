import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/holiday_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class TuteeHolidayScreen extends StatelessWidget {
  final String type;
  final String? firstname,lastname,wowid;
   TuteeHolidayScreen({super.key, required this.type, this.firstname, this.lastname, this.wowid});
final HolidayController holidayController = Get.put(HolidayController());
  @override
  Widget build(BuildContext context) {
    TextStyle fontStyle = GoogleFonts.nunito(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black);
    return Scaffold(
        appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          Get.offAll(DashboardScreen(
                                rolename: type,
                                firstname: firstname,
                                lastname: lastname,
                                wowid: wowid,
                              ));
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            height: 170,
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
              padding: const EdgeInsets.only(top: 25, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row(
                      //   children: [
                      //     IconButton(
                      //       onPressed: () {
                      //         Get.offAll(DashboardScreen(
                      //           rolename: type,
                      //           firstname: firstname,
                      //           lastname: lastname,
                      //           wowid: wowid,
                      //         ));
                      //       },
                      //       icon: const Icon(Icons.arrow_back, color: Colors.white),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 8),
                      Image.asset(
                        'assets/headerIcons/holiday 1 (1).png',
                        height: 35,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Holiday',
                        style: GoogleFonts.nunito(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 22,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 15),
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
           const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
                    'Holiday list',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
          ),
          // Search and Filter Section
          // SearchfiltertabBar(
          //   title: 'Holiday list',
          //   onSearchChanged: (searchTerm) {
          //     // Trigger the search functionality by passing the search term
          //     //batchController.fetchBatchList(searchTerm: searchTerm);
          //   },
          //   filterOnTap: () {
          //     // Implement filter logic here if needed
          //   },
          // ),
          // Header Row
          //const SizedBox(height: 10),
          Obx(() {
            if (holidayController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (holidayController.holidayTuteeDataList.value.isEmpty) {
              return const Center(child: Text("No data found"));
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
                      return Animate(
                          effects: [
                                  SlideEffect(
                                    begin: const Offset(-1, 0), // Start from the left
                                    end: const Offset(
                                        0, 0), // End at the original position
                                    curve: Curves.easeInOut,
                                    duration: 500
                                        .ms, // Consistent timing for each item
                                    delay: 100.ms *
                                        index, // Add delay between items
                                  ),
                                  FadeEffect(
                                    begin: 0, // Start transparent
                                    end: 1, // End opaque
                                    duration: 500.ms,
                                    delay: 100.ms * index,
                                  ),
                                ],
                        child: Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                
                                children: [
                                  Text('Batch name : ${ holidayData.batchName ?? ""}',
                                      style: fontStyle),
                                      const SizedBox(height: 5,),
                                        Text('Holiday name : ${ holidayData.holidayName ?? ""}',
                                      style: fontStyle),
                                      //      Text('Holiday type : ${ holidayData.holidayType ?? ""}',
                                      // style:fontStyle),
                                       const SizedBox(height: 5,),
                                          Text('Date : ${holidayData.holidayFromDate!} - ${holidayData.holidayEndDate!}',
                                      style: fontStyle),
                                
                                
                              ]),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                       IconButton(
                                    iconSize: 25,
                                onPressed: () {}, // No action needed here
                                icon: PopupMenuButton<String>(
                                  icon: const Icon(Icons.more_vert),
                                  onSelected: (String value) {
                                    // Optional if further actions are needed after selection
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return [
                                    
                                      PopupMenuItem(
                                        value: 'Delete',
                                        child: ListTile(
                                          leading: const Icon(Icons.delete),
                                          title: const Text('Delete'),
                                          onTap: () {
                                            Navigator.pop(context);
                                           _showConfirmationDialog(
                                              context, holidayData.sId!);
                                      
                                          },
                                        ),
                                      ),
                                    ];
                                  },
                                ),
                                                          ),
                                
                                Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Text(holidayData.holidayType ?? "",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.nunito(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12,
                                            color: Colors.red)),
                                  ),
                                
                                
                                
                                  
                                ]),
                              )
                            ]),
                            // child: Column(
                            //   children: [
                            //     type!= 'Tutor'?const SizedBox.shrink()
                            //     :Row(
                            //       mainAxisAlignment: MainAxisAlignment.end,
                            //       children: [
                            //         IconButton(
                            //           onPressed: () {
                            //             // Add edit functionality
                                        // Get.to(EditHolidayScreen(
                                        //   holiday: holidayData,
                                        // ));
                            //           },
                            //           icon: const Icon(
                            //             Icons.edit,
                            //             color: Colors.blue,
                            //           ),
                            //         ),
                            //         IconButton(
                                      // onPressed: () {
                                      //   // Add delete functionality
                                      //   _showConfirmationDialog(
                                      //       context, holidayData.sId!);
                                      //   // holidayController.deleteHoliday(
                                      //   //     context, holidayData.sId!);
                                      // },
                            //           icon: const Icon(
                            //             Icons.delete,
                            //             color: Colors.red,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         // Colored strip and S.Name
                            //         // Row(
                            //         //   children: [
                            //         //     Container(
                            //         //       width: 5,
                            //         //       height: 50,
                            //         //       color: Colors.purple,
                            //         //     ),
                            //         //     const SizedBox(width: 8),
                            //         //     Text(
                            //         //       'BM133',
                            //         //       style: TextStyle(
                            //         //         fontWeight: FontWeight.bold,
                            //         //         fontSize: 16,
                            //         //       ),
                            //         //     ),
                            //         //   ],
                            //         // ),
                            //         // B.Name
                            //         Text(
                            //           holidayData.batchName ?? '',
                            //           style: const TextStyle(
                            //               overflow: TextOverflow.ellipsis),
                            //         ),
                            //         // Reason
                                
                            //         // Date
                            //         Text(
                            //       '$formattedDate - $formattedDate2',
                            //       style: const TextStyle(fontSize: 16),
                            //     ),
                            //         SizedBox(
                            //           width: 50,
                            //           child: Text(
                            //             holidayData.holidayName ?? '',
                            //             maxLines: 1,
                            //             style: const TextStyle(
                            //                 overflow: TextOverflow.ellipsis),
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
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
          title1: 'Do you want to remove this holiday?',
          title2: '',
          subtitle: 'Do you want to remove this holiday?',
          icon: const Icon(
            Icons.help_outline,
            color: Colors.white,
          ),
          color: const Color(0xFF833AB4), // Set the primary color
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