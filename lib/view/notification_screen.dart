import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/notification_controller.dart';
import 'package:hovee_attendence/controllers/tuteeHome_controllers.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';
import 'package:hovee_attendence/widget/cateory_widget.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final NotificationController controller = Get.put(NotificationController());
   final TuteeHomeController attendanceCourseListController = Get.put(TuteeHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            Get.back();
             attendanceCourseListController.onInit();
          }),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "My Notification",
              style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
            const SizedBox(height: 10),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.notificationList.isEmpty) {
                // Display "No data found" when the list is empty
                return Center(
                  child: Text(
                    'No notification list',
                    style: GoogleFonts.nunito(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                );
              } else {
                // Display the list of batches
                return CategoryList(
                categories: controller.categories,
                selectedIndex: controller.selectedIndex.value,
                onCategorySelected: (index) {
                  controller.setSelectedIndex(index);
                  controller.filteredNotifications(
                      controller.categories[index], controller.role!, false);
                },
                primaryColor: AppConstants.primaryColor, // .
              );
              }
            }),
                           Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.notificationList.isEmpty) {
                // Display "No data found" when the list is empty
                return Center(
                  child: Text(
                    'No notification found',
                    style: GoogleFonts.nunito(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                );
              } else {
                // Display the list of batches
                return ListView.builder(
                  itemCount: controller.notificationList.length,
                  itemBuilder: (context, index) {
                    final notification = controller.notificationList[index];
                    return GestureDetector(
                                      onTap: () {
                                        controller.fetchMarkedNotification(notification.sId!,notification.role!,notification.type!);
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 5),
                                          child: Card(
                                              elevation: 10,
                                              shadowColor: Colors.black,
                                              surfaceTintColor: Colors.white,
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  radius:
                                                      20, // Adjust size as needed
                                                  backgroundColor: Colors
                                                      .grey, // Customize color
                                                  child: Icon(
                                                    Icons
                                                        .person, // Customize icon if needed
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                                title: Text(
                                                  notification
                                                      .head!,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15),
                                                ),
                                                subtitle: Text(
notification                                                        .message!,
                                                    style: GoogleFonts.nunito(
                                                        color:
                                                            Color(0xff828282),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12)),
                                              ))));
                  },
                );
              }
            }),
          )
          ],
        ),
      ),
    );
  }
}
