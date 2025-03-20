import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByHostelModel.dart';
import 'package:hovee_attendence/modals/getHostelAttendanceCalendarReportModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/Tutor/tutorsStudentAttendenceList.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByAttendance_model.dart';

class HostelAttendanceController extends GetxController {

  var selectedBatchIN = Rxn<Datum>();
  var batchList = <Datum>[].obs;

  var isLoading = true.obs;

  Datum? selectedBatch;
  var isBatchSelected = false.obs;
  String? batchname;
  var type = "".obs;
  var isLoadingList = false.obs;
    var holidayDatesTutor = <DateTime>{}.obs;
     var leaveDatesTutor = <DateTime>{}.obs;
     Data? data;
      var attendanceData = <AttendanceData>[].obs;
      var isCalendarVisible = false.obs;
        List<AttendanceData> defaultData = [
    AttendanceData(
      category: 'No Data',
      percentage: 100, // Fill up the chart
      pointColor: Colors.grey, // Default grey color
    ),
    AttendanceData(
      category: 'No Data',
      percentage: 100, // Fill up the chart
      pointColor: Colors.grey, // Default grey color
    ),
    AttendanceData(
      category: 'No Data',
      percentage: 100, // Fill up the chart
      pointColor: Colors.grey, // Default grey color
    ),
    AttendanceData(
      category: 'No Data',
      percentage: 100, // Fill up the chart
      pointColor: Colors.grey, // Default grey color
    ),
  ];
  var focusedDay = DateTime.now().obs;
   var selectedDay = DateTime.now().obs;
    var missPunchDates = <DateTime>{}.obs;
var absentDates = <DateTime>{}.obs;
var presentDates = <DateTime>{}.obs;
var leaveDates = <DateTime>{}.obs;
var holidayDates = <DateTime>{}.obs;
 CalendarReportData? calendarReportData;
 String? presentDate;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final args = Get.arguments ?? "Tutee";
    type.value=args;
    batchname=args;
    print(batchname);
    fetchBatch();
  }

    void fetchBatch() async {
  isLoading(true);
  try {
    var response = await WebService.fetchGroupedEnrollmentByHostel();
    Logger().i(response);
    if (response != null && response.data != null) {
      batchList.clear();
      batchList.addAll(response.data!);
      
      // If the batch list is not empty, try to find a batch that matches the batchname
      if (batchList.isNotEmpty) {
        // Try to find the batch by name
        final matchedBatch = batchList.firstWhere(
          (batch) => batch.hostelListDetails!.hostelName == batchname,
          orElse: () => batchList.first,
        );

        if (matchedBatch != null) {
          selectedBatchIN.value = matchedBatch;
          isBatchSelected.value = true;
        } else {
          // Set the first item in the list if no match found
          selectedBatchIN.value = batchList.first;
          isBatchSelected.value = true;
        }

        String currentMonth = DateFormat('MMM').format(DateTime.now());
        Logger().i("type==>${type.value}");
        fetchStudentsList(selectedBatchIN.value!.hostelListDetails!.id!, '', currentMonth);
        // if (type.value == 'Tutor') {
        //   //fetchStudentsList(selectedBatchIN.value!.hostelListDetails!.id!, '', currentMonth);
        // } else {
        //   //fetchTutteAttendanceList(selectedBatchIN.value!.hostelListDetails!.id!, '', currentMonth);
        // }
      }
      Logger().i(batchList.length);
      isLoading(false);
    }
  } catch (e) {
    isLoading(false);
    print(e);
  }
}

// void fetchStudentsList(
//       String batchId, String selectedDate, selectedMonth) async {
//         Logger().i("gettingh values==2345678==${batchId} -- ${selectedDate} -- ${selectedMonth}");
//     try {
//       isLoadingList(true);
//       var groupedEnrollmentByBatchResponse =
//           await WebService.fetchgetGroupedEnrollmentByAttendance(
//               batchId, selectedDate, selectedMonth,type.value);
//       if (groupedEnrollmentByBatchResponse!.data != null) {
//         data = groupedEnrollmentByBatchResponse.data!; 
//         attendanceData.value = [
//           AttendanceData(
//               category: "All",
//               percentage: data!.totalRecords!.toDouble(),
//               pointColor: const Color(0xff014EA9)),
//           AttendanceData(
//               category: "Present",
//               percentage: data!.totalPresent!.toDouble(),
//               pointColor: const Color(0xffF07721)),
//           AttendanceData(
//               category: "Absent",
//               percentage: data!.totalAbsent!.toDouble(),
//               pointColor: const Color(0xffAD0F60)),
//           AttendanceData(
//               category: "Partial\nAttendance",
//               percentage: data!.totalMisspunch!.toDouble(),
//               pointColor: Color(0xff2E5BB5)),
//         ];

//          // calendar Report
//         var hostelAttendanceCalendarReportResponse =
//           await WebService.getHostelAttendanceCalendarReport(
//               batchId, selectedDate, selectedMonth,type.value);
//         if (hostelAttendanceCalendarReportResponse!.data != null) {
//           calendarReportData =hostelAttendanceCalendarReportResponse.data!;
//         final parsedDate = DateFormat('dd-MM-yyyy').parse(calendarReportData!.attendanceByDate!.date!);
//     presentDates.value = {DateTime(parsedDate.year, parsedDate.month, parsedDate.day)};
//         }else{

//         }
//          update();
//       }
//     } catch (e) {
//       print(e);
//     } finally {
//       isLoadingList(false);
//     }
//   }

void fetchStudentsList(String batchId, String selectedDate, String selectedMonth) async {
  Logger().i("Getting values: batchId=$batchId, selectedDate=$selectedDate, selectedMonth=$selectedMonth");

  try {
    isLoadingList(true);

    // Determine fromDate and toDate
    String fromDate = "";
    String toDate = "";

    if (selectedDate.isNotEmpty) {
      // Case: A specific date is selected
      fromDate = selectedDate;
      toDate = selectedDate;
    } else {
      // Case: A whole month is selected
      DateTime now = DateTime.now();
      DateTime firstDayOfMonth = DateTime(focusedDay.value.year, focusedDay.value.month, 1);
      DateTime lastDayOfMonth = DateTime(focusedDay.value.year, focusedDay.value.month + 1, 0);

      fromDate = DateFormat('dd-MM-yyyy').format(firstDayOfMonth);
      toDate = DateFormat('dd-MM-yyyy').format(lastDayOfMonth);
    }

    Logger().i("FromDate: $fromDate, ToDate: $toDate");

    var groupedEnrollmentByBatchResponse = await WebService.fetchgetGroupedEnrollmentByAttendance(
      batchId, selectedDate, selectedMonth, type.value, fromDate, toDate
    );

    if (groupedEnrollmentByBatchResponse?.data != null) {
      data = groupedEnrollmentByBatchResponse!.data!;

      attendanceData.value = [
        AttendanceData(category: "All", percentage: data!.totalRecords!.toDouble(), pointColor: const Color(0xff014EA9)),
        AttendanceData(category: "Present", percentage: data!.totalPresent!.toDouble(), pointColor: const Color(0xffF07721)),
        AttendanceData(category: "Absent", percentage: data!.totalAbsent!.toDouble(), pointColor: const Color(0xffAD0F60)),
        AttendanceData(category: "Partial\nAttendance", percentage: data!.totalMisspunch!.toDouble(), pointColor: Color(0xff2E5BB5)),
      ];

      // Fetch calendar report
      var hostelAttendanceCalendarReportResponse = await WebService.getHostelAttendanceCalendarReport(
        batchId, selectedDate, selectedMonth, type.value,fromDate, toDate
      );

      if (hostelAttendanceCalendarReportResponse?.data != null) {
        calendarReportData = hostelAttendanceCalendarReportResponse!.data!;
        print('Attendance on : ${calendarReportData!.attendanceByDate!.date}');
      }

      update();
    }
  } catch (e) {
    print(e);
  } finally {
    isLoadingList(false);
  }
}


  
  void selectBatch(Datum batch) {
    selectedBatchIN.value = batch;
       String currentMonth = DateFormat('MMM').format(DateTime.now());
    //fetchTutteAttendanceList(selectedBatchIN.value!.hostelListDetails!.id!,'',currentMonth);
  }

   void setFocusedDay(DateTime date) {
    focusedDay.value = date;
    update();
  }

   void onMonthSelected(DateTime date) {
    // Format the selected date as required by the API, e.g., '01/11/2024'
   focusedDay.value = date;
    String monthAbbreviation = DateFormat('MMM').format(date);
    print(monthAbbreviation);
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    selectedDay.value = date;
    // Check if a batch is selected and fetch attendance
    if (selectedBatchIN.value != null) {
      fetchStudentsList(
          selectedBatchIN.value!.hostelListDetails!.id!, '', monthAbbreviation);
           update();
    }
  }

  void onDateSelected(DateTime date) {
    // Format the selected date as required by the API, e.g., '01/11/2024'
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    selectedDay.value = date;
    String monthAbbreviation = DateFormat('MMM').format(date);
    print(monthAbbreviation);
    // Check if a batch is selected and fetch attendance
    if (selectedBatchIN.value != null) {
      fetchStudentsList(
          selectedBatchIN.value!.hostelListDetails!.id!, formattedDate, monthAbbreviation);
    }
  }

}