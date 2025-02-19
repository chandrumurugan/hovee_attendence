import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/widget/cateory_widget.dart';

class NotificationScreen extends StatelessWidget {
  final String type;
  final String? firstname,lastname,wowid;
  NotificationScreen({super.key, required this.type, this.firstname, this.lastname, this.wowid});
  final NotificationController attendanceCourseListController =
      Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    attendanceCourseListController.setSelectedIndex(0);
    return Scaffold(
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            Get.offAll(DashboardScreen(
              rolename: type,
              firstname:firstname ,lastname:lastname ,wowid: wowid,
            ));
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
              if (attendanceCourseListController.isLoading.value) {
                return const Center(child: SizedBox.shrink());
              } else if (attendanceCourseListController
                  .categories.isEmpty) {
                // Display "No data found" when the list is empty
                return const SizedBox.shrink();
              } else {
                // Display the list of batches
                return CategoryList(
                  categories: attendanceCourseListController.categories,
                  selectedIndex:
                      attendanceCourseListController.selectedIndex.value,
                  onCategorySelected: (index) {
                    attendanceCourseListController.setSelectedIndex(index);
                    attendanceCourseListController.filteredNotifications(
                        attendanceCourseListController.categories[index],
                        attendanceCourseListController.role!,
                        false);
                  },
                  primaryColor: AppConstants.primaryColor, // .
                );
              }
            }),
            Expanded(
              child: Obx(() {
                if (attendanceCourseListController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (attendanceCourseListController
                    .notificationList.isEmpty) {
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
                    itemCount:
                        attendanceCourseListController.notificationList.length,
                    itemBuilder: (context, index) {
                      final notification = attendanceCourseListController
                          .notificationList[index];
                      return Animate(
                        effects: [
                          SlideEffect(
                            begin: const Offset(-1, 0),
                            end: const Offset(0, 0),
                            curve: Curves.easeInOut,
                            duration: 500.ms,
                            delay: 100.ms * index,
                          ),
                          FadeEffect(
                            begin: 0,
                            end: 1,
                            duration: 500.ms,
                            delay: 100.ms * index,
                          ),
                        ],
                        child: GestureDetector(
                            onTap: () {
                              attendanceCourseListController
                                  .fetchMarkedNotification(notification.sId!,
                                      notification.role!, notification.type!);
                            },
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5),
                                child: Card(
                                    elevation: 10,
                                    shadowColor: Colors.black,
                                    surfaceTintColor: notification.isRead?   Colors.white:AppConstants.secondaryColor.withOpacity(0.5)
                              ,
                                    child: ListTile(
                                      leading: const CircleAvatar(
                                        radius: 20, // Adjust size as needed
                                        backgroundColor:
                                            Colors.grey, // Customize color
                                        child: Icon(
                                          Icons
                                              .person, // Customize icon if needed
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                      title: Text(
                                        notification.head!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15),
                                      ),
                                      subtitle: Text(notification.message!,
                                          style: GoogleFonts.nunito(
                                              color: const Color(0xff828282),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12)),
                                    )))),
                      );
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
