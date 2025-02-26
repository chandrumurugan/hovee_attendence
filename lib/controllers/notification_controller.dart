import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/enquir_controller.dart';
import 'package:hovee_attendence/controllers/enrollment_controller.dart';
import 'package:hovee_attendence/controllers/holiday_controller.dart';
import 'package:hovee_attendence/controllers/hostel_enquiry_controller.dart';
import 'package:hovee_attendence/controllers/hostel_enrollement_controller.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/modals/getNotification_model.dart';
import 'package:hovee_attendence/modals/getmarkedNotification_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_announcement_screen.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_enquiry_list.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_enrollment_screen.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_msp_screen.dart';
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
   final HostelEnrollementController hostelEnrollmentController =
        Get.put(HostelEnrollementController());

    var notificationCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize TabController with three tabs
    print("object");
    fetchNotificationsType();
     print("object1");
  }

  void fetchNotifications(String role, bool isRead) async {
    //  SharedPreferences prefs = await SharedPreferences.getInstance();
    // role = prefs.getString('Rolename') ?? '';
    isLoading(true);
    var batchData = {"role": role, "isRead ": false};
    var response = await WebService.getNotifications(batchData);
    if (response != null && response.statusCode == 200) {
      notificationList.value =response.data!;
      notificationCount.value=response.unreadCount!;
      isLoading(false);
    } else {
      notificationList.clear();
      isLoading(false);
    }
  }

  void fetchNotificationsType() async {
  isLoading(true);
    final storage = GetStorage();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    role = prefs.getString('Rolename') ?? '';
    if(role=='Hostel' || role=='Hosteller'){
  var response = await WebService.fetchHostelNotificationsType();
  if (response.isNotEmpty) {
    // Move "Announcements" to the last index
    if (response.contains("Announcement")) {
      response.remove("Announcement");
      response.add("Announcement");
    }
    categories.value = response;
    isLoading(false);
    filteredNotifications('Enquiry', role!, false);
    //filteredNotifications('Enrollment', role!, false);
  } else {
    isLoading(false);
  }
    }
    else{
      var response = await WebService.fetchNotificationsType();
  if (response.isNotEmpty) {
    // Move "Announcements" to the last index
    if (response.contains("Announcements")) {
      response.remove("Announcements");
      response.add("Announcements");
    }
    categories.value = response;
    isLoading(false);
    filteredNotifications('Enquiry', role!, false);
    //filteredNotifications('Enrollment', role!, false);
  } else {
    isLoading(false);
  }
    }
}


 

  void filteredNotifications(String type, String role, bool isRead) async {
    isLoading(true);
    var batchData = {"role": role, "type": type, "isRead ": false};
    if(role =='Hostel' || role =='Hosteller' ){
    var response = await WebService.getNotificationsHostel(batchData);
    if (response != null && response.statusCode == 200) {
      notificationList.value =response.data!;
     notificationCount.value=response.unreadCount!;
      isLoading(false);
    } else {
      notificationList.clear();
      isLoading(false);
    }

    }else{
      var response = await WebService.getNotifications(batchData);
    if (response != null && response.statusCode == 200) {
      notificationList.value =response.data!;
     // notificationCount.value=response.unreadCount!;
      isLoading(false);
    } else {
      notificationList.clear();
      isLoading(false);
    }
    }
  }

//   void fetchMarkedNotification(String notificationId, String type, String msgtype) async {
//   isLoading(true);
//   var batchData = {"notificationId": notificationId};
//   var response = await WebService.FetchMarkedNotification(batchData);
//   final storage = GetStorage();

//   if (response != null && response.statusCode == 200) {
//     notificationData.value = response.data!;

//     // Extract only the code using a regular expression
//     final message = notificationData.value!.message ?? "";
//     final regex = RegExp(r'\b\d{6}\b'); // Matches a 6-digit number
//     final match = regex.firstMatch(message);

//     if (match != null) {
//       otpController.text = match.group(0)!; // Store only the code in otpController
//       storage.write('otpCode', otpController.text); // Store OTP in GetStorage
//       print("Stored OTP: ${otpController.text}");
//     } else {
//       otpController.text = ""; // Handle if code is not found
//     }

//     isLoading(false);

//     if (msgtype == 'Enquiry') {
//       Get.off(() => Tutorenquirlist(type: role!, fromBottomNav: true,));
//     }  if (msgtype == 'Enrollment') {
//       enrollmentController.onInit();
//       Get.off(() => EnrollmentScreen(type: role!, fromBottomNav: true,));
//     }
//      if (msgtype == 'Leave') {
//       Get.off(() => TuteeLeaveScreen(type: role!, fromBottomNav: true,));
//     } 
//      if (msgtype == 'Miss Punch') {
//       Get.off(() => MspScreen(type: role!, fromBottomNav: true,));
//     } 
//       if (msgtype == 'Announcements') {
//       Get.off(() => AnnouncementScreen(type: role!,));
//     } 
//      if (msgtype == 'Holiday') {
//       if(role=='Tutor'){
//       Get.off(() => HolidayController());
//     } else{
//        Get.off(() => TuteeHolidayScreen(type: role!,));
//     }
//   } else {
//     notificationList.clear();
//     isLoading(false);
//   }
// }

//   }


void fetchMarkedNotification(String notificationId, String type, String msgtype) async {
  isLoading(true);
  var batchData = {"notificationId": notificationId};
  if(role =='Hostel' || role =='Hosteller' ){
  var response = await WebService.FetchMarkedNotificationHostel(batchData);
  final storage = GetStorage();

  if (response != null && response.statusCode == 200) {
    notificationData.value = response.data!;

    // Extract only the code using a regular expression
    final message = notificationData.value!.message ?? "";
     final head = notificationData.value!.head ?? "";
    final regex = RegExp(r'\b\d{6}\b'); // Matches a 6-digit number
    final match = regex.firstMatch(message);

    if (match != null) {
      otpController.text = match.group(0)!; // Store only the code in otpController
      storage.write('otpCode', otpController.text); // Store OTP in GetStorage
      print("Stored OTP: ${otpController.text}");
    } else {
      otpController.text = ""; // Handle if code is not found
    }

   // Extract tab_type from the response
    final tabType = notificationData.value!.tabType ?? ""; // Default to "0" if not found
       Logger().i("tabType: $tabType");
    // Navigate based on msgtype and pass only tabType
    if (msgtype == 'Enquiry' ||msgtype == 'enquiry') {
       Get.off(() => HostelEnquiryList(type: role!, fromBottomNav: true,), arguments: tabType);
    } else if (msgtype == 'Enrollment' ||msgtype == 'enrollment') {
      Get.off(() => HostelEnrollmentScreen(type: role!, fromBottomNav: true,), arguments: tabType);
    } else if (msgtype == 'Leave') {
      Get.off(() => TuteeLeaveScreen(type: role!, fromBottomNav: true,));
    } else if (msgtype == 'MSP') {
      Get.off(() => HostelMspScreen(type: role!, fromBottomNav: true,));
    } else if (msgtype == 'Announcements'||msgtype == 'announcements' ) {
        Get.off(() => HostelAnnouncementScreen(type: role!,));
    } else if (msgtype == 'Holiday') {
      // if (role == 'Tutor') {
      //   Get.off(() => HolidayController());
      // } else {
      //   Get.off(() => TuteeHolidayScreen(type: role!,));
      // }
    }
  } else {
    notificationList.clear();
    isLoading(false);
  }
  }else{
    var response = await WebService.FetchMarkedNotification(batchData);
  final storage = GetStorage();

  if (response != null && response.statusCode == 200) {
    notificationData.value = response.data!;

    // Extract only the code using a regular expression
    final message = notificationData.value!.message ?? "";
     final head = notificationData.value!.head ?? "";
    final regex = RegExp(r'\b\d{6}\b'); // Matches a 6-digit number
    final match = regex.firstMatch(message);

    if (match != null) {
      otpController.text = match.group(0)!; // Store only the code in otpController
      storage.write('otpCode', otpController.text); // Store OTP in GetStorage
      print("Stored OTP: ${otpController.text}");
    } else {
      otpController.text = ""; // Handle if code is not found
    }

   // Extract tab_type from the response
    final tabType = notificationData.value!.tabType ?? ""; // Default to "0" if not found
       Logger().i("tabType: $tabType");
    // Navigate based on msgtype and pass only tabType
    if (msgtype == 'Enquiry') {
      Get.off(() => Tutorenquirlist(type: role!, fromBottomNav: true,), arguments: tabType);
    } else if (msgtype == 'Enrollment') {
      Get.off(() => EnrollmentScreen(type: role!, fromBottomNav: true,), arguments: tabType);
    } else if (msgtype == 'Leave') {
      Get.off(() => TuteeLeaveScreen(type: role!, fromBottomNav: true,));
    } else if (msgtype == 'MSP') {
      Get.off(() => MspScreen(type: role!, fromBottomNav: true,));
    } else if (msgtype == 'Announcements') {
      Get.off(() => AnnouncementScreen(type: role!,));
    } else if (msgtype == 'Holiday') {
      if (role == 'Tutor') {
        Get.off(() => HolidayController());
      } else {
        Get.off(() => TuteeHolidayScreen(type: role!,));
      }
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
}
