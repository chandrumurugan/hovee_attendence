import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/annoument_controller.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/widget/leave_list_container.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';

class AnnouncementScreen extends StatelessWidget {
   final String type;
   AnnouncementScreen({super.key, required this.type});
final AnnoumentController anoumentController = Get.put(AnnoumentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                        'Announcement list',
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
                          'list your planned announcement for the upcoming year and keep everything well-organized',
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
               SearchfiltertabBar(
            title: 'Announcement List',
            onSearchChanged: (searchTerm) {
              // Trigger the search functionality by passing the search term
              //batchController.fetchBatchList(searchTerm: searchTerm);
            },
            filterOnTap: () {
              // Implement filter logic here if needed
            },
          ),
              Obx(() {
            if (anoumentController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (anoumentController.announmentList.isEmpty) {
              return Center(
                child: Text(
                  'No list found',
                  style: GoogleFonts.nunito(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: anoumentController.announmentList.length,
                  itemBuilder: (context, index) {
                    final leaveData = anoumentController.announmentList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Card(
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                              
                                    _buildRow('Title', leaveData.title),
                                    const SizedBox(height: 10),
                                     _buildRow('StudentName', '${leaveData.userDetails!.firstName}  ${leaveData.userDetails!.lastName}'),
                                    const SizedBox(height: 10),
                                    _buildRow('BatchName', leaveData.batchList!.batchName),
                                    const SizedBox(height: 10),
                                    _buildRow('ClassName', '${leaveData.courseList!.className}'),
                                    const SizedBox(height: 10),
                                    _buildRow('Subject', leaveData.courseList!.subject),
                                    const SizedBox(height: 10),
                                    _buildRow('Description', leaveData.description),
                                    
                                  ],
                                ),
                              ),
                            ),
                    );
                  },
                ),
              );
            }
          })
        
            ],
          ),
          
          bottomNavigationBar: type == 'Tutor'
                    ?
           SingleCustomButtom(
        btnName: 'Add Announcement',
        isPadded: false,
        onTap: () {
         anoumentController.navigateToAddBatchScreen();
        },
      ):SizedBox.shrink());
  }

    Widget _buildRow(String title, String? value) {
    final displayValue = title == 'Fees' ? '₹ ${value ?? 'N/A'} /month' : value ?? 'N/A';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black.withOpacity(0.4),
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        Text(
          displayValue,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}