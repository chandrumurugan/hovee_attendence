import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/enrollment_controller.dart';
import 'package:hovee_attendence/controllers/holiday_controller.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/modals/getNotification_model.dart';
import 'package:hovee_attendence/modals/getmarkedNotification_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';
import 'package:hovee_attendence/view/announcement_screen.dart';
import 'package:hovee_attendence/view/enrollment_screen.dart';
import 'package:hovee_attendence/view/leave_screen.dart';
import 'package:hovee_attendence/view/msp_screen.dart';
import 'package:hovee_attendence/view/tutee_holiday_screen.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  var categories =<String>[].obs;
  var selectedIndex = 0.obs;
  var notificationList =[].obs;
 var  notificationData
 = getMarkNotificationAsReadModel().data.obs;
  // final UserProfileController controller =
  //     Get.put(UserProfileController());

       String? role;

     final otpController = TextEditingController();
  final focusNode = FocusNode();

  var savedOtp;

   final EnrollmentController enrollmentController = Get.put(EnrollmentController());

    var notificationCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize TabController with three tabs
    print("object");
    fetchNotificationsType();
     print("object1");
  }

  // void fetchNotificationsType() async {
  //   isLoading(true);

  //   var response = await WebService.fetchNotificationsType();

  //   if (response.isNotEmpty) {
  //     categories.value= response;
  //     isLoading(false); 
  //      final storage = GetStorage();
  //     // role =storage.read('role');
  //      SharedPreferences prefs = await SharedPreferences.getInstance();
  //      role = prefs.getString('Rolename') ?? '';
  //     filteredNotifications('Announcements',role!,false);
  //   } else {
  //     isLoading(false);
  //   }
  // }

  void fetchNotificationsType() async {
  isLoading(true);

  var response = await WebService.fetchNotificationsType();

  if (response.isNotEmpty) {
    // Move "Announcements" to the last index
    if (response.contains("Announcements")) {
      response.remove("Announcements");
      response.add("Announcements");
    }

    categories.value = response;
    isLoading(false);

    final storage = GetStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    role = prefs.getString('Rolename') ?? '';
    filteredNotifications('Enquiry', role!, false);
  } else {
    isLoading(false);
  }
}


 

  void filteredNotifications(String type, String role, bool isRead) async {
    isLoading(true);
    var batchData = {"role": role, "type": type, "isRead ": false};
    var response = await WebService.getNotifications(batchData);
    if (response != null && response!.statusCode == 200) {
      notificationList.value =response.data!;
      notificationCount.value=response.unreadCount!;
      isLoading(false);
    } else {
      notificationList.clear();
      isLoading(false);
    }
  }

  void fetchMarkedNotification(String notificationId, String type, String msgtype) async {
  isLoading(true);
  var batchData = {"notificationId": notificationId};
  var response = await WebService.FetchMarkedNotification(batchData);
  final storage = GetStorage();

  if (response != null && response.statusCode == 200) {
    notificationData.value = response.data!;

    // Extract only the code using a regular expression
    final message = notificationData.value!.message ?? "";
    final regex = RegExp(r'\b\d{6}\b'); // Matches a 6-digit number
    final match = regex.firstMatch(message);

    if (match != null) {
      otpController.text = match.group(0)!; // Store only the code in otpController
      storage.write('otpCode', otpController.text); // Store OTP in GetStorage
      print("Stored OTP: ${otpController.text}");
    } else {
      otpController.text = ""; // Handle if code is not found
    }

    isLoading(false);

    if (msgtype == 'Enquiry') {
      Get.off(() => Tutorenquirlist(type: role!, fromBottomNav: true,));
    }  if (msgtype == 'Enrollment') {
      enrollmentController.onInit();
      Get.off(() => EnrollmentScreen(type: role!, fromBottomNav: true,));
    }
     if (msgtype == 'Leave') {
      Get.off(() => TuteeLeaveScreen(type: role!, fromBottomNav: true,));
    } 
     if (msgtype == 'Miss Punch') {
      Get.off(() => MspScreen(type: role!, fromBottomNav: true,));
    } 
      if (msgtype == 'Announcements') {
      Get.off(() => AnnouncementScreen(type: role!,));
    } 
     if (msgtype == 'Holiday') {
      if(role=='Tutor'){
      Get.off(() => HolidayController());
    } else{
       Get.off(() => TuteeHolidayScreen(type: role!,));
    }
  } else {
    notificationList.clear();
    isLoading(false);
  }
}

  }



    void setSelectedIndex(int index) {
      
    selectedIndex.value = index; // Update selected index
  }

//   void initializeOtpField() {
  
// }


}
