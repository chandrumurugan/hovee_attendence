import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/modals/addHolidaymodel.dart';
import 'package:hovee_attendence/modals/addMspModel.dart';
import 'package:hovee_attendence/modals/getMsplistmodel.dart';
import 'package:hovee_attendence/modals/updateEnquire_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/add_msp_screen.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class MspController extends GetxController {
  var mspDataList = <MSPData>[].obs;
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
   var batchName = ''.obs; // RxString for reactive data

  late TextEditingController batchNameController1;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _clearData();
    fetchBatchList();
     batchNameController1 = TextEditingController(text: batchName.value);

    // Update TextEditingController whenever RxString changes
    ever(batchName, (value) {
      batchNameController.value = value;
    });
  }

  

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
    // if (batchTimingEnd.text.isEmpty) {
    //   SnackBarUtils.showErrorSnackBar(context, 'Batch timing End is required');
    //   return false;
    // }
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

  void fetchBatchList({String searchTerm = ''}) async {
    try {
      isLoading(true);
      var holidayResponse = await WebService.fetchMSPDataList(
          searchTerm); // Pass the searchTerm to the API

      if (holidayResponse.data != null) {
        mspDataList.value = holidayResponse.data!;
      }
    } catch (e) {
      // Handle errors if needed
    } finally {
      isLoading(false);
    }
  }

  void addMSP(BuildContext context,String tutorId,batchId,attendanceID) async {
    if (validateFields(context)) {
      isLoading.value = true;
      try {
        var batchData = {
          // 'branch_short_name': branchShortName.text,
          "type": "N",
          "course_name": "",
          "courseId": "674f1811a721cbb367a148b0",
          "batchId": batchId,
          "batch_name":batchNameController.value,
          "date": startDateController.text,
          "reason": reason.text,
          "tutorId": tutorId,
          // "status": "",
          "mspId": "",
          'attendanceId':attendanceID,
        };

        final addMspModel? response = await WebService.addMSP(batchData);

        if (response != null && response.success == true) {
          Get.offAll(const DashboardScreen(rolename: 'Tutee',));
          onInit();
          _clearData();
          SnackBarUtils.showSuccessSnackBar(
            context,
            'MSP added successfully',
          );
        } else {
          // SnackBarUtils.showErrorSnackBar(
          //     context, response?.message ?? 'Failed to add MSP');
        }
      } catch (e) {
        SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }

  void editMSP(BuildContext context,String id, tutorId,batchId) async {
    if (validateFields(context)) {
      isLoading.value = true;
      try {
        var batchData = {
          // 'branch_short_name': branchShortName.text,
          "type": "U",
          "course_name": "",
          "courseId": "674f1811a721cbb367a148b0",
          "batchId": batchId,
          "batch_name":batchNameController.value,
          "date": startDateController.text,
          "reason": reason.text,
          //"tutorId": tutorId,
          // "status": "",
          "mspId": id
        };

        final addMspModel? response = await WebService.addMSP(batchData);

        if (response != null && response.success == true) {
          //Get.offAll(DashboardScreen(rolename: 'Tutee',));
         Get.back();
          fetchBatchList();
          _clearData();
          SnackBarUtils.showSuccessSnackBar(
            context,
            'Success! The misspunch details have been updated.',
          );
        } else {
          // SnackBarUtils.showErrorSnackBar(
          //     context, response?.message ?? 'Failed to add MSP');
        }
      } catch (e) {
        SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }

   void updateMSP(BuildContext context,String mspId,status) async {
      isLoading.value = true;
      try {
        var batchData = {
          // 'branch_short_name': branchShortName.text,
          "type": "U",
          "status": status,
          "mspId": mspId
        };

        final addMspModel? response = await WebService.addMSP(batchData);

        if (response != null && response.success == true) {
          if(response.data!.status=='Accepted'){
             fetchBatchList();
              Get.snackbar(
       'You have successfully accepted the misspunch request.',
  icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  messageText:   const SizedBox(
    height: 40, // Set desired height here
    child: Center(
      child: Text(
      'You have successfully accepted the misspunch request.',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
);
        // Get.snackbar(icon: const Icon(Icons.check_circle,color: Colors.white,size: 40,),colorText: Colors.white,'MSP accepted successfully',backgroundColor: const Color.fromRGBO(186, 1, 97, 1),);

          }
          else{
             fetchBatchList();
              Get.snackbar(
       'You have rejected the misspunch request ',
  icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  messageText:   const SizedBox(
    height: 40, // Set desired height here
    child: Center(
      child: Text(
      'You have rejected the misspunch request ',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
);
               //Get.snackbar(icon: Icon(Icons.check_circle,color: Colors.white,size: 40,),colorText: Colors.white,'MSP rejected successfully',backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
          }
        } else {
          // SnackBarUtils.showErrorSnackBar(
          //     context, response?.message ?? 'Failed to add MSP');
        }
      } catch (e) {
        SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
      } finally {
        isLoading.value = false;
    }
  }

  void deleteMSP(BuildContext context, String mspId) async {
  isLoading.value = true;
  try {
    var batchData = {
      "type": "D",
      "mspId": mspId
    };

    final addMspModel? response = await WebService.addMSP(batchData);

    if (response != null && response.success == true) {
      // Remove the deleted item locally
      mspDataList.value.removeWhere((item) => item.sId == mspId);

      // Notify listeners about the updated list
      mspDataList.refresh(); // Ensures the UI is updated
       Get.snackbar(
       'Deletion Successful! The misspunch has removed.',
  icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  messageText:   const SizedBox(
    height: 40, // Set desired height here
    child: Center(
      child: Text(
      'Deletion Successful! The misspunch has removed.',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
);
  //Get.snackbar(icon: Icon(Icons.check_circle,color: Colors.white,size: 40,),colorText: Colors.white, 'MSP deleted successfully',backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
    } else {
       Get.snackbar(
       'Failed to deleted MSP',
  icon: const Icon(Icons.info, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  messageText:   const SizedBox(
    height: 40, // Set desired height here
    child: Center(
      child: Text(
      'Failed to deleted MSP',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
);
      //Get.snackbar(icon: Icon(Icons.info,color: Colors.white,size: 40,),colorText: Colors.white,  'Failed to deleted MSP',backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
    }
  } catch (e) {
            Get.snackbar(
       'Error: $e',
  icon: const Icon(Icons.info, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  messageText:   SizedBox(
    height: 40, // Set desired height here
    child: Center(
      child: Text(
      'Error: $e',
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
);
   // Get.snackbar(icon: Icon(Icons.info,color: Colors.white,size: 40,), 'Error: $e',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
  } finally {
    isLoading.value = false;
  }
}


  void _clearData() {
    batchNameController.value = '';
    startDateController.clear();
    batchTiming.clear();
    reason.clear();
  }

  void setBatchName(String value) {
    batchNameController.value = value;
     batchName.value = value;
    selectedBatchId = controller.batchIdMap[value];
    Logger().i('Selected Batch ID: $selectedBatchId');
  }

  void setStartTiming(String value) => batchTimingController.value = value;
  void setEndingTiming(String value) => batchTimingEndController.value = value;

  void navigateToAddHolidatScreen() {
    // Get.to(() => AddMspScreen());
  }
}
