// controllers/batch_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/modals/addbatch_model.dart';
import 'package:hovee_attendence/modals/appConfigModal.dart';
import 'package:hovee_attendence/modals/deletebatch_model.dart';
import 'package:hovee_attendence/modals/getbatchlist_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/add_batch.dart';
import 'package:intl/intl.dart';

class BatchController extends GetxController {
  var batchList = [].obs;
  var isLoading = true.obs;
  RxBool initialLoad = true.obs;
  var branchShortNameController = ''.obs;
  var batchNameController = ''.obs;
var batchDaysController = "".obs;
  var batchTeacherController = ''.obs;
  var batchTimingController = ''.obs;
  var batchTimingEndController = ''.obs;
  var maxSlotsController = ''.obs;
  var modeController = ''.obs;
  var feesController = ''.obs;
  var monthController = ''.obs;
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final branchShortName = TextEditingController();

  final batchName = TextEditingController();

  final batchDayss = TextEditingController();

  final batchTeacher = TextEditingController();
  final batchTiming = TextEditingController();

  final batchTimingEnd = TextEditingController();

  final mode = TextEditingController();

  final fees = TextEditingController();

  final maxSlots = TextEditingController();

  final month = TextEditingController();

  var validationMessages = <String>[].obs;

  final List<String> teacher = ['Rahul', 'Rabbin', 'akalaya', 'annai'];
  List<String> batchDays = [];
  List<String> batchModes = [];
  Map<String, String> batchIdMap = {};
  List<String> batchName1 = [];
  
 RxList<String> selectedBatchDays = <String>[].obs;

  var selectedCourseDetails =
      Data2().obs; // Observable to store selected course details
  var courseList1 = <Data2>[].obs;

  var totalCount = 0.obs;
  var activeCount = 0.obs;
  var inactiveCount = 0.obs;

  var filteredBatchList = [].obs; // Filtered list for display
  var searchKey = ''.obs;
 UserProfileController accountController = Get.put(UserProfileController());
  // Method to fetch batch list
//   void fetchBatchList() async {o
//   try {
//     isLoading(true);
//     var batchResponse = await WebService.fetchBatchList();
//     if (batchResponse.data != null) {
//       batchList.value = batchResponse.data!;
//        totalCount.value = batchResponse.totalBatches ?? 0;
//         activeCount.value = batchResponse.activeBatches ?? 0;
//         inactiveCount.value = batchResponse.inactiveBatches ?? 0;
//       // Extract only batch names for the dropdown
//       batchName1 = batchResponse.data!.map((batch) => batch.batchName ?? '').toList();

//       // Map batch names to their IDs for later retrieval
//       batchIdMap = {
//         for (var batch in batchResponse.data!) batch.batchName ?? '': batch.sId ?? ''
//       };

//       // Store data in GetStorage if needed
//       final storage = GetStorage();
//       storage.write('batchList', batchResponse.data!.map((e) => e.toJson()).toList());
//     }
//   } catch (e) {
//     // Handle errors if needed
//   } finally {
//     isLoading(false);
//   }
// }



  void fetchBatchList({String searchTerm = '', String type = ''}) async {
  try {
    isLoading.value = true; // Start loading
    initialLoad.value=true;
    // Prepare the request payload
    final requestPayload = {
      'searchTerm': searchTerm,
    };

    // Fetch batch list from the API
    var batchResponse = await WebService.fetchBatchList(requestPayload);

    if (batchResponse.data != null) {
      batchList.value = batchResponse.data!;
      totalCount.value = batchResponse.totalBatches ?? 0;
      activeCount.value = batchResponse.activeBatches ?? 0;
      inactiveCount.value = batchResponse.inactiveBatches ?? 0;

      // Update batch names based on the type
      
        batchName1 = batchResponse.data!
            .map((batch) => batch.batchName ?? '')
            .toList();
      

      // Map batch names to their IDs for later retrieval
      batchIdMap = {
        for (var batch in batchResponse.data!)
          batch.batchName ?? '': batch.sId ?? ''
      };

      // Store data in GetStorage if needed
      final storage = GetStorage();
      storage.write(
          'batchList', batchResponse.data!.map((e) => e.toJson()).toList());
    } else {
      batchList.clear();
    }
  } catch (e) {
    batchList.clear(); // Clear the list on error
    print('Error fetching batch list: $e');
  } finally {
    isLoading.value = false; // Stop loading
     initialLoad.value=false;
  }
}



  void fetchBatchDetails(String batchName) {
    var batch = batchList.firstWhere(
      (c) => c.batchName == batchName,
      orElse: () => Data2(),
    );
    selectedCourseDetails.value = batch; // Update selected course details
  }

  void navigateToAddBatchScreen() {
    Get.to(() => TutorAddBatchScreen());
  }

  void navigateBack() {
    Get.back();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchBatchList();
    batchDays = getBatchDays();
    batchModes = getBatchModes();
    clearData();
  }

  bool validateFields(BuildContext context) {
    validationMessages.clear();
    // if (branchShortName.text.isEmpty) {
    //   SnackBarUtils.showErrorSnackBar(context, 'Branch short name is required');
    //   return false;
    // }
    if (batchName.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Batch name is required');
      return false;
    }
    // if (batchTeacherController.value.isEmpty) {
    //   SnackBarUtils.showErrorSnackBar(context, 'Batch teacher is required');
    //   return false;
    // }

    if (batchTiming.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Batch timing is required');
      return false;
    }
    if (batchTimingEnd.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Batch timing End is required');
      return false;
    }

    if (maxSlots.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Maximum slots are required');
      return false;
    }
    if (batchDaysController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Batch days is required');
      return false;
    }
    if (modeController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Mode is required');
      return false;
    }

    if (fees.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Fees is required');
      return false;
    }

     if (startDateController.text.isEmpty) {
      SnackBarUtils.showSuccessSnackBar(
        context,
        'Start Date is required',
      );
      return false;
    }
    if (endDateController.text.isEmpty) {
      SnackBarUtils.showSuccessSnackBar(
        context,
        'End date is required',
      );
      return false;
    }
    return true;
  }

  // Method to show time picker for start time
  Future<void> selectTime(BuildContext context,
      {required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime != null) {
      // Format the picked time to HH:mm:ss
      String formattedTime = DateFormat('HH:mm:ss').format(
        DateFormat.jm().parse(pickedTime.format(context).toString()),
      );

      // Update the appropriate RxString based on which time is being set
      if (isStartTime) {
        batchTimingController.value = formattedTime;
      } else {
        batchTimingEndController.value = formattedTime;
      }
    } else {
      print("Time is not selected");
    }
  }

  void addBatch(BuildContext context) async {
    if (validateFields(context)) {
      isLoading.value = true;
      try {
        var batchData = {
          // 'branch_short_name': branchShortName.text,
          'branch_short_name': '',
          'batch_name': batchName.text,
          'batch_teacher': batchTeacher.text,
          'batch_timing_start': batchTiming.text,
          'batch_timing_end': batchTimingEnd.text,
          'batch_maximum_slots': maxSlots.text,
          'batch_days': batchDaysController.value,
          'batch_mode': modeController.value,
          'fees': fees.text,
          'month': fees.text,
          "type": "N",
          "batchId": "",
           "start_date": startDateController.text,
          "end_date": endDateController.text,
        };

        final AddBatchDataModel? response =
            await WebService.addBatch(batchData);

        if (response != null && response.success == true) {
           batchDaysController.value = "";
          clearData();
           batchDaysController.value = "";
          SnackBarUtils.showSuccessSnackBar(
              context, 'Batch added successfully',);
          Get.back();
          // fetchBatchList();
          isLoading.value = true;
          onInit();
        } else {
          SnackBarUtils.showErrorSnackBar(
              context, response?.message ?? 'Failed to add batch');
        }
      } catch (e) {
        SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }

  List<String> getBatchDays() {
    final storage = GetStorage();
    final appConfigDataBatchdays = storage.read('appConfig');

    if (appConfigDataBatchdays != null) {
      final appConfig = AppConfig.fromJson(appConfigDataBatchdays);
      if (appConfig.data != null) {
        return appConfig.data!.batchDays!
            .map((item) => item.label ?? '')
            .toList();
      }
    }
    return [];
  }

  List<String> getBatchModes() {
    final storage = GetStorage();
    final appConfigDataBatchmodes = storage.read('appConfig');

    if (appConfigDataBatchmodes != null) {
      final appConfig = AppConfig.fromJson(appConfigDataBatchmodes);
      if (appConfig.data != null) {
        return appConfig.data!.batchMode!
            .map((item) => item.label ?? '')
            .toList();
      }
    }
    return [];
  }

  void setTeacher(String value) => batchTeacherController.value = value;
  void setBatchModes(String value) => modeController.value = value;
  void setBatchDays(String value) => batchDaysController.value = value;
  void setStartTiming(String value) => batchTimingController.value = value;
  void setEndingTiming(String value) => batchTimingEndController.value = value;

  void clearData() {
    batchName.clear();
    batchTeacherController.value = '';
    batchTiming.clear();
    batchTimingEnd.clear();
    maxSlots.clear();
    batchDaysController.value = "";
    modeController.value = '';
    fees.clear();
    selectedBatchDays.clear();
      startDateController.clear();
   endDateController.clear();
  }

  void filterBatchList() {
    if (searchKey.value.isEmpty) {
      // If search key is empty, show all batches
      filteredBatchList.assignAll(batchList);
    } else {
      // Filter batch list based on search key
      filteredBatchList.assignAll(
        batchList
            .where((batch) =>
                (batch.batchName
                        ?.toLowerCase()
                        .contains(searchKey.value.toLowerCase()) ??
                    false) ||
                (batch.batchTeacher
                        ?.toLowerCase()
                        .contains(searchKey.value.toLowerCase()) ??
                    false))
            .toList(),
      );
    }
  }

  void deleteBatch(BuildContext context, String batchId) async {
    isLoading.value = true;
    try {
      var batchData = {
        "batchId": batchId,
      };

      final deleteBatchDataModel? response =
          await WebService.deleteBatch(batchData);

      if (response != null && response.success == true) {
        clearData();
        fetchBatchList();
         Get.snackbar(icon: Icon(Icons.check_circle,color: Colors.white,size: 40,)
        ,'Batch delete successfully',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
        //SnackBarUtils.showSuccessSnackBar(context, 'Batch delete successfully');
        //  Get.back();
        //  onInit();
      } else {
         Get.snackbar(icon: Icon(Icons.info,color: Colors.white,size: 40,)
        ,'fail to delete batch',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
      }
    } catch (e) {
      SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateBatch(BuildContext context,String batchId) async {
    if (validateFields(context)) {
      isLoading.value = true;
      try {
        var batchData = {
          // 'branch_short_name': branchShortName.text,
          'branch_short_name': '',
          'batch_name': batchName.text,
          'batch_teacher': batchTeacherController.value,
          'batch_timing_start': batchTiming.text,
          'batch_timing_end': batchTimingEnd.text,
          'batch_maximum_slots': maxSlots.text,
          'batch_days': batchDaysController.value,
          'batch_mode': modeController.value,
          'fees': fees.text,
          'month': fees.text,
          "type": "U",
          "batchId": batchId,
          "institudeId": "",
          "institude_name": "",
          "teacherId": "",
           "start_date": startDateController.text,
          "end_date": endDateController.text,
        };

        final AddBatchDataModel? response =
            await WebService.addBatch(batchData);

        if (response != null && response.success == true) {
          clearData();
          SnackBarUtils.showSuccessSnackBar(
              context, 'Batch updated successfully');
          Get.back();
          onInit();
        } else {
          SnackBarUtils.showErrorSnackBar(
              context, response?.message ?? 'Failed to updated batch');
        }
      } catch (e) {
        SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
