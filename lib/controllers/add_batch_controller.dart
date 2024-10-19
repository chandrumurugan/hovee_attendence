import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/modals/addbatch_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';


import 'package:hovee_attendence/view/batch_screen.dart';
import 'package:intl/intl.dart';

class TutorAddBatchController extends GetxController {
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

  var validationMessages = <String>[].obs;
  var isLoading = false.obs;

   final List<String> modes = ['Online', 'Offline',];

    void setMode(String value) => modeController.value = value;

  bool validateFields(BuildContext context) {
    validationMessages.clear();

    if (branchShortNameController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Branch short name is required');
      return false;
    }
    if (batchNameController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Batch name is required');
      return false;
    }
    if (batchDaysController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Batch days is required');
      return false;
    }
    if (batchTeacherController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Batch teacher is required');
      return false;
    }
    if (batchTimingController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Batch timing is required');
      return false;
    }
    if (maxSlotsController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Maximum slots are required');
      return false;
    }
    if (modeController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Mode is required');
      return false;
    }
    if (batchTimingEndController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Batch timing End is required');
      return false;
    }
    if (feesController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Fees is required');
      return false;
    }
    if (monthController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Month is required');
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
          'branch_short_name': branchShortNameController.value,
          'batch_name': batchNameController.value,
          'batch_teacher': batchTeacherController.value,
          'batch_timing_start': batchTimingController.value,
          'batch_timing_end': batchTimingEndController.value,
          'batch_maximum_slots': maxSlotsController.value,
           'batch_days':batchDaysController.value,
          'batch_mode': modeController.value,
           'fees': feesController.value,  
            'month': monthController.value,
         
        };

        final AddBatchDataModel? response = await WebService.addBatch(batchData);

        if (response != null && response.success == true) {
          SnackBarUtils.showSuccessSnackBar(context, 'Batch added successfully');
          Get.back();
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
}
