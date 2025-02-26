import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/hostel_msp_controller.dart';
import 'package:hovee_attendence/controllers/msp_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/view/edit_msp_hostel_screen.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class HostelMspScreen extends StatelessWidget {
  final String type;
  final bool fromBottomNav;
  final String? firstname, lastname, wowid;
  HostelMspScreen(
      {super.key,
      required this.type,
      required this.fromBottomNav,
      this.firstname,
      this.lastname,
      this.wowid});
  final HostelMspController mspController = Get.put(HostelMspController());
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
              padding: EdgeInsets.only(top: 25, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Image.asset(
                        'assets/tuteeHomeImg/leave 1.png',
                        height: 35,
                        color: Colors.white,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: 8,
                      ),
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
                          type == 'Tutor'
                              ? 'Here, you can view and manage students missed attendance to maintain accurate records and ensure effective follow-ups.'
                              : 'Record any missed attendance here to ensure your schedule remains up-to-date and organized',
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
              'MSP list',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
          ),
          Obx(() {
            if (mspController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (mspController.mspDataList.value.isEmpty) {
              return Center(child: Text("No data found"));
            }
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: mspController
                        .mspDataList.value.length, // Number of items
                    itemBuilder: (context, index) {
                      final holidayData =
                          mspController.mspDataList.value[index];
                      DateTime dateTime = DateFormat("dd-MM-yyyy")
                          .parse(holidayData.date!.toString());
                      Logger().i("123456===>$dateTime");
                      String formattedDate =
                          DateFormat("ddMMMyy").format(dateTime);
                      Logger().i("0987654===>$formattedDate");
                      return Animate(
                        effects: [
                          SlideEffect(
                            begin: Offset(-1, 0), // Start from the left
                            end: Offset(0, 0), // End at the original position
                            curve: Curves.easeInOut,
                            duration: 500.ms, // Consistent timing for each item
                            delay: 100.ms * index, // Add delay between items
                          ),
                          FadeEffect(
                            begin: 0, // Start transparent
                            end: 1, // End opaque
                            duration: 500.ms,
                            delay: 100.ms * index,
                          ),
                        ],
                        child: Card(
                          color: Colors.white,
                          surfaceTintColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Image.asset(
                                          'assets/Ellipse 261.png',
                                          height: 70,
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              holidayData
                                                          .hostellerObjectId !=
                                                      null
                                                  ? Text(
                                                      '${holidayData.hostellerObjectId!.firstName!} ${holidayData.hostellerObjectId!.lastName!}',
                                                      style: GoogleFonts.nunito(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Colors.black))
                                                  : SizedBox.shrink(),
                                              SizedBox(height: 4),
                                              holidayData.hostelDetails != null
                                                  ? Text(
                                                      'Reqister no:${holidayData.hostelDetails!.registerNo!}',
                                                      style: GoogleFonts.nunito(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: Colors.black))
                                                  : SizedBox.shrink(),
                                              SizedBox(height: 4),
                                              Text('Date: ${holidayData.date!}',
                                                  style: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: Colors.black)),
                                              SizedBox(height: 4),
                                              Text(
                                                'Hostel name: ${holidayData.hostelDetails!.hostelName}',
                                                style: GoogleFonts.nunito(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                              SizedBox(height: 4),
                                              _buildRow('Status',
                                                  '${holidayData.status}'),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          width: 40,
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              IconButton(
                                                onPressed:
                                                    () {}, // No action needed here
                                                icon: PopupMenuButton<String>(
                                                  icon: Icon(Icons.more_vert),
                                                  onSelected: (String value) {
                                                    // Optional if further actions are needed after selection
                                                  },
                                                  itemBuilder:
                                                      (BuildContext context) {
                                                    return [
                                                      // Display "Edit" only for Tutee
                                                      if (type == 'Hosteller' &&
                                                          holidayData.status !=
                                                              'Accepted' &&
                                                          holidayData.status !=
                                                              'Rejected')
                                                        PopupMenuItem(
                                                          value: 'Edit',
                                                          child: ListTile(
                                                            leading: Icon(
                                                                Icons.edit),
                                                            title: Text('Edit'),
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context); // Close the popup first
                                                              Get.to(
                                                                EditMspHostelScreen(
                                                                  batchname: holidayData.hostelDetails!.hostelName!,
                                                                  date: holidayData.date!.toString(),
                                                                  reason: holidayData.reason!,
                                                                  id: holidayData.sId ?? '',
                                                                  batchEnd: holidayData.hostelDetails!.hostelTimingEnd!, hostelId: holidayData.hostelId! ?? '', hostelObjId: holidayData.hostelDetails!.hostelObjectId ?? '', hostellerObjId: holidayData.hostellerObjectId!.sId ?? '',
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),

                                                      PopupMenuItem(
                                                        value: 'Delete',
                                                        child: ListTile(
                                                          leading: Icon(
                                                              Icons.delete),
                                                          title: Text('Delete'),
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                            _showConfirmationDialogDelete(
                                                                context,
                                                                holidayData
                                                                    .sId!);
                                                          },
                                                        ),
                                                      ),
                                                    ];
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Divider(
                                      //height: 100,
                                      color: Colors.grey,
                                      thickness: 1,
                                      indent: 0,
                                      endIndent: 0,
                                    ),
                                    Text('Reason',
                                        style: GoogleFonts.nunito(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: Colors.black)),
                                    SizedBox(height: 8),
                                    Text(holidayData.reason!,
                                        style: GoogleFonts.nunito(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: Colors.black)),
                                  ],
                                ),
                                // holidayData.status != 'Accepted' && holidayData.status != 'Rejected'?
                                // Divider(
                                //   //height: 100,
                                //   color: Colors.grey,
                                //   thickness: 1,
                                //   indent: 0,
                                //   endIndent: 0,
                                // ):SizedBox(height: 8,),
                                // buildActionButtons(type,holidayData.status!,holidayData.sId!,context)
                              ],
                            ),
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

  Widget _buildRow(String title, String? value) {
    final displayValue =
        title == 'Fees' ? '₹ ${value ?? 'N/A'} /month' : value ?? 'N/A';

    // Determine the text color for the 'Status' row.
    Color textColor = Colors.black;
    if (title == 'Status') {
      switch (value?.toLowerCase()) {
        case 'accepted':
          textColor = Colors.green;
          break;
        case 'pending':
          textColor = Color(0XFF74788D);
          break;
        case 'rejected':
          textColor = Colors.red;
          break;
        default:
          textColor = Colors.black; // Default color if status is unknown
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: GoogleFonts.nunito(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.black)),
        Text(
          displayValue,
          style: TextStyle(
            color: title == 'Status' ? textColor : Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialogDelete(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
        final HostelMspController mspController = Get.put(HostelMspController());
        return CustomDialogBox(
          title1: 'Do you want to delete your misspunch request?',
          title2: '',
          subtitle: 'Do you want to delete your misspunch request?',
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
            mspController.deleteMSPHostel(context, id);
            // classController.tabController.animateTo(1);
            // classController.handleTabChange(1);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
