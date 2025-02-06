import 'dart:convert';
import 'dart:typed_data';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/components/tutorHomeComponents.dart';
import 'package:hovee_attendence/controllers/notification_controller.dart';
import 'package:hovee_attendence/modals/getDashboardYearFlow_model.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByBatch_model.dart';
import 'package:hovee_attendence/modals/getHomeDashboardModel.dart';
import 'package:hovee_attendence/modals/getQrcode_model.dart';
import 'package:hovee_attendence/modals/userProfile_modal.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorHomeController extends GetxController {
  GlobalKey<ScaffoldState> tutorScaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> monitor = [
    // {
    //   'title': 'Institute',
    //   'image': 'assets/tutorHomeImg/leave 1.png',
    //   'desc': 'Lorem Ipsum is simply dummy ',
    //   'color': const Color.fromRGBO(240, 119, 33, 1)
    // },

    {
      'title': 'Attendance',
      'image': 'assets/tutorHomeImg/calendar (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(186, 1, 97, 1)
    },
    {
      'title': 'Batches',
      'image': 'assets/tutorHomeImg/classroom 1 (1).png',
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
      'title': 'Classes',
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
    //     {
    //   'title': 'Teacher',
    //   'image': 'assets/tutorHomeImg/teacher (2) 1.png',
    //   'desc': 'Lorem Ipsum is simply dummy ',
    //   'color': const Color.fromRGBO(81, 2, 112, 1)
    // },

    {
      'title': 'Leave',
      'image': 'assets/tutorHomeImg/leave 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(126, 113, 255, 1)
    },
    {
      'title': 'MSB',
      'image': 'assets/tutorHomeImg/online-learning (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(100, 155, 80, 1)
    },
    {
      'title': 'Holiday',
      'image': 'assets/tutorHomeImg/holiday 1 (1).png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(186, 1, 97, 1)
    },
    {
      'title': 'Annoucement',
      'image': 'assets/tutorHomeImg/online-learning (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromARGB(255, 240, 75, 226)
    },
  ];
  var token = GetStorage();

  var isLoading = true.obs;

  var qrcodeImage;

  Uint8List? qrcodeImageData;

  var batchList = <Data1>[].obs;

  var selectedBatchIN = Rxn<Data1>();

  var isBatchSelected = false.obs;
  var isMonthSelected = true.obs;
  //Data? data;
  final ValueNotifier<List<ChartData>> chartData = ValueNotifier([]);
  final ValueNotifier<List<ChartData1>> chartData1 = ValueNotifier([]);
  final ValueNotifier<bool> isLoading1 = ValueNotifier(false);
  var dailyattendance = Rxn<Dailyattendance>();
   var homeDashboardNavList =<NavbarItems>[].obs;
   String? currentMonthYear;
    var userProfileResponse = UserProfileM().obs;
    var notificationCount = 0.obs;
     var wowId;
     final NotificationController noticontroller = Get.put(NotificationController());
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Logger().i(token.read('Token') ?? "");
    fetchUserProfiles();
    fetchQrCodeImage();
    fetchGroupedEnrollmentByBatchListItem();
    fetchHomeDashboardTuteeList();
    noticontroller.fetchNotifications('Tutor',false);
  }

    void fetchUserProfiles() async {
    final storage = GetStorage();
    isLoading(true);
    try {
      UserProfileM? fetchProfile = await WebService.fetchUserProfile();
      if (fetchProfile != null) {
        userProfileResponse.value = fetchProfile;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('firstName', fetchProfile.data!.firstName!);
          prefs.setString('lastName', fetchProfile.data!.lastName!);
          prefs.setString('wowId', fetchProfile.data!.wowId!);
          prefs.setString('RoleType', fetchProfile.data!.rolesId!.roleName!);
         
        isLoading(false);
      } else {
        // SnackBarUtils.showErrorSnackBar(context, message)
        isLoading(false);
      }
    } catch (e) {
      print(e);
      isLoading(false);
    }
  }

  void selectBatch(Data1 batch) {
    selectedBatchIN.value = batch;
  }

  void fetchGroupedEnrollmentByBatchListItem() async {
    isLoading(true);
    try {
      // Call your API to fetch the data
      var response = await WebService.fetchGroupedEnrollmentByBatch();
      Logger().i(response);
      if (response != null && response.data != null) {
        batchList.clear();
        batchList.addAll(response.data!);
        // isLoading(false); // Add batches to the observable list
        if (batchList.isNotEmpty) {
          selectedBatchIN.value = batchList.first;
          fetchBatchList(selectedBatchIN.value!.batchId! );
          isBatchSelected.value = true;
          print(selectedBatchIN.value);
        }
      }
    } catch (e) {
      // Handle any errors
      isLoading(false);
      print('Error fetching batches: $e');
    } finally{
        isLoading(false);

    }
  }

  void fetchBatchList(String batchId) async {
    try {
      isLoading(true);
      var homeDashboardAttendanceResponse =
          await WebService.fetchHomeAttendanceList(batchId);

      if (homeDashboardAttendanceResponse?.data != null) {
        currentMonthYear = homeDashboardAttendanceResponse!.data!.currentMonthYear;
        var attendacemonth =
            homeDashboardAttendanceResponse.data!.attendacemonth;
        var attendaceyear = homeDashboardAttendanceResponse.data!.attendaceYrs;
        dailyattendance.value =
            homeDashboardAttendanceResponse.data!.dailyattendance ;

        if (attendacemonth != null) {
          chartData.value = attendacemonth.map((item) {
            return ChartData(
              x: item.month ?? '',
              y: (item.studentCount ?? 0).toDouble(),
            );
          }).toList();
        }

        if (attendaceyear != null) {
          chartData1.value = attendaceyear.map((item) {
            return ChartData1(
              x: (item.year ?? '').toString(),
              y: (item.studentCount ?? 0).toDouble(),
            );
          }).toList();
        }
      }
      Logger().i("${isLoading.value}");

  
    } catch (e) {
      print("Error: $e");
        isLoading(false);

    } finally {
      isLoading(false);
    }
  }

  void fetchQrCodeImage() async {
    try {
      isLoading(true);
      var qrcodeResponse = await WebService.fetchQrCode();
      print("API Response: ${qrcodeResponse.data}");
       SharedPreferences prefs = await SharedPreferences.getInstance();
      if (qrcodeResponse.data != null) {
        qrcodeImage = qrcodeResponse.data!.qrCode??'';
        wowId=qrcodeResponse.data!.wowId??'';
         prefs.setString('QRWowId', wowId?? '');
        try {
          qrcodeImage =
              qrcodeImage.replaceFirst(RegExp(r'data:image\/\w+;base64,'), '');

          if (qrcodeImage.isNotEmpty) {
            // Decode the base64 string to Uint8List
            qrcodeImageData = base64Decode(qrcodeImage);
            print("Decoded QR Code Image Data: $qrcodeImageData");
            print("WowID Data: $wowId");
          } else {
            print("Error: Base64 QR Code string is empty.");
          }
        } catch (e) {
          print("123456667777==>$e");
        }
        // Remove potential metadata prefix
      } else {
        print("Error: qrcodeResponse.data is null.");
      }
    } catch (e) {
      print("Exception caught: $e");
    } finally {
      isLoading(false);
    }
  }

  void fetchHomeDashboardTuteeList() async {
    try {
      isLoading(true);
      var homeDashboardResponse = await WebService.fetchHomeDashboardList();
      print(homeDashboardResponse.navbarItems!.length);
      if (homeDashboardResponse != null) {
        homeDashboardNavList.value = homeDashboardResponse.navbarItems!;
      //   studentDetails.value=homeDashboardResponse.studentDetails!;
      //   // Extracting notification count
      // //var studentDetails = homeDashboardResponse!.studentDetails;
      // if (studentDetails.value != null && studentDetails.value.isNotEmpty) {
      //   // Getting the unreadNotificationCount of the first student
      //   homeDashboardCourseList.value = studentDetails[0].courseList!;
      //   print('hi rahul $notificationCount');
      // } 
      print(homeDashboardNavList.value);
    
      }
    } catch (e) {
      // Get.snackbar('Failed to fetch batches');
    } finally {
      isLoading(false);
    }
  }
}
