import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByBatch_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:intl/intl.dart';

class TutorAttendanceController extends GetxController {
  // Reactive variables using Rx types
  var selectedBranchCode = Rxn<String>();
  var selectedSourceCode = Rxn<String>();
  var selectedBatch = Rxn<String>();
  var selectedDate = Rxn<DateTime>();
  final toggleValue = true.obs; // This is already reactive

  // List of options (will be dynamically updated)
  var batches = <String>[].obs;

  var isLoading = true.obs;
 var groupedEnrollmentByBatchList = <Data>[];

 var groupedEnrollmentAttendanceList = [];

 var focusedDay = DateTime.now().obs;
 var selectedDay = Rx<DateTime?>(null);
  var currentMonth = '';

  // Change _attendanceData to an RxMap for reactivity
  var attendanceData = <DateTime, String>{
    DateTime(2024, 3, 1): 'Present',
    DateTime(2024, 3, 5): 'Leave',
    DateTime(2024, 3, 7): 'Absent',
    DateTime(2024, 3, 10): 'Holiday',
    DateTime(2024, 3, 15): 'Miss punch',
    DateTime(2024, 3, 19): 'Leave Approved Pending',
    DateTime(2024, 4, 2): 'Present',
    DateTime(2024, 4, 4): 'Leave',
    DateTime(2024, 4, 6): 'Absent',
    DateTime(2024, 4, 8): 'Holiday',
    DateTime(2024, 4, 12): 'Miss punch',
    DateTime(2024, 4, 14): 'Leave Approved Pending',
  }.obs; // Make it reactive

  // Getter to access the attendance data
  RxMap<DateTime, String> get attendanceData1 => attendanceData;
  Map<String, int> attendanceSummary = {};

  @override
  void onInit() {
    super.onInit();
    fetchGroupedEnrollmentByBatch();
  }

  // Function to fetch grouped enrollment by batch
  void fetchGroupedEnrollmentByBatch() async {
    try {
      isLoading(true);
      var groupedEnrollmentByBatchResponse = await WebService.fetchGroupedEnrollmentByBatch();
      if (groupedEnrollmentByBatchResponse!.data != null) {
        groupedEnrollmentByBatchList = groupedEnrollmentByBatchResponse.data!;
        
        // Update batches list based on the API response
        batches.value = groupedEnrollmentByBatchList
            .map((batch) => batch.batchName as String) // Assuming 'batchName' is the field you want to display
            .toList();

            print(batches.value);
      }
    } catch (e) {
      // Handle error, for example:
      //Get.snackbar('Error', 'Failed to fetch batches');
    } finally {
      isLoading(false);
    }
  }

  void onMonthChange(DateTime focusedDay) {
  
      focusedDay = focusedDay;
      currentMonth = DateFormat('MMMM yyyy').format(focusedDay);
      updateAttendanceSummary(focusedDay);
  }

   void updateAttendanceSummary(DateTime month) {
    Map<String, int> summary = {
      'Present': 0,
      'Leave': 0,
      'Absent': 0,
      'Holiday': 0,
      'Miss punch': 0,
      'Leave Approved Pending': 0,
    };

    attendanceData.forEach((key, value) {
      if (key.month == month.month && key.year == month.year) {
        summary[value] = summary[value]! + 1;
      }
    });
      attendanceSummary = summary;
   
  }

   void fetchGroupedEnrollmentByBatchList(String batchId) async {
    try {
      isLoading(true);
      var groupedEnrollmentByBatchResponse = await WebService.fetchGroupedEnrollmentByBatchList(batchId);
      if (groupedEnrollmentByBatchResponse!.data != null) {
        groupedEnrollmentAttendanceList = groupedEnrollmentByBatchResponse.data!;
      }
    } catch (e) {
      // Handle error, for example:
      //Get.snackbar('Error', 'Failed to fetch batches');
    } finally {
      isLoading(false);
    }
  }

}
