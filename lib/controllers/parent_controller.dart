import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/modals/getHomeDashboardModel.dart';
import 'package:hovee_attendence/modals/getUserTokenList_model.dart';
import 'package:hovee_attendence/services/webServices.dart';

class ParentController extends GetxController {

 GlobalKey<ScaffoldState> tuteeScaffoldKey = GlobalKey<ScaffoldState>();
   var isLoading = true.obs;
   var homeDashboardNavList =<NavbarItems>[].obs;
   var homeDashboardCourseList =<CourseList?>[].obs;
   var studentDetails= <StudentDetails>[].obs;
    var notificationCount = 0.obs;

    final List<Map<String, dynamic>> parentMonitorList = [
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
      'title': 'Gps Tracking',
      'image': 'assets/tutorHomeImg/online-learning (2) 1 (1).png',
      'desc': 'Lorem Ipsum is simply dummy',
      'color': const Color.fromRGBO(126, 113, 255, 1).withOpacity(0.7)
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

  var userDetails= <UserId>[].obs;
   @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchHomeDashboardTuteeList();
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
      } 
    
      }
    } catch (e) {
      // Get.snackbar('Failed to fetch batches');
    } finally {
      isLoading(false);
    }
  }

    void getUserTokenList(BuildContext context, String parentId) async {
      isLoading.value = true;
      try {
        var batchData = {
        "parentId": parentId,
      };

        final getUserTokenListModel ? response =
            await WebService.getUserTokenList(batchData);

        if (response != null && response.statusCode == 200) {
          userDetails.value=response.data!.userId!;
        } else {
          // SnackBarUtils.showErrorSnackBar(
          //     context, response?.message ?? 'Failed to update Enquire');
        }
      } catch (e) {
        //SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
      } finally {
        isLoading.value = false;
      }
   
  }

}