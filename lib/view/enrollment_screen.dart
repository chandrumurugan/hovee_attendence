import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/enrollment_controller.dart';
import 'package:hovee_attendence/controllers/notification_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/search_filter_tabber.dart';
import 'package:hovee_attendence/view/home_screen/tutee_home_screen.dart';
import 'package:pinput/pinput.dart';

class EnrollmentScreen extends StatelessWidget {
  final String type;
  EnrollmentScreen({super.key, required this.type});
  final EnrollmentController controller = Get.put(EnrollmentController());
   final NotificationController notificontroller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
   final storage = GetStorage();
  final savedOtp = storage.read('otpCode') ?? '';
 notificontroller.otpController.text = savedOtp;
    return Scaffold(
      
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            Navigator.pop(context);
          }),
      body: Column(
        children: [
          // Search and Filter Section
           SearchfiltertabBar(
            title: 'Enrollment List',
            onSearchChanged: (searchTerm) {
            },
            filterOnTap: () {
              // Implement filter logic here if needed
            },
          ),
           
          // SearchfiltertabBar(
          //   title: 'Enrollment List',
          //   searchOnTap: () {},
          //   filterOnTap: () {},
          // ),
          // Tabs for Active and Inactive
          TabBar(
            controller: controller.tabController,
            tabs: [
              Tab(text: 'Pending'),
              Tab(text: 'Accepted'),
              Tab(text: 'Rejected'),
            ],
          ),
          // Display List based on the selected tab
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.enrollmentList.isEmpty) {
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
                  itemCount: controller.enrollmentList.length,
                  itemBuilder: (context, index) {
                    final enrollmentList = controller.enrollmentList[index];
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
                                    radius: 30,
                                    backgroundColor: Colors.grey,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        _buildRow('Tutee name', enrollmentList.tutorName),
                                        _buildRow('Start Date', enrollmentList.startDate),
                                        _buildRow('End Date', enrollmentList.endDate),
                                        _buildRow('Status', enrollmentList.status),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              // Display "Accept" and "Reject" buttons outside the column
                              if ((controller.selectedTabIndex.value == 0 && type == 'Tutee'))
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          _showOtpDialog(context, enrollmentList.sId!);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            gradient: LinearGradient(
                                              colors: [Color(0xFFBA0161), Color(0xFF510270)],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                          ),
                                          child: Text(
                                            "Submit",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunito(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          controller.updateEnrollment(enrollmentList.sId!, 'Rejected',enrollmentList.sId!);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            gradient: LinearGradient(
                                              colors: [Color(0xFFBA0161), Color(0xFF510270)],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                          ),
                                          child: Text(
                                            "Reject",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.nunito(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
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
          ),
        ],
      ),
    );
  }


void _showOtpDialog(BuildContext context, String enrollmentId) {
  final defaultPinTheme = PinTheme(
    width: 50,
    height: 38,
    textStyle: const TextStyle(
      fontSize: 22,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2),
      border: Border(right: BorderSide(color: Colors.grey.shade400)),
    ),
  );

  Get.dialog(
    AlertDialog(
      contentPadding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      content: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    'Acceptance code',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please enter the acceptance code to confirm your enrollment.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      length: 6,
                      controller: notificontroller.otpController,
                      focusNode: notificontroller.focusNode,
                      defaultPinTheme: defaultPinTheme,
                      separatorBuilder: (index) => const SizedBox(width: 8),
                      onCompleted: (pin) {
                        debugPrint('onCompleted: $pin');
                      },
                      onChanged: (value) {
                        debugPrint('onChanged: $value');
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 0),
                            width: 22,
                            height: 1,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              final otp = notificontroller.otpController.text;
              if (otp.isNotEmpty) {
                controller.updateEnrollment(enrollmentId, 'Approved', otp);
              controller. otpController.clear(); // Clear the OTP field
    GetStorage().remove('otpCode');
                 Get.offAll(TuteeHome());
              } else {
                Get.snackbar('Please enter OTP');
              }
            },
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFBA0161), Color(0xFF510270)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
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
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
        ),
      ],
    );
  }
}