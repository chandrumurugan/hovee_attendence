import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/hostel_enquiry_controller.dart';
import 'package:hovee_attendence/services/modalServices.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';

class HostelEnquiryList extends StatelessWidget {
  final String type;
   final bool fromBottomNav;
  final String? firstname, lastname, wowid, lastWord;
  final VoidCallback? onDashBoardBack;
  final HostelEnquiryController controller;
   HostelEnquiryList({super.key, required this.fromBottomNav, this.firstname, this.lastname, this.wowid, this.lastWord, this.onDashBoardBack, required this.type}): controller = Get.put(HostelEnquiryController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await ModalService.handleBackButtonN(context);
      },
      child: Scaffold(
          appBar: AppBarHeader(
              needGoBack: fromBottomNav,
              navigateTo: () {
                if (fromBottomNav && onDashBoardBack != null) {
                  // Call onDashBoardBack if navigating from bottom navigation
                  onDashBoardBack!();
                } else {
                  // Navigate to Dashboard if not from bottom navigation
                  Get.offAll(DashboardScreen(
                    rolename: type,
                    firstname: firstname,
                    lastname: lastname,
                    wowid: wowid,
                  ));
                }
              }),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: Text(
                  'Enquiry list',
                  style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
              GetBuilder<HostelEnquiryController>(
                init: HostelEnquiryController(),
                builder: (controller) {
                  return TabBar(
                    controller: controller.tabController,
                    tabs: const [
                      Tab(text: 'Pending'),
                      Tab(text: 'Accepted'),
                      Tab(text: 'Rejected'),
                    ],
                    onTap: (value) {
                      controller.handleTabChange(value);
                    },
                  );
                },
              ),

              //Display List based on the selected tab
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (controller.enquirList.isEmpty) {
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
                      itemCount: controller.enquirList.length,
                      itemBuilder: (context, index) {
                        final hostelEnquiryList =
                            controller.enquirList[index];
                        return Animate(
                          effects: [
                            SlideEffect(
                              begin: Offset(-1, 0), // Start from the left
                              end: Offset(0, 0), // End at the original position
                              curve: Curves.easeInOut,
                              duration:
                                  500.ms, // Consistent timing for each item
                              delay: 100.ms * index, // Add delay between items
                            ),
                            FadeEffect(
                              begin: 0, // Start transparent
                              end: 1, // End opaque
                              duration: 500.ms,
                              delay: 100.ms * index,
                            ),
                          ],
                          child: GestureDetector(
                            onTap: () {
                              final storage = GetStorage();
                              String email = storage.read('email');
                              String phnno = storage.read('phoneNumber');

                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5),
                              child: Card(
                                elevation: 10,
                                shadowColor: Colors.black,
                                surfaceTintColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 30, // Adjust size as needed
                                            backgroundColor:
                                                Colors.grey, // Customize color
                                            child: Icon(
                                              Icons
                                                  .person, // Customize icon if needed
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                              width:
                                                  10), // Space between avatar and details
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                _buildRow(
                                                    'Hostel name',
                                                    hostelEnquiryList
                                                        .hostelLists!.hostelName ?? '',context),
                                                _buildRow(
                                                    'RegisterNo',
                                                    hostelEnquiryList
                                                        .hostelLists!.registerNo ?? '',context),
                                                _buildRow(
                                                    'Hostel categories',
                                                   hostelEnquiryList
                                                        .hostelLists!.registerNo ?? '',context),
                                                _buildRow(
                                                    'Status',
                                                    hostelEnquiryList
                                                        .status ?? '',context),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // Display "Accept" and "Reject" buttons outside the column
                                      if (controller
                                                  .selectedTabIndex.value ==
                                              0 &&
                                          type!= 'Hosteller')
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  _showConfirmationDialog(
                                                      context,
                                                      hostelEnquiryList);
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color(0xFFBA0161),
                                                        Color(0xFF510270)
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Accept",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                                width:
                                                    10), // Spacing between buttons
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  _showConfirmationDialog1(
                                                      context,
                                                      hostelEnquiryList);
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color(0xFFBA0161),
                                                        Color(0xFF510270)
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Reject",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                      if (controller
                                                  .selectedTabIndex.value ==
                                              1 &&
                                          type!= 'Hosteller')
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    gradient:
                                                        const LinearGradient(
                                                      colors: [
                                                        Color(0xFFBA0161),
                                                        Color(0xFF510270)
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Enroll now",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                                width:
                                                    10), // Spacing between buttons
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
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
          )),
    );
  }

    Widget _buildRow(String title, String? value,BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.black.withOpacity(0.4),
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width*0.2,
          child: Text(
            value ?? '',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog(
      BuildContext context, dynamic tutionCourseDetailsList) {
    Get.dialog(
      CustomDialogBox(
        title1: 'Would you like to accept this enquiry?',
        title2: '',
        subtitle: 'Do you want to accept this Enquiry?',
        icon: const Icon(Icons.help_outline, color: Colors.white),
        color: const Color(0xFF833AB4), // Set the primary color
        color1: const Color(0xFF833AB4), // Optional gradient color
        singleBtn: false, // Show both 'Yes' and 'No' buttons
        btnName: 'No',
        onTap: () {
          // Close the dialog when 'No' is clicked
          Get.back();
        },
        btnName2: 'Yes',
        onTap2: () {
          // Call the updateClass method when 'Yes' is clicked
          // controller.updateEnquire(
          //   context,
          //   tutionCourseDetailsList.enquiryId!,
          //   'Approved',
          // );
          // Close the dialog after update
          Get.back();
        },
      ),
      barrierDismissible:
          false, // Prevent closing the dialog by tapping outside
    );
  }

  void _showConfirmationDialog1(
      BuildContext context, dynamic tutionCourseDetailsList) {
    Get.dialog(
      CustomDialogBox(
        title1: 'Would you like to reject this enquiry?',
        title2: '',
        subtitle: 'Do you want to reject this Enquiry?',
        icon: const Icon(Icons.help_outline, color: Colors.white),
        color: const Color(0xFF833AB4), // Set the primary color
        color1: const Color(0xFF833AB4), // Optional gradient color
        singleBtn: false, // Show both 'Yes' and 'No' buttons
        btnName: 'No',
        onTap: () {
          // Close the dialog when 'No' is clicked
          Get.back();
        },
        btnName2: 'Yes',
        onTap2: () {
          // Call the updateClass method when 'Yes' is clicked
          // controller.updateEnquire(
          //   context,
          //   tutionCourseDetailsList.enquiryId!,
          //   'Rejected',
          // );
          controller.tabController.animateTo(2);
          // Close the dialog after update
          Get.back();
        },
      ),
      barrierDismissible: false, // Prevent accidental dismissal
    );
  }
}