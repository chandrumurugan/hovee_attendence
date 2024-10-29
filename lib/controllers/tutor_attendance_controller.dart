import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByAttendance_model.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByBatch_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class TutorAttendanceController extends GetxController {
  // Reactive variables using Rx types
  var selectedBranchCode = Rxn<String>();
  var selectedSourceCode = Rxn<String>();
  var selectedBatch = Rxn<String>();
  var selectedDate = Rxn<DateTime>();


   var selectedBatchStartDateq = Rxn<DateTime>(); // Start date for the selected batch
  var selectedBatchEndDateq = Rxn<DateTime>(); 
  final toggleValue = true.obs; // This is already reactive

  // List of options (will be dynamically updated)

  //new development
  var batches = <String>[].obs;
   var selectedBatchIN = Rxn<Data1>();
   var batchList = <Data1>[].obs;



  var isLoading = true.obs;
 var groupedEnrollmentByBatchList = <Data1>[];
 Data? data;



// Attendance-related variables
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
  }.obs;

  // Reactive variables
  var focusedDay = DateTime.now().obs;
  var selectedDay = Rxn<DateTime>();
  var currentMonth = ''.obs;
  var attendanceSummary = <String, int>{}.obs;
 final Map<String, String> batchNameToIdMap = {};
 final Map<String, String> batchNameToIdMap1 = {};
  DateTime? selectedBatchStartDate,selectedBatchEndDate; // Add this property
  String? selectedDate1,selectedBatchId;
  @override
  void onInit() {
    super.onInit();
     currentMonth.value = DateFormat('MMMM yyyy').format(focusedDay.value);
    _updateAttendanceSummary(focusedDay.value);
    // fetchGroupedEnrollmentByBatch();
    fetchGroupedEnrollmentByBatchListItem();
  }

  // Function to handle month change
  void onMonthChange(DateTime focusedDay) {
    focusedDay = focusedDay;
    currentMonth.value = DateFormat('MMMM yyyy').format(focusedDay);
    _updateAttendanceSummary(focusedDay);
  }

  // Function to update attendance summary based on the selected month
  void _updateAttendanceSummary(DateTime month) {
    var summary = {
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

    attendanceSummary.value = summary;
  }

// void fetchGroupedEnrollmentByBatch() async {
//   try {
//     isLoading(true);
//     var groupedEnrollmentByBatchResponse = await WebService.fetchGroupedEnrollmentByBatch();
//     if (groupedEnrollmentByBatchResponse!.data != null) {
//       groupedEnrollmentByBatchList = groupedEnrollmentByBatchResponse.data!;

//       // Create a mapping of batch names to batch IDs
//       batchNameToIdMap.clear(); // Clear the previous map if needed
//       batches.value = [];
//       for (var batch in groupedEnrollmentByBatchList) {
//         batches.value.add(batch.batchName as String);
//         batchNameToIdMap[batch.batchName!] = batch.batchId!; // Store the mapping
//         batchNameToIdMap1[batch.batchName!] = batch.startDate!;
//          focusedDay.value = DateFormat('dd/MM/yyyy').parse(batch.startDate!);
//       }

//       print(batches.value);
//     }
//   } catch (e) {
//     // Handle error, for example:
//     // Get.snackbar('Error', 'Failed to fetch batches');
//   } finally {
//     isLoading(false);
//   }
// }
void fetchGroupedEnrollmentByBatch() async {
  try {
    isLoading(true);
    var groupedEnrollmentByBatchResponse = await WebService.fetchGroupedEnrollmentByBatch();
    if (groupedEnrollmentByBatchResponse!.data != null) {
      groupedEnrollmentByBatchList = groupedEnrollmentByBatchResponse.data!;

      // Create a mapping of batch names to batch IDs
      batchNameToIdMap.clear(); // Clear the previous map if needed
      batches.value = [];
      for (var batch in groupedEnrollmentByBatchList) {
        batches.value.add(batch.batchName as String);
     
        focusedDay.value = DateFormat('dd/MM/yyyy').parse(batch.startDate!);
      }

      // Set the first item as selectedBatch if there are any batches
      // if (batches.isNotEmpty) {
      //   selectedBatch.value = batches[0];  // Set the first batch as selected
   
     

      //   // Fetch grouped enrollment by batch list for the initially selected batch
      //   fetchGroupedEnrollmentByBatchList(selectedBatchId!, selectedDate1!);
      // }

      print(batches.value);
    }
  } catch (e) {
    // Handle error, for example:
    // Get.snackbar('Error', 'Failed to fetch batches');
  } finally {
    isLoading(false);
  }
}




//new developmebt
  void fetchGroupedEnrollmentByBatchListItem() async {
       isLoading(true);
    try {
      // Call your API to fetch the data
      var response = await WebService.fetchGroupedEnrollmentByBatch();
      Logger().i(response);
      if (response != null && response.data != null) {
        batchList.clear();
        batchList.addAll(response.data!); 
           isLoading(false);// Add batches to the observable list
      }
    } catch (e) {
      // Handle any errors
         isLoading(false);
      print('Error fetching batches: $e');
    }
  }

  void selectBatch(Data1 batch) {
    selectedBatchIN.value = batch; // Set the selected batch
    // Parse dates
    selectedBatchStartDateq.value = DateFormat('yyyy-MM-dd').parse(batch.startDate!); // Adjust format if needed
    selectedBatchEndDateq.value = DateFormat('yyyy-MM-dd').parse(batch.endDate!); // Adjust format if needed
  }


   void fetchGroupedEnrollmentByBatchList(String batchId,String selectedDate ) async {
    try {
      isLoading(true);
      var groupedEnrollmentByBatchResponse = await WebService.fetchGroupedEnrollmentByBatchList(batchId,selectedDate);
      if (groupedEnrollmentByBatchResponse!.data != null) {
        data = groupedEnrollmentByBatchResponse.data!;
        
      }
    } catch (e) {
      // Handle error, for example:
      //Get.snackbar('Error', 'Failed to fetch batches');
    } finally {
      isLoading(false);
    }
  }

  String formatPunchInTime(String punchInTime) {
  // Parse the time string
  DateTime dateTime = DateTime.parse(punchInTime);
  // Format it to "hh:mm:ss a"
  String formattedTime = DateFormat('hh:mm:ss a').format(dateTime);
  return formattedTime;
}


}
