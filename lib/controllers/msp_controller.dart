import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/modals/addHolidaymodel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/add_msp_screen.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class MspController extends GetxController {
  //var mspDataList = <Data1>[].obs;
  var isLoading = true.obs;
  var batchNameController = ''.obs;
  List<String> batchName1 = [];
  String? selectedBatchId;
  final BatchController controller = Get.put(BatchController());
  final startDateController = TextEditingController();
  var validationMessages = <String>[].obs;
  var reasonController = ''.obs;
  final reason = TextEditingController();
  var remarksController = ''.obs;
  final remarks = TextEditingController();
  var batchTimingController = ''.obs;
  final batchTiming = TextEditingController();
  final batchTimingEnd = TextEditingController();
  var batchTimingEndController = ''.obs;

  bool validateFields(BuildContext context) {
    validationMessages.clear();
    if (batchNameController.value.isEmpty) {
      SnackBarUtils.showSuccessSnackBar(
        context,
        'Branch name is required',
      );
      return false;
    }
    if (startDateController.text.isEmpty) {
      SnackBarUtils.showSuccessSnackBar(
        context,
        'Date is required',
      );
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
    if (reason.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Reason name is required');
      return false;
    }
    return true;
  }

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

  // void fetchBatchList({String searchTerm = ''}) async {
  //   try {
  //     isLoading(true);
  //     var holidayResponse = await WebService.fetchMSPDataList(
  //         searchTerm); // Pass the searchTerm to the API

  //     if (holidayResponse.data != null) {
  //       holidayDataList.value = holidayResponse.data!;
  //     }
  //   } catch (e) {
  //     // Handle errors if needed
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  void addMSP(BuildContext context) async {
    if (validateFields(context)) {
      isLoading.value = true;
      try {
        var batchData = {
          // 'branch_short_name': branchShortName.text,
          "type": "N",
          "course_name": "",
          "courseId": "",
          "batchId": "",
          "batch_name": "",
          "date": "",
          "reason": "",
          "tutorId": "",
          "status": "Pending", //Aprroved ,Rejected,Pending
          "mspId": ""
        };

        final AddHolidayModel? response =
            await WebService.addMSP(batchData);

        if (response != null && response.success == true) {
          Get.back();
          onInit();
          _clearData();
          SnackBarUtils.showSuccessSnackBar(
            context,
            'Holiday added successfully',
          );
        } else {
          SnackBarUtils.showErrorSnackBar(
              context, response?.message ?? 'Failed to add holiday');
        }
      } catch (e) {
        SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }

  // void updateHoliday(BuildContext context, String holidayId) async {
  //   if (validateFields(context)) {
  //     isLoading.value = true;
  //     try {
  //       var batchData = {
  //         // 'branch_short_name': branchShortName.text,
  //         "batch_name": batchNameController.value,
  //         "description": description.text,
  //         "holidayId": holidayId,
  //         "holiday_from_date": startDateController.text,
  //          "holiday_end_date": endDateController.text,
  //         "holiday_name": holidayName.text,
  //         "holiday_type": holidayTypeController.value,
  //         "type": "U"
  //       };

  //       final AddHolidayModel? response =
  //           await WebService.addHoliday(batchData);

  //       if (response != null && response.success == true) {
  //         _clearData();
  //        SnackBarUtils.showSuccessSnackBar(
  //           context,
  //           'Holiday updated successfully',
  //         );
  //         Get.back();
  //         onInit();
  //       } else {
  //         SnackBarUtils.showErrorSnackBar(
  //             context, response?.message ?? 'Failed to update holiday');
  //       }
  //     } catch (e) {
  //       SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
  //     } finally {
  //       isLoading.value = false;
  //     }
  //   }
  // }

  // void deleteHoliday(BuildContext context, String holidayId) async {
  //   isLoading.value = true;
  //   try {
  //     var batchData = {
  //       "batch_name": "",
  //       "description": "",
  //       "holidayId": holidayId,
  //       "holiday_from_date": "",
  //          "holiday_end_date": "",
  //       "holiday_name": "",
  //       "holiday_type": "",
  //       "type": "D"
  //     };

  //     final deleteHolidayModel? response =
  //         await WebService.deleteHoliday(batchData);

  //     if (response != null && response.success == true) {
  //       _clearData();
  //       fetchBatchList();
  //        Get.snackbar(icon: Icon(Icons.check_circle,color: Colors.white,size: 40,)
  //       ,'Holiday delete successfully',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
  //     // SnackBarUtils.showSuccessSnackBar(context, 'Holiday delete successfully');
  //       //  Get.back();
  //       //  onInit();
  //     } else {
  //    Get.snackbar(icon: Icon(Icons.info,color: Colors.white,size: 40,),response?.message ?? 'Failed to update Enquire',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
  //     }
  //   } catch (e) {
  //      Get.snackbar(icon: Icon(Icons.info,color: Colors.white,size: 40,), 'Error: $e',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  void _clearData() {
    batchNameController.value = '';
    startDateController.clear();
  }

  void setBatchName(String value) {
    batchNameController.value = value;
    selectedBatchId = controller.batchIdMap[value];
    Logger().i('Selected Batch ID: $selectedBatchId');
  }

  void setStartTiming(String value) => batchTimingController.value = value;
  void setEndingTiming(String value) => batchTimingEndController.value = value;

  void navigateToAddHolidatScreen() {
    Get.to(() => AddMspScreen());
  }
}
