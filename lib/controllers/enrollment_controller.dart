import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/modals/addEnrollmentData_model.dart';
import 'package:hovee_attendence/modals/updateEnquire_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/enrollment_screen.dart';

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

   @override
  void onInit() {
    super.onInit();
    // Initialize TabController with three tabs
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      selectedTabIndex.value = tabController.index;

      // Update type based on the selected tab index
      String type;
      if (tabController.index == 0) {
        type = "Pending";
      } else if (tabController.index == 1) {
        type = "Approved";
      } else {
        type = "Rejected";
      }

      // Fetch the list based on the selected type
      fetchEnrollmentList(type);
    });

    // Initially load "Pending" list
    fetchEnrollmentList("Pending");
  }


  bool validateFields(BuildContext context) {
    validationMessages.clear();
    if (startDateController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Start Date is required');
      return false;
    }
    if (endDateController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'End date is required');
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
          SnackBarUtils.showSuccessSnackBar(context, 'Enrollment added successfully');
           Get.to(()=> EnrollmentScreen(type: entrollmentType,));
          
        } else {
          SnackBarUtils.showErrorSnackBar(context, response?.message ?? 'Failed to add Enrollment');
        }
      } catch (e) {
        SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
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
      if (classesResponse.data != null) {
        enrollmentList.value = classesResponse.data!;
      }
    } catch (e) {
      // Handle errors if needed
    } finally {
      isLoading(false);
    }
  }

  void updateEnrollment(String enrollmentId,String type ) async {
      isLoading.value = true;
      try {
        var batchData = {
        "status":type,
        "enrollmentId": enrollmentId
      };

        final updateEnquiryStatusModel? response =
            await WebService.updateEnrollment(batchData);

        if (response != null && response.statusCode == 200) {
          // SnackBarUtils.showSuccessSnackBar(
          //     context, 'Update enquire successfully');
        Get.snackbar('Update enrollment successfully');
        fetchEnrollmentList('Pending');
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