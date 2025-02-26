import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/controllers/notification_controller.dart';
import 'package:hovee_attendence/modals/getEnrollmentDataModel.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByBatch_model.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByHostelModel.dart';
import 'package:hovee_attendence/modals/getHomeDashboardModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HostellerController extends GetxController with GetSingleTickerProviderStateMixin{

 GlobalKey<ScaffoldState> hostellerScaffoldKey = GlobalKey<ScaffoldState>();
  var isLoading = true.obs;
  var homeDashboardNavList = <NavbarItem>[].obs;
  var batchList = <Datum>[].obs;
  var selectedBatchIN = Rxn<Datum>();
  var isBatchSelected = false.obs;
 var enrollmentDetails = <EnrollmentDatum>[].obs;
   var homeDashboardHostelList = <HostelList?>[].obs;
   var homeDashboardHostelListDetails = <HostelListDetail?>[].obs;
     HostelObjectIdDetails? hostellerObjectIdDetails;
     HostelObjectIdDetails? hostelObjectIdDetails;
     var role=''.obs;
     var qrcodeImage;
     var wowId;
  Uint8List? qrcodeImageData;
  String? hostelId;
  final NotificationController noticontroller = Get.put(NotificationController());
  @override

  void onInit() {
    // TODO: implement onInit
    super.onInit();
     fetchHomeDashboardTuteeList();
     getRole();
  }

  getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    role.value = prefs.getString('Rolename') ?? '';
    update();
    noticontroller.filteredNotifications('', role.value, false);
  }

  void selectBatch(Datum batch) {
    selectedBatchIN.value = batch;
  }

  void makePhoneCall(String number) async {
    String phoneNumber = 'tel:+$number'; // Replace with your phone number
    // ignore: deprecated_member_use
    if (await canLaunch(phoneNumber)) {
      // ignore: deprecated_member_use
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

   void fetchHomeDashboardTuteeList() async {
    try {
      isLoading(true);
      var homeDashboardResponse = await WebService.fetchHomeDashboardHostelList();
      if (homeDashboardResponse != null) {
        homeDashboardNavList.value = homeDashboardResponse.navbarItems;
         enrollmentDetails.value = homeDashboardResponse.enrollmentData;
         homeDashboardHostelListDetails.value = homeDashboardResponse.hostelListDetails;
        if (enrollmentDetails.value != null && enrollmentDetails.value.isNotEmpty) {
          // Getting the unreadNotificationCount of the first student
          hostellerObjectIdDetails =enrollmentDetails[0].hostellerObjectIdDetails;
          hostelObjectIdDetails=enrollmentDetails[0].hostelObjectIdDetails;
          homeDashboardHostelList.value = enrollmentDetails[0].hostelList;
           
        hostelId = homeDashboardHostelList[0]!.id ?? '';
        Logger().i(hostelId);
      } 
      fetchQrCodeImage();
      }
    } catch (e) {
      // Get.snackbar('Failed to fetch batches');
    } finally {
      isLoading(false);
    }
  }

  // void fetchGroupedEnrollmentByHostel() async {
  //   isLoading(true);
  //   try {
  //     // Call your API to fetch the data
  //     var response = await WebService.fetchGroupedEnrollmentByHostel();
  //     Logger().i(response);
  //     if (response != null && response.data != null) {
  //       batchList.clear();
  //       batchList.addAll(response.data!);
  //       // isLoading(false); // Add batches to the observable list
  //       if (batchList.isNotEmpty) {
  //         selectedBatchIN.value = batchList.first;
  //         fetchHostelList(selectedBatchIN.value!.hostelListDetails!.id! );
  //         isBatchSelected.value = true;
  //         print(selectedBatchIN.value);
  //       }
  //     }
  //   } catch (e) {
  //     // Handle any errors
  //     isLoading(false);
  //     print('Error fetching batches: $e');
  //   } finally{
  //       isLoading(false);

  //   }
  // }

  // void fetchHostelList(String batchId) async {
  //   try {
  //     isLoading(true);
  //     var homeDashboardAttendanceResponse =
  //         await WebService.fetchHomeAttendanceList(batchId);

  //     if (homeDashboardAttendanceResponse?.data != null) {
  //       currentMonthYear = homeDashboardAttendanceResponse!.data!.currentMonthYear;
  //       var attendacemonth =
  //           homeDashboardAttendanceResponse.data!.attendacemonth;
  //       var attendaceyear = homeDashboardAttendanceResponse.data!.attendaceYrs;
  //       dailyattendance.value =
  //           homeDashboardAttendanceResponse.data!.dailyattendance ;

  //       if (attendacemonth != null) {
  //         chartData.value = attendacemonth.map((item) {
  //           return ChartData(
  //             x: item.month ?? '',
  //             y: (item.studentCount ?? 0).toDouble(),
  //           );
  //         }).toList();
  //       }

  //       if (attendaceyear != null) {
  //         chartData1.value = attendaceyear.map((item) {
  //           return ChartData1(
  //             x: (item.year ?? '').toString(),
  //             y: (item.studentCount ?? 0).toDouble(),
  //           );
  //         }).toList();
  //       }
  //     }
  //     Logger().i("${isLoading.value}");

  
  //   } catch (e) {
  //     print("Error: $e");
  //       isLoading(false);

  //   } finally {
  //     isLoading(false);
  //   }
  // }

  void fetchQrCodeImage() async {
    try {
      isLoading(true);
      var qrcodeResponse = await WebService.fetchHostelQrCode(hostelId ?? '');
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
}