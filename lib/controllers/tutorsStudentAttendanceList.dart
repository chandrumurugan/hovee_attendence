import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByAttendanceTutee_model.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByAttendance_model.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByBatch_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/Tutor/tutorsStudentAttendenceList.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class StudentAttendanceController extends GetxController {
  var batches = <String>[].obs;
  var selectedBatchIN = Rxn<Data1>();
  var batchList = <Data1>[].obs;

  var isLoading = true.obs;
  var isLoadingList = false.obs;

    var selectedBatchStartDate = Rxn<DateTime>(); // Start date for the selected batch
  var selectedBatchEndDate = Rxn<DateTime>(); 
    var focusedDay = DateTime.now().obs;
    var selectedDay = DateTime.now().obs;

      Data? data;
      TuteeData? dataTutee;

      var isBatchSelected = false.obs;
       var attendanceData = <AttendanceData>[].obs;
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

   String? type;
    StudentAttendanceController(this.type);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchBatch();
    selectedBatchStartDate.value = DateTime.now();
       selectedBatchStartDate.value = DateTime.now();
  }

  void fetchBatch() async {
    isLoading(true);
    try {
      var response = await WebService.fetchGroupedEnrollmentByBatch();
      Logger().i(response);
      if (response != null && response.data != null) {
        batchList.clear();
        batchList.addAll(response.data!);
        // Set the first item as the default value
      if (batchList.isNotEmpty) {
        selectedBatchIN.value = batchList.first;
        isBatchSelected.value = true;
        print(selectedBatchIN.value);
        String currentMonth = DateFormat('MMM').format(DateTime.now());
        if(type=='Tutor'){
         fetchStudentsList(selectedBatchIN.value!.batchId!, '', currentMonth);
        }
         fetchTutteAttendanceList(selectedBatchIN.value!.batchId!, '', currentMonth);
      }
        Logger().i(batchList.length);
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);
      print(e);
    }
  }

    void selectBatch(Data1 batch) {
    selectedBatchIN.value = batch; 
    // Parse dates
  selectedBatchStartDate.value = DateFormat('dd/MM/yyyy').parse(batch.startDate!);
    selectedBatchEndDate.value = DateFormat('dd/MM/yyyy').parse(batch.endDate!);
    
   // fetchTutteAttendanceList(selectedBatchIN.value!.batchId!,);
  }

    void setFocusedDay(DateTime date) {
    focusedDay.value = date;
  }


  void fetchStudentsList(String batchId,String selectedDate,selectedMonth)async{
    try {
      isLoadingList(true);
         var groupedEnrollmentByBatchResponse = await WebService.fetchGroupedEnrollmentByBatchList(batchId,selectedDate,selectedMonth);
        if (groupedEnrollmentByBatchResponse!.data != null){
            data   = groupedEnrollmentByBatchResponse.data!;
            attendanceData.value = [
              AttendanceData(category: "All", percentage: data!.statusCounts!.totalStudents!.toDouble(), pointColor: const Color(0xff014EA9)),
                AttendanceData(category: "Present", percentage: data!.statusCounts!.present!.toDouble(), pointColor: const Color(0xffF07721)),
                  AttendanceData(category: "Absent", percentage: data!.statusCounts!.totalStudents!.toDouble(), pointColor: const Color(0xffAD0F60)),
                    AttendanceData(category: "Partial\nAttendance", percentage: data!.statusCounts!.partialAttendance!.toDouble(), pointColor: Color(0xff2E5BB5)),

            ];
        }
   

    } catch (e) {
      print(e); 
    } finally{
       isLoadingList(false);
    }

  }

  void fetchTutteAttendanceList(String batchId,String selectedDate,selectedMonth)async{
    try {
      isLoadingList(true);
         var groupedEnrollmentByBatchResponse = await WebService.fetchTutteAttendanceList(batchId,selectedDate,selectedMonth);
        if (groupedEnrollmentByBatchResponse?.data != null){
            dataTutee = groupedEnrollmentByBatchResponse!.data;
            print(dataTutee);
            // attendanceData.value = [
            //   AttendanceData(category: "All", percentage: data!.statusCounts!.totalStudents!.toDouble(), pointColor: const Color(0xff014EA9)),
            //     AttendanceData(category: "Present", percentage: data!.statusCounts!.present!.toDouble(), pointColor: const Color(0xffF07721)),
            //       AttendanceData(category: "Absent", percentage: data!.statusCounts!.totalStudents!.toDouble(), pointColor: const Color(0xffAD0F60)),
            //         AttendanceData(category: "Partial\nAttendance", percentage: data!.statusCounts!.partialAttendance!.toDouble(), pointColor: Color(0xff2E5BB5)),

            // ];
        }
   

    } catch (e) {
      print(e); 
    } finally{
       isLoadingList(false);
    }

  }

  void onDateSelectedTutor(DateTime date) {
  // Format the selected date as required by the API, e.g., '01/11/2024'
  String formattedDate = DateFormat('dd/MM/yyyy').format(date);
   selectedDay.value = date;
   String monthAbbreviation = DateFormat('MMM').format(date);
           print(monthAbbreviation);
  // Check if a batch is selected and fetch attendance
  if (selectedBatchIN.value != null) {
    fetchStudentsList(selectedBatchIN.value!.batchId!, formattedDate,monthAbbreviation);
  }
}

 void onMonthSelectedTutor(DateTime date) {
  // Format the selected date as required by the API, e.g., '01/11/2024'
  String monthAbbreviation = DateFormat('MMM').format(date);
           print(monthAbbreviation);
   String formattedDate = DateFormat('dd/MM/yyyy').format(date);
   selectedDay.value = date;
  // Check if a batch is selected and fetch attendance
  if (selectedBatchIN.value != null) {
    fetchStudentsList(selectedBatchIN.value!.batchId!,formattedDate, monthAbbreviation);
  }
}

 void onDateSelectedTutee(DateTime date) {
  // Format the selected date as required by the API, e.g., '01/11/2024'
  String formattedDate = DateFormat('dd/MM/yyyy').format(date);
   selectedDay.value = date;
   String monthAbbreviation = DateFormat('MMM').format(date);
           print(monthAbbreviation);
  // Check if a batch is selected and fetch attendance
  if (selectedBatchIN.value != null) {
    fetchTutteAttendanceList(selectedBatchIN.value!.batchId!, formattedDate,monthAbbreviation);
  }
}

 void onMonthSelectedTutee(DateTime date) {
  // Format the selected date as required by the API, e.g., '01/11/2024'
  String monthAbbreviation = DateFormat('MMM').format(date);
           print(monthAbbreviation);
   String formattedDate = DateFormat('dd/MM/yyyy').format(date);
   selectedDay.value = date;
  // Check if a batch is selected and fetch attendance
  if (selectedBatchIN.value != null) {
    fetchTutteAttendanceList(selectedBatchIN.value!.batchId!,formattedDate, monthAbbreviation);
  }
}

}
