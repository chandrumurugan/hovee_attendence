import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/modals/getHomeDashboardModel.dart';
import 'package:hovee_attendence/modals/getUserTokenList_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentController extends GetxController {
  GlobalKey<ScaffoldState> tuteeScaffoldKey = GlobalKey<ScaffoldState>();
  var isLoading = true.obs;
  var homeDashboardNavList = <NavbarItems>[].obs;
  var homeDashboardCourseList = <CourseList?>[].obs;
  var studentDetails = <StudentDetails>[].obs;
  var notificationCount = 0.obs;
  var selectedIndex = 0.obs;

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
      'title': 'GPS Tracking',
      'image': 'assets/tuteeHomeImg/location (1).png',
      'desc': 'Lorem Ipsum is simply dummy',
      'color': const Color.fromRGBO(126, 113, 255, 1).withOpacity(0.7)
    },
    {
      'title': 'Enrollment',
      'image': 'assets/tuteeHomeImg/calendar (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(186, 1, 97, 1)
    },
    // {
    //   'title': 'MSP',
    //   'image': 'assets/tuteeHomeImg/teacher (1) 1.png',
    //   'desc': 'Lorem Ipsum is simply dummy ',
    //   'color': const Color.fromRGBO(126, 113, 255, 1)
    // },
    // {
    //   'title': 'Fees',
    //   'image': 'assets/tuteeHomeImg/online-learning (1) 1.png',
    //   'desc': 'Lorem Ipsum is simply dummy ',
    //   'color': const Color.fromRGBO(81, 2, 112, 1)
    // },
    // {
    //   'title': 'Payments',
    //   'image': 'assets/tuteeHomeImg/online-learning (1) 1.png',
    //   'desc': 'Lorem Ipsum is simply dummy ',
    //   'color': const Color.fromRGBO(81, 2, 112, 1)
    // },
  ];

  var userDetails = <UserId>[].obs;
  var userStoredData = <UserId>[].obs;
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
        studentDetails.value = homeDashboardResponse.studentDetails!;
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

  void getUserTokenList(String parentId) async {
    isLoading.value = true;
    try {
      var batchData = {
        "parentId": parentId,
      };

      // Fetch the data from the WebService
      final getUserTokenListModel? response =
          await WebService.getUserTokenList(batchData);

      if (response != null && response.statusCode == 200) {
        // Get the userId list from the response
        userDetails.value = response.data!.userId!;
        List<UserId>? userIds = response.data?.userId;

        if (userIds != null && userIds.isNotEmpty) {
          // Get the first UserId object (index 0)
          UserId firstUser = userIds[0];

          // Convert UserId object to JSON string
          String userJson = firstUser.toJson().toString();

          // Save the JSON string in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? userDataJson = prefs.getString('firstUserId');

          if (userDataJson != null) {
            // Decode the JSON string into a Map
            Map<String, dynamic> userMap = jsonDecode(userDataJson);

            // Retrieve the wowId and name from the Map
            String wowId = userMap['wowId'];
            String name = userMap['name'];
            String token = userMap['token '];
           prefs.setString('Token', token);
            // Debugging: Check if the values are retrieved correctly
            print('User ID: $wowId, User Name: $name');
          } else {
            print('No user data found in SharedPreferences');
          }

          // userDetails.value = firstUser.sId!;
        } else {
          // Handle empty userId list
          print('UserId list is empty');
        }
      } else {
        // Handle API failure or response error
        print('Failed to fetch user token list');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
