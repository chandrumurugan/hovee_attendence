import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/modals/add_leave_model.dart';
import 'package:hovee_attendence/modals/appConfigModal.dart';
import 'package:hovee_attendence/modals/deletebatch_model.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByBatch_model.dart';
import 'package:hovee_attendence/modals/getLeaveListModel.dart';
import 'package:hovee_attendence/modals/updateEnquire_model.dart';
import 'package:hovee_attendence/modals/updateLeaveModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/add_batch.dart';
import 'package:hovee_attendence/view/add_leave_screen.dart';
import 'package:hovee_attendence/view/leave_screen.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TuteeLeaveController extends GetxController {
  var leaveList = <LeaveData>[].obs;
  var isLoading = true.obs;
  var validationMessages = <String>[].obs;
  var batchNameController = ''.obs;
  String? selectedBatchId;
  var leaveTypeController = ''.obs;
  List<String> leaveType = [];
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  var reasonController = ''.obs;
  final reason = TextEditingController();
  final BatchController controller = Get.put(BatchController());
  List<String> batchName1 = [];
  var selectedBatchIN = Rxn<Data1>();
  var isBatchSelected = false.obs;
  var selectedBatch = {}.obs;
  Map<String, Map<String, String>> batchIdMap = {};
  String? selectedCourseId;
  String? selectedTutorId;
  String? selectedCourseName;
  var instituteId =''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchBatchList();
    fetchGroupedEnrollmentByBatchListItem();
    leaveType = getBatchDays();
    _clearData();
  }

  void fetchGroupedEnrollmentByBatchListItem() async {
    isLoading(true);
    try {
      // Call your API to fetch the data
      var response = await WebService.fetchGroupedEnrollmentLeaveByBatch();
      Logger().i(response);
      if (response != null && response.data != null) {
        // Extract only batch names for the dropdown
        batchName1 =
            response.data!.map((batch) => batch.batchName ?? '').toList();

        // Map batch names to their details for later retrieval
        batchIdMap = {
          for (var batch in response.data!)
            batch.batchName ?? '': {
              'batchId': batch.batchId ?? '',
              'courseId': batch.courseId ?? '',
              'tutorId': batch.tutorId ?? '',
              'courseName': batch.courseCode ?? ''
            }
        };
      }
    } catch (e) {
      // Handle any errors
      print('Error fetching batches: $e');
    } finally {
      isLoading(false);
    }
  }

  List<String> getBatchDays() {
    final storage = GetStorage();
    final appConfigDataBatchdays = storage.read('appConfig');

    if (appConfigDataBatchdays != null) {
      final appConfig = AppConfig.fromJson(appConfigDataBatchdays);
      if (appConfig.data != null) {
        return appConfig.data!.leaveType!
            .map((item) => item.label ?? '')
            .toList();
      }
    }
    return [];
  }

  void _clearData() {
    batchNameController.value = '';
    leaveTypeController.value = '';
    startDateController.clear();
    endDateController.clear();
    reason.clear();
  }

  bool validateFields(BuildContext context) {
    validationMessages.clear();
    if (batchNameController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Batch name is required',
      );
      return false;
    }
    if (leaveTypeController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Leave type is required',
      );
      return false;
    }
    if (startDateController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'From Date is required',
      );
      return false;
    }
    if (endDateController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'End Date is required',
      );
      return false;
    }
    if (reason.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Reason is required');
      return false;
    }

    return true;
  }

  void fetchBatchList({String searchTerm = ''}) async {
    try {
      isLoading(true);
      var leaveResponse = await WebService.fetchLeaveList(
          searchTerm); // Pass the searchTerm to the API
          SharedPreferences prefs = await SharedPreferences.getInstance();
       instituteId.value=   prefs.getString('InstituteId') ?? '';
      if (leaveResponse.data != null) {
        leaveList.value = leaveResponse.data!;
      }
    } catch (e) {
      // Handle errors if needed
    } finally {
      isLoading(false);
    }
  }

  void addLeave(BuildContext context) async {
    if (validateFields(context)) {
      isLoading.value = true;
      try {
        var batchData = {
          // 'branch_short_name': branchShortName.text,
          "courseId": selectedCourseId,
          "course_name": "",
          "leave_type": leaveTypeController.value,
          "from_date": startDateController.text,
          "end_date": endDateController.text,
          "reason": reason.text,
          "batchId": selectedBatchId,
          "tutorId": selectedTutorId,
          "type":
              "N", // new record N , update record U , delete record D  and U ,D required leaveId
          "leaveId": "",
          "batch_name":batchNameController.value,
        };

        final submitLeaveModel? response = await WebService.addLeave(batchData);

        if (response != null && response.success == true) {
          Get.back();
          fetchBatchList();
          _clearData();
          Get.snackbar(
       'Leave added successfully',
  icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
  // messageText:   const SizedBox(
  //   height: 40, // Set desired height here
  //   child: Center(
  //     child: Text(
  //     'Leave added successfully',
  //       style: TextStyle(color: Colors.white, fontSize: 16),
  //     ),
  //   ),
  // ),
);
        } else {
          Get.snackbar(
       response?.message ?? 'Leave already applied for these dates',
  icon: const Icon(Icons.info, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
  // messageText:    SizedBox(
  //   height: 40, // Set desired height here
  //   child: Center(
  //     child: Text(
  //     response?.message ?? 'Leave already applied for these dates',
  //       style: TextStyle(color: Colors.white, fontSize: 16),
  //     ),
  //   ),
  // ),
);
        }
      } catch (e) {
        Get.snackbar(
      'Error: $e',
  icon: const Icon(Icons.info, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
  // messageText:    SizedBox(
  //   height: 40, // Set desired height here
  //   child: Center(
  //     child: Text(
  //     'Error: $e',
  //       style: TextStyle(color: Colors.white, fontSize: 16),
  //     ),
  //   ),
  // ),
);
      } finally {
        isLoading.value = false;
      }
    }
  }

   void updateBatch(BuildContext context,String leaveId) async {
    if (validateFields(context)) {
      isLoading.value = true;
      try {
        var batchData = {
          // 'branch_short_name': branchShortName.text,
          "courseId": selectedCourseId,
          "course_name": "",
          "leave_type": leaveTypeController.value,
          "from_date": startDateController.text,
          "end_date": endDateController.text,
          "reason": reason.text,
          "batchId": selectedBatchId,
          "tutorId": selectedTutorId,
          "type":
              "U", // new record N , update record U , delete record D  and U ,D required leaveId
          "leaveId": leaveId,
           "batch_name":'',
        };

        final submitLeaveModel? response =
            await WebService.addLeave(batchData);

        if (response != null && response.success == true) {
          Get.back();
          fetchBatchList();
          _clearData();
                        Get.snackbar(
       'Success! The leave details have been updated.',
  icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
  // messageText:   const SizedBox(
  //   height: 40, // Set desired height here
  //   child: Center(
  //     child: Text(
  //     'Success! The leave details have been updated.',
  //       style: TextStyle(color: Colors.white, fontSize: 16),
  //     ),
  //   ),
  // ),
);
        //   Get.snackbar(icon: Icon(Icons.check_circle,color: Colors.white,size: 40,)
        // ,'Leave updated  successfully',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
         
        } else {
          Get.snackbar(
       response?.message ?? 'Failed to updated batch',
  icon: const Icon(Icons.info, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
  // messageText:    SizedBox(
  //   height: 40, // Set desired height here
  //   child: Center(
  //     child: Text(
  //     response?.message ?? 'Failed to updated batch',
  //       style: TextStyle(color: Colors.white, fontSize: 16),
  //     ),
  //   ),
  // ),
);
          // SnackBarUtils.showErrorSnackBar(
          //     context, response?.message ?? 'Failed to updated batch');
        }
      } catch (e) {
         Get.snackbar(
      'Error: $e',
  icon: const Icon(Icons.info, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
  // messageText:    SizedBox(
  //   height: 40, // Set desired height here
  //   child: Center(
  //     child: Text(
  //     'Error: $e',
  //       style: TextStyle(color: Colors.white, fontSize: 16),
  //     ),
  //   ),
  // ),
);
        //SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }

   void deleteLeave(BuildContext context,String leaveId) async {
      isLoading.value = true;
      try {
        var batchData = {
          "type":
              "D", 
          "leaveId": leaveId,
        };

        final deleteBatchDataModel? response =
            await WebService.deleteLeave(batchData);

        if (response != null && response.success == true) {
         // Remove the deleted item locally
      leaveList.value.removeWhere((item) => item.sId == leaveId);

      // Notify listeners about the updated list
      leaveList.refresh(); // Ensures the UI is updated
     Get.snackbar(
      "Deletion Successful! The leave has  removed.",
  icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
  // messageText:    SizedBox(
  //   height: 40, // Set desired height here
  //   child: Center(
  //     child: Text(
  //     "Leave deleted  successfully",
  //       style: TextStyle(color: Colors.white, fontSize: 16),
  //     ),
  //   ),
  // ),
);
       // Get.snackbar(icon: Icon(Icons.check_circle,color: Colors.white,size: 40,), 'Leave deleted  successfully',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
           //Get.off(()=> TuteeLeaveScreen(type: 'Tutee',));
      } else {
        Get.snackbar(
       response?.message ?? 'Failed to updated batch',
  icon: const Icon(Icons.info, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
  // messageText:    SizedBox(
  //   height: 40, // Set desired height here
  //   child: Center(
  //     child: Text(
  //     response?.message ?? 'Failed to updated batch',
  //       style: TextStyle(color: Colors.white, fontSize: 16),
  //     ),
  //   ),
  // ),
);
        // Get.snackbar(icon: Icon(Icons.info,color: Colors.white,size: 40,),colorText: Colors.white, response?.message ?? 'Failed to delete leave',backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
      }
      } catch (e) {
        Get.snackbar(
       'Error: $e',
  icon: const Icon(Icons.info, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor:  Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
  // messageText:    SizedBox(
  //   height: 40, // Set desired height here
  //   child: Center(
  //     child: Text(
  //     'Error: $e',
  //       style: TextStyle(color: Colors.white, fontSize: 16),
  //     ),
  //   ),
  // ),
);
        // Get.snackbar(icon: Icon(Icons.info,color: Colors.white,size: 40,), 'Error: $e',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
      } finally {
        isLoading.value = false;
      }
  }

    void updateLeave(BuildContext context,String leaveId,String type ) async {
      isLoading.value = true;
      try {
        var batchData = {
        "status":type,
        "leaveId": leaveId
      };

        final updateLeaveModel ? response =
            await WebService.updateLeave(batchData);

        if (response != null && response.statusCode == 200) {
        
          if(response.data!.status=='Accepted'){
             fetchBatchList();
             Get.snackbar(
      "You have successfully accepted the leave request.",
  icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
  // messageText:    SizedBox(
  //   height: 40, // Set desired height here
  //   child: Center(
  //     child: Text(
  //     "You have successfully accepted the leave request.",
  //       style: TextStyle(color: Colors.white, fontSize: 16),
  //     ),
  //   ),
  // ),
);
        // Get.snackbar(icon: Icon(Icons.check_circle,color: Colors.white,size: 40,),'Leave accepted successfully',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);

          }
          else{
             fetchBatchList();
              Get.snackbar(
      "You have rejected the leave request",
  icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
  // messageText:    SizedBox(
  //   height: 40, // Set desired height here
  //   child: Center(
  //     child: Text(
  //     "You have rejected the leave request",
  //       style: TextStyle(color: Colors.white, fontSize: 16),
  //     ),
  //   ),
  // ),
);
             // Get.snackbar(icon: Icon(Icons.check_circle,color: Colors.white,size: 40,),'Leave rejected successfully',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
          }
        // fetchEnquirList('Pending');
        //       //Get.off(()=>TutorClassList());
        //       controller.onInit();
        } else {
          // SnackBarUtils.showErrorSnackBar(
          //     context, response?.message ?? 'Failed to update Enquire');
        }
      } catch (e) {
        //SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
      } finally {
        isLoading.value = false;
      }
   
  }


  void setBatchName(String value) {
    batchNameController.value = value;
    var selectedBatchDetails = batchIdMap[value];

    if (selectedBatchDetails != null) {
      selectedBatchId = selectedBatchDetails['batchId'];
      selectedCourseId = selectedBatchDetails['courseId'];
      selectedTutorId = selectedBatchDetails['tutorId'];
      selectedCourseName = selectedBatchDetails['courseName'];

      Logger().i('Selected Batch ID: $selectedBatchId');
      Logger().i('Selected Course ID: $selectedCourseId');
      Logger().i('Selected Tutor ID: $selectedTutorId');
      Logger().i('Selected Course Name: $selectedCourseName');
    }
  }

  void setHolidayType(String value) => leaveTypeController.value = value;

  void navigateToAddBatchScreen() {
    Get.to(() => TuteeAddLeaveScreen());
  }
}
