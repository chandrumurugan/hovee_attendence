import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/annoument_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/view/edit_announcement_screen.dart';
import 'package:hovee_attendence/widget/leave_list_container.dart';
import 'package:hovee_attendence/widget/single_custom_button.dart';

class AnnouncementScreen extends StatelessWidget {
  final String type;
  final String? firstname,lastname,wowid;
  AnnouncementScreen({super.key, required this.type,this.firstname, this.lastname, this.wowid});
  final AnnoumentController anoumentController = Get.put(AnnoumentController());
  @override
  Widget build(BuildContext context) {
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
                        // Row(
                        //   children: [
                        //     IconButton(
                        //       onPressed: () {
                        //         Get.offAll(DashboardScreen(
                        //           rolename: type,
                        //         ));
                        //       },
                        //       icon: Icon(Icons.arrow_back, color: Colors.white),
                        //     ),
                        //   ],
                        // ),
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
                      final leaveData =
                          anoumentController.announmentList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Card(
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildRow(
                                          'Title', leaveData.title, context),
                                      const SizedBox(height: 10),
                                      _buildRow(
                                          'Student name',
                                          '${leaveData.userDetails![0].studentFirstName}  ${leaveData.userDetails![0].studentLastName}',
                                          context),
                                      const SizedBox(height: 10),
                                      _buildRow(
                                          'Batch name',
                                          leaveData.batchDetails!.batchName,
                                          context),
                                      const SizedBox(height: 10),
                                      _buildRow(
                                          'Class name',
                                          '${leaveData.courseDetails!.className}',
                                          context),
                                      const SizedBox(height: 10),
                                      _buildRow('Subject',
                                          leaveData.courseDetails!.subject, context),
                                      const SizedBox(height: 10),
                                      _buildRow('Description',
                                          leaveData.description, context),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  
                                  width:
                                      MediaQuery.of(context).size.width * 0.13,
                                  child: IconButton(
                                    iconSize: 25,
                                    onPressed: () {}, // No action needed here
                                    icon: PopupMenuButton<String>(
                                      icon: const Icon(Icons.more_vert),
                                      onSelected: (String value) {
                                        // Optional if further actions are needed after selection
                                      },
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          if (type == 'Tutor')
                                            PopupMenuItem(
                                              value: 'Edit',
                                              child: ListTile(
                                                leading: const Icon(Icons.edit),
                                                title: const Text('Edit'),
                                                onTap: () {
                                                    Navigator.pop(context); // Close the popup first
                                                                Get.to(EditAnnouncementScreen(
                                                     data: leaveData,
                                                  ));
                                                },
                                              ),
                                            ),
                                          PopupMenuItem(
                                            value: 'Delete',
                                            child: ListTile(
                                              leading: const Icon(Icons.delete),
                                              title: const Text('Delete'),
                                              onTap: () {
                                                Navigator.pop(context);
                                                 _showConfirmationDialog(
                                                    context, leaveData.batchDetails!.sId!,leaveData.courseDetails!.sId,leaveData.announcementId);
                                              },
                                            ),
                                          ),
                                        ];
                                      },
                                    ),
                                  ),
                                ),
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
            ? SingleCustomButtom(
                btnName: 'Add Announcement',
                isPadded: false,
                onTap: () {
                  anoumentController.navigateToAddBatchScreen();
                },
              )
            : SizedBox.shrink());
  }

  Widget _buildRow(String title, String? value, BuildContext context) {
    final displayValue =
        title == 'Fees' ? '₹ ${value ?? 'N/A'} /month' : value ?? 'N/A';

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
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Text(
            displayValue,
            maxLines: 3,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
    );
  }

   void _showConfirmationDialog(BuildContext context, String batchId,courseId,announcementId) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialogBox(
          title1: 'Do you want to delete this announcement?',
          title2: '',
          subtitle: 'Do you want to delete this announcement?',
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
            anoumentController.deleteAnnouncement(context, batchId,courseId,announcementId);
            // classController.tabController.animateTo(1);
            // classController.handleTabChange(1);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
