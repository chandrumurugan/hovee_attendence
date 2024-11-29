

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/enrollment_controller.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/modals/getHomeDashboardModel.dart';
import 'package:hovee_attendence/modals/getmarkedNotification_model.dart';
import 'package:hovee_attendence/services/firestoreService.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';
import 'package:hovee_attendence/view/enrollment_screen.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TuteeHomeController extends GetxController{
   GlobalKey<ScaffoldState> tuteeScaffoldKey = GlobalKey<ScaffoldState>();
    var attendanceCourseList = [].obs;
  var isLoading = true.obs;
   final List<Map<String, dynamic>> tuteeMonitorList = [
    // {
    //   'title': 'Enquiries',
    //   'image': 'assets/online-learning (1) 1.png',
    //   'desc': 'Lorem Ipsum is simply dummy',
    //   'color': const Color.fromRGBO(126, 113, 255, 1)
    // },
    {
      'title': 'Attendance',
      'image': 'assets/tuteeHomeImg/desktop-computer 1.png',
      'desc': 'Lorem Ipsum is simply dummy',
      'color': const Color.fromRGBO(240, 119, 33, 1)
    },
     {
      'title': 'Courses',
      'image': 'assets/tutorHomeImg/online-learning (2) 1 (1).png',
      'desc': 'Lorem Ipsum is simply dummy',
      'color': const Color.fromRGBO(126, 113, 255, 1).withOpacity(0.7)
    },
    {
      'title': 'Enquiries',
      'image': 'assets/tuteeHomeImg/online-learning (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(81, 2, 112, 1)
    },
    {
      'title': 'Enrollment',
      'image': 'assets/tuteeHomeImg/leave 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(240, 119, 33, 1)
    },
    {
      'title': 'Leave',
      'image': 'assets/tuteeHomeImg/calendar (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(186, 1, 97, 1)
    },
    {
      'title': 'MSP',
      'image': 'assets/tuteeHomeImg/teacher (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(126, 113, 255, 1)
    },
    {
      'title': 'Chat',
      'image': 'assets/tuteeHomeImg/leave 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(240, 119, 33, 1)
    },
    {
      'title': 'Fees',
      'image': 'assets/tuteeHomeImg/online-learning (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(81, 2, 112, 1)
    },
    {
      'title': 'Payments',
      'image': 'assets/tuteeHomeImg/online-learning (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(81, 2, 112, 1)
    },
  ];

  var homeDashboardNavList =<NavbarItems>[].obs;
   var homeDashboardCourseList =<CourseList?>[].obs;
   var studentDetails= <StudentDetails>[].obs;
 var categories =<String>[].obs;
  var selectedIndex = 0.obs;
  var notificationList =[].obs;
 var  notificationData
 = getMarkNotificationAsReadModel().data.obs;
  final UserProfileController controller =
      Get.put(UserProfileController());

       String? role;

     final otpController = TextEditingController();
  final focusNode = FocusNode();

  var savedOtp;

   final EnrollmentController enrollmentController = Get.put(EnrollmentController());

    var notificationCount = 0.obs; // Observable

   @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchHomeDashboardTuteeList();
    //fetchNotificationsType();
    fetchAttendanceCourseList();
     
  }

  // void fetchNotificationsType() async {
  //   isLoading(true);

  //   var response = await WebService.fetchNotificationsType();

  //   if (response.isNotEmpty) {
  //     categories.value= response;
  //     isLoading(false); 
  //     //  final storage = GetStorage();
  //     // role =storage.read('role');
  //      SharedPreferences prefs = await SharedPreferences.getInstance();
  //     role = prefs.getString('Rolename') ?? '';
  //     filteredNotifications('Enquiry',role!,false);
  //   } else {
  //     isLoading(false);
  //   }
  // }

 

//   void filteredNotifications(String type, String role, bool isRead) async {
//     isLoading(true);
//     var batchData = {"role": role, "type": type, "isRead ": false};
//     var response = await WebService.getNotifications(batchData);
//     if (response != null && response!.statusCode == 200) {
//       notificationList.value =response.data!;
//       notificationCount.value=response.unreadCount!;
//       isLoading(false);
//     } else {
//       notificationList.clear();
//       isLoading(false);
//     }
//   }

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
//     } else {
//       enrollmentController.onInit();
//       Get.off(() => EnrollmentScreen(type: role!, fromBottomNav: true,));
//     }
//   } else {
//     notificationList.clear();
//     isLoading(false);
//   }
// }



  //   void setSelectedIndex(int index) {
      
  //   selectedIndex.value = index; // Update selected index
  // }

    void fetchAttendanceCourseList() async {
    try {
      isLoading(true);
   
      var attendanceCourseResponse = await WebService.fetchAttendanceCourseList();
      if (attendanceCourseResponse.data != null) {
        attendanceCourseList.value = attendanceCourseResponse.data!;
      }
    } catch (e) {
      // Get.snackbar('Failed to fetch batches');
    } finally {
      isLoading(false);
    }
  }

   void fetchHomeDashboardTuteeList() async {
    try {
      isLoading(true);
      var homeDashboardResponse = await WebService.fetchHomeDashboardList();
      if (homeDashboardResponse != null) {
        homeDashboardNavList.value = homeDashboardResponse.navbarItems!;
        studentDetails.value=homeDashboardResponse.studentDetails!;
        // Extracting notification count
      //var studentDetails = homeDashboardResponse!.studentDetails;
      if (studentDetails.value != null && studentDetails.value.isNotEmpty) {
        // Getting the unreadNotificationCount of the first student
        homeDashboardCourseList.value = studentDetails[0].courseList!;
          await FirestoreService.updateUserLocation(
                    userId: studentDetails[0].wowId.toString() ?? "", username: "${studentDetails[0].firstName} ${studentDetails[0].lastName}");
        print('hi rahul $notificationCount');
      } 
    
      }
    } catch (e) {
      // Get.snackbar('Failed to fetch batches');
    } finally {
      isLoading(false);
    }
  }
  
}
