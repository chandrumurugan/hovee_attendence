import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  var homeDashboardNavList = <NavbarItems>[].obs;
  var batchList = <Datum>[].obs;
  var selectedBatchIN = Rxn<Datum>();
  var isBatchSelected = false.obs;
   var studentDetails = <StudentDetails>[].obs;
   var homeDashboardCourseList = <CourseList?>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     fetchHomeDashboardTuteeList();
     //fetchGroupedEnrollmentByHostel();
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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      isLoading(true);
      var homeDashboardResponse = await WebService.fetchHomeDashboardList();
      if (homeDashboardResponse != null) {
        homeDashboardNavList.value = homeDashboardResponse.navbarItems!;
                studentDetails.value = homeDashboardResponse.studentDetails!;
        if (studentDetails!= null && studentDetails.isNotEmpty) {
          homeDashboardCourseList.value = studentDetails[0].courseList!;
           print("ghetting courseList==$homeDashboardCourseList");
          
        }
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
}