// controllers/batch_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/modals/addbatch_model.dart';
import 'package:hovee_attendence/modals/getbatchlist_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/add_batch.dart';
import 'package:intl/intl.dart';



class BatchController extends GetxController {
  var batchList = <Data>[].obs;
  var isLoading = true.obs;

  var branchShortNameController = ''.obs;
  var batchNameController = ''.obs;
  var batchDaysController = ''.obs;
  var batchTeacherController = ''.obs;
  var batchTimingController = ''.obs;
  var batchTimingEndController = ''.obs;
  var maxSlotsController = ''.obs;
  var modeController = ''.obs;
   var feesController = ''.obs;
  var monthController = ''.obs;

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
  
    final List<String> teacher = ['Rahul', 'Rabbin','akalaya','annai'];
     List<String> batchDays = ['Monday','Tuesday','Wednesday','Thursday','Friday'];
   List<String> batchModes = ['Online','Offline'];

  // Method to fetch batch list
  void fetchBatchList() async {
    try {
      isLoading(true);
      var batchResponse = await WebService.fetchBatchList();
      if (batchResponse.data != null) {
        batchList.value = batchResponse.data!;
      }
    } catch (e) {
      // Get.snackbar('Failed to fetch batches');
    } finally {
      isLoading(false);
    }
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
    print("object");
    fetchBatchList();
  }

  bool validateFields(BuildContext context) {
    validationMessages.clear();

         print("gettings12345678====>${branchShortName.text}");
    if (branchShortName.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Branch short name is required');
      return false;
    }
    if (batchName.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Batch name is required');
      return false;
    }
    if (batchTeacherController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Batch teacher is required');
      return false;
    }
    
    
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
    return true;
  }

   // Method to show time picker for start time
  Future<void> selectTime(BuildContext context, {required bool isStartTime}) async {
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
          'branch_short_name': branchShortName.text,
          'batch_name': batchName.text,
          'batch_teacher': batchTeacherController.value,
          'batch_timing_start': batchTiming.text,
          'batch_timing_end': batchTimingEnd.text,
          'batch_maximum_slots': maxSlots.text,
           'batch_days':batchDaysController.value,
          'batch_mode': modeController.value,
           'fees': fees.text,  
            'month': fees.text,
             "type": "N",
             "batchId": "",
         
        };

        final AddBatchDataModel? response = await WebService.addBatch(batchData);

        if (response != null && response.success == true) {
          SnackBarUtils.showSuccessSnackBar(context, 'Batch added successfully');
           Get.back();
           onInit();
        } else {
          SnackBarUtils.showErrorSnackBar(context, response?.message ?? 'Failed to add batch');
        }
      } catch (e) {
        SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
      } finally {
        isLoading.value = false;
      }
    }
  
}


  void setTeacher(String value) => batchTeacherController.value = value;
     void setBatchModes(String value) =>
      modeController.value = value;
  void setBatchDays(String value) => batchDaysController.value = value;
  void setStartTiming(String value) =>
      batchTimingController.value = value;
  void setEndingTiming(String value) => batchTimingEndController.value = value;
}