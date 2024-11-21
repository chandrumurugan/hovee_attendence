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

class EnrollmentController extends GetxController  with GetSingleTickerProviderStateMixin {

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

            late TabController tabController;

  var selectedTabIndex = 0.obs;

  var enrollmentList = [].obs;

  final otpController = TextEditingController();
  final focusNode = FocusNode();

  final AttendanceCourseListController attendanceCourseListController = Get.put(AttendanceCourseListController());

   @override
  void onInit() {
    super.onInit();
    // Initialize TabController with three tabs
    tabController = TabController(length: 3, vsync: this);
    fetchEnrollmentList("Pending");
     attendanceCourseListController.fetchAttendanceCourseList();
     startDateController.clear();
     endDateController.clear();
    // tabController.addListener(() {
    //   selectedTabIndex.value = tabController.index;

    //   // Update type based on the selected tab index
    //   String type;
    //   if (tabController.index == 0) {
    //     type = "Pending";
    //   } else if (tabController.index == 1) {
    //     type = "Approved";
    //   } else {
    //     type = "Rejected";
    //   }

    //   // Fetch the list based on the selected type
    //   fetchEnrollmentList(type);
    // });

    // // Initially load "Pending" list
    // fetchEnrollmentList("Pending");
    //  attendanceCourseListController.fetchAttendanceCourseList();
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
       SnackBarUtils.showSuccessSnackBar(context,'Start Date is required',);
      return false;
    }
    if (endDateController.text.isEmpty) {
       SnackBarUtils.showSuccessSnackBar(context,'End date is required',);
      return false;
    }
    return true;
   }  

void addEnrollment(BuildContext context,String tutorId,studentId,courseId,batchId,tutorName,entrollmentType ) async { 
if (validateFields(context)) {
      isLoading.value = true;
      try {
        var data = {
    "tutorId": tutorId,
    "studentId": studentId,
    "courseId": courseId,
    "batchId": batchId,
    "startDate":  startDateController.text,
    "endDate": endDateController.text,
    "tutorName": tutorName,
    "entrollmentType": entrollmentType // Tutor or Tutee
};

        final addEnrollmentDataModel? response = await WebService.addEnrollment(data);

        if (response != null && response.statusCode == 200) {
            SnackBarUtils.showSuccessSnackBar(context, 'Enrollment submitted successfully',);
            Get.delete<EnrollmentController>();
           Get.off(()=> EnrollmentScreen(type: entrollmentType,));
          
        } else {
           SnackBarUtils.showSuccessSnackBar(context, response?.message ?? 'Failed to add Enrollment',);
        }
      } catch (e) {
         SnackBarUtils.showSuccessSnackBar(context, 'Error: $e',);
      } finally {
        isLoading.value = false;
      }
    }
  
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

  void updateEnrollment(BuildContext context, String enrollmentId,String type,code) async {
      isLoading.value = true;
      try {
        var batchData = {
        "status":type,
        "enrollmentId": enrollmentId,
        "code":code
      };

        final UpdateEnrollmentStatusModel ? response =
            await WebService.updateEnrollment(batchData);

        if (response != null && response.statusCode == 200) {
          // SnackBarUtils.showSuccessSnackBar(
          //     context, 'Update enquire successfully');
           if(response.data!.status=='Approved'){
         SnackBarUtils.showSuccessSnackBar(context,'You are enrolled successfully',);
        fetchEnrollmentList('Pending');
         tabController.animateTo(1);
                                    handleTabChange(1);
           }else{
              SnackBarUtils.showSuccessSnackBar(context,'Enrollement rejected successfully',);
              tabController.animateTo(2);
                                    handleTabChange(2);
           }
              //Get.off(()=>TutorClassList());
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
}