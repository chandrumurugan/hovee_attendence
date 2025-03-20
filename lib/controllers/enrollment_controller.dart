import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/controllers/attendance_controller.dart';
import 'package:hovee_attendence/modals/addEnrollmentData_model.dart';
import 'package:hovee_attendence/modals/enrollment_success_model.dart';
import 'package:hovee_attendence/modals/updateEnquire_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/enrollment_screen.dart';
import 'package:logger/logger.dart';

class EnrollmentController extends GetxController
    with GetTickerProviderStateMixin {
  var isLoading = true.obs;

  var validationMessages = <String>[].obs;

  final tuteeController = TextEditingController();

  final tutorController = TextEditingController();

  final classController = TextEditingController();

  final subjectController = TextEditingController();

  final feesController = TextEditingController();

  final coureseCodeController = TextEditingController();

  final boardController = TextEditingController();
  final branchController = TextEditingController();
  final batchTimingController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
   final modeController = TextEditingController();

  late TabController tabController;

  var selectedTabIndex = 0.obs;

  var enrollmentList = [].obs;

  final otpController = TextEditingController();
  final focusNode = FocusNode();

  final AttendanceCourseListController attendanceCourseListController =
      Get.put(AttendanceCourseListController());
  String? lastWord;

  @override
void onInit() {
  super.onInit();
 lastWord=  Get.arguments?? '';
 print(lastWord);
  // Initialize TabController with three tabs
  tabController = TabController(length: 3, vsync: this);

  // Set the default selected tab index to 0 (Pending)
  selectedTabIndex.value = 0;

  // Fetch the enrollment list for the default tab
  

  // Fetch attendance course list
  attendanceCourseListController.fetchAttendanceCourseList();

  // Clear start and end date controllers
  startDateController.clear();
  endDateController.clear();
   
  // Check if `lastWord` is not null and not an empty string
  if (lastWord == '1') {
    // Change tab index to 1 (Approved)
    selectedTabIndex.value = 1;
    tabController.animateTo(1);

    // Fetch approved data list
    fetchEnrollmentList("Approved");
  }
  else if (lastWord == '2') {
    // Change tab index to 1 (Approved)
    selectedTabIndex.value = 2;
    tabController.animateTo(2);

    // Fetch approved data list
    fetchEnrollmentList("Rejected");
  }else{
     fetchEnrollmentList("Pending");
  }
}


  void handleTabChange(int index) {
    // Determine the type based on the selected tab index
    String type = _getTypeFromIndex(index);
    selectedTabIndex.value = index;

    // Fetch the list for the selected type
    fetchEnrollmentList(type);

    // Animate to the appropriate tab
    tabController.animateTo(index);
  }

  String _getTypeFromIndex(int index) {
    switch (index) {
      case 0:
        return "Pending";
      case 1:
        return "Approved";
      case 2:
        return "Rejected";
      default:
        return "Pending";
    }
  }

  bool validateFields(BuildContext context) {
    validationMessages.clear();
    if (startDateController.text.isEmpty) {
      SnackBarUtils.showSuccessSnackBar(
        context,
        'Start date is required',
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

  Future<bool> addEnrollment(BuildContext context, String tutorId, studentId, courseId,
      batchId, tutorName, entrollmentType,batch, subject, tutorname) async {
    if (validateFields(context)) {
      isLoading.value = true;
      try {
        var data = {
          "tutorId": tutorId,
          "studentId": studentId,
          "courseId": courseId,
          "batchId": batchId,
          "startDate": startDateController.text,
          "endDate": endDateController.text,
          "tutorName": tutorName,
          "entrollmentType": entrollmentType // Tutor or Tutee
        };

        final addEnrollmentDataModel? response =
            await WebService.addEnrollment(data);

        if (response != null && response.statusCode == 200) {
          //SnackBarUtils.showSuccessSnackBar(context, 'Enrollment submitted successfully',);
//           Get.snackbar(
//          'Enrollment Initiated! for $batch($subject) You’ve successfully initiated the enrollment for $tutorname',
//   icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
//   colorText: Colors.white,
//   backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
//   messageText:   SizedBox(
//     height: 40, // Set desired height here
//     child: Center(
//       child: Text(
//        'Enrollment Initiated! for $batch($subject) You’ve successfully initiated the enrollment for $tutorname',
//         style: TextStyle(color: Colors.white, fontSize: 16),
//       ),
//     ),
//   ),
// );
          // Get.snackbar(
          //   icon: const Icon(
          //     Icons.check_circle,
          //     color: Colors.white,
          //     size: 40,
          //   ),
          //   'Enrollment submitted successfully',
          //   colorText: Colors.white,
          //   backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
          // );
          // Get.delete<EnrollmentController>();
          // Get.off(() => EnrollmentScreen(
          //       type: entrollmentType,
          //     ));
          return true;
        } else {
          // SnackBarUtils.showSuccessSnackBar(context, response?.message ?? 'Failed to add Enrollment',);
                    Get.snackbar(
          '',
  icon: const Icon(Icons.info, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
 messageText:    SizedBox(
    height: 30, // Set desired height here
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        response?.message ?? 'Failed to add Enrollment',
      textAlign: TextAlign.start,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
);
return false;
          // Get.snackbar(
          //   icon: const Icon(
          //     Icons.info,
          //     color: Colors.white,
          //     size: 40,
          //   ),
          //   response?.message ?? 'Failed to add Enrollment',
          //   colorText: Colors.white,
          //   backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
          // );
        }
      } catch (e) {
         Get.snackbar(
         '',
  icon: const Icon(Icons.info, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
 messageText:    SizedBox(
    height: 30, // Set desired height here
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        'Error: $e',
      textAlign: TextAlign.start,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
);
return false;
        // Get.snackbar(
        //   icon: const Icon(
        //     Icons.info,
        //     color: Colors.white,
        //     size: 40,
        //   ),
        //   'Error: $e',
        // );
      } finally {
        isLoading.value = false;
      }
    }
    return false;
  }

  void fetchEnrollmentList(String type) async {
    try {
      var batchData = {
        "status": type,
      };
      isLoading(true);
      var classesResponse = await WebService.getEnrollment(batchData);
      Logger().i("getting values==>${classesResponse!.data!.length}");
      if (classesResponse!.data != null) {
        enrollmentList.value = classesResponse.data!;
      }
    } catch (e) {
      // Handle errors if needed
    } finally {
      isLoading(false);
    }
  }

  Future<bool> updateEnrollment( String enrollmentId, String type, String code) async {
  isLoading.value = true;
  try {
    var batchData = {
      "status": type,
      "enrollmentId": enrollmentId,
      "code": code
    };

    final UpdateEnrollmentStatusModel? response =
        await WebService.updateEnrollment(batchData);

    if (response != null && response.statusCode == 200) {
      if (response.data!.status == 'Approved') {
        return true; // Enrollment successful
      } else {
        Get.snackbar(
          '',
          icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
          shouldIconPulse: false,
          messageText:    SizedBox(
    height: 30, // Set desired height here
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        'Enrollment rejected successfully',
      textAlign: TextAlign.start,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
        );
         tabController.animateTo(2);
          handleTabChange(2);
        return false;
      }
    } else {
      return false;
    }
  } catch (e) {
    return false;
  } finally {
    isLoading.value = false;
  }
}

}
