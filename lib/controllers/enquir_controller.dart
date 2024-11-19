import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/controllers/attendance_controller.dart';
import 'package:hovee_attendence/modals/getEnquireList_model.dart';
import 'package:hovee_attendence/modals/updateEnquire_model.dart';
import 'package:hovee_attendence/services/webServices.dart';

class EnquirDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  var selectedTabIndex = 0.obs;

  var isLoading = true.obs;

  var enquirList = <Data>[].obs;
   final AttendanceCourseListController controller =
      Get.put(AttendanceCourseListController());
 
          // final tuteeController = TextEditingController();
  

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 3, vsync: this);

    // Initially load "Pending" list
    fetchEnquirList("Pending");
  }

    void handleTabChange(int index) {
    // Determine the type based on the selected tab index
    String type = _getTypeFromIndex(index);
     selectedTabIndex.value = index;

    // Fetch the list for the selected type
    fetchEnquirList(type);

    // Animate to the appropriate tab
    tabController.animateTo(index);

    fetchEnquirList(type);
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

   void fetchEnquirList(String type) async {
    try {
      isLoading(true);

      var batchData = {"status": type};
      var classesResponse = await WebService.fetchEnquireList(batchData);

      if (classesResponse.data != null) {
        enquirList.value = classesResponse.data!;
      }
    } catch (e) {
      // Handle errors
    } finally {
      isLoading(false);
    }
  }

  // void fetchEnquirList(String type) async {
  //   try {
  //     var batchData = {
  //       "status": type,
  //     };
  //     isLoading(true);
  //     var classesResponse = await WebService.fetchEnquireList(batchData);
  //     if (classesResponse.data != null) {
  //       enquirList.value = classesResponse.data!;
  //     }
  //   } catch (e) {
  //     // Handle errors if needed
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  void updateEnquire(String enquiryId,String type ) async {
      isLoading.value = true;
      try {
        var batchData = {
        "status":type,
        "enquiryId": enquiryId
      };

        final updateEnquiryStatusModel? response =
            await WebService.updateEnquire(batchData);

        if (response != null && response.statusCode == 200) {
          // SnackBarUtils.showSuccessSnackBar(
          //     context, 'Update enquire successfully');
        Get.snackbar('Enquiry accepted successfully',backgroundColor: Color.fromRGBO(186, 1, 97, 1));
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

  void navigateBack() {
    Get.back();
  }
}
