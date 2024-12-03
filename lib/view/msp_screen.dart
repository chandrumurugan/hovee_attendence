import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/msp_controller.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';

class MspScreen extends StatelessWidget {
  final String type;
   MspScreen({super.key, required this.type});
final MspController mspController = Get.put(MspController());
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
                      // Image.asset(
                      //   'assets/headerIcons/holiday 1 (1).png',
                      //   height: 35,
                      // ),
                      Text(
                        'MSP',
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
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
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
            title: 'MSP List',
            onSearchChanged: (searchTerm) {
              // Trigger the search functionality by passing the search term
              //batchController.fetchBatchList(searchTerm: searchTerm);
            },
            filterOnTap: () {
              // Implement filter logic here if needed
            },
          ),
          // Header Row
          //const SizedBox(height: 10),
          // Obx(() {
          //    if (mspController.isLoading.value) {
          //       return Center(child: CircularProgressIndicator());
          //     }else if(mspController.holidayDataList.value.isEmpty){
          //        return Center(child: Text("No data found"));
          //     }
          // return Expanded(
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 10),
          //         child: GestureDetector(
          //           child: ListView.builder(
          //             shrinkWrap: true,
          //             padding: EdgeInsets.zero,
          //             itemCount: holidayController
          //                 .holidayDataList.value.length, // Number of items
          //             itemBuilder: (context, index) {
          //               final holidayData =
          //                   holidayController.holidayDataList.value[index];
          //               return Card(
          //                 elevation: 2,
          //                 margin: EdgeInsets.symmetric(vertical: 6),
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(12),
          //                 ),
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(12.0),
          //                   child: Column(
          //                     children: [
          //                        Row(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //           children: [
          //             IconButton(
          //               onPressed: () {
          //                 // Add edit functionality
          //                 Get.to(EditHolidayScreen( holiday: holidayData,));
          //               },
          //               icon: Icon(
          //                 Icons.edit,
          //                 color: Colors.blue,
          //               ),
          //             ),
          //             IconButton(
          //               onPressed: () {
          //                 // Add delete functionality
          //                holidayController.deleteHoliday(context,holidayData.sId!);
          //               },
          //               icon: Icon(
          //                 Icons.delete,
          //                 color: Colors.red,
          //               ),
          //             ),
          //           ],
          //         ),
          //                       Row(
          //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           // Colored strip and S.Name
          //                           Row(
          //                             children: [
          //                               Container(
          //                                 width: 5,
          //                                 height: 50,
          //                                 color: Colors.purple,
          //                               ),
          //                               const SizedBox(width: 8),
          //                               Text(
          //                                 'BM133',
          //                                 style: TextStyle(
          //                                   fontWeight: FontWeight.bold,
          //                                   fontSize: 16,
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                           // B.Name
          //                           Text(holidayData.batchName??''),
          //                           // Date
          //                           Text(holidayData.holidayDate??''),
          //                           // Reason
          //                           Text(holidayData.holidayName??''),
          //                         ],
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               );
          //             },
          //           ),
          //         ),
          //       ),
          //     );
          // }
          //     ),
        ],
      ),
      bottomNavigationBar: SingleCustomButtom(
        btnName: 'Add',
        isPadded: false,
        onTap: () {
           mspController.navigateToAddHolidatScreen();
        },
      ),
    );
  }
}