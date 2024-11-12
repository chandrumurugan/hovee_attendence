import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/modals/getEnquireList_model.dart';
import 'package:hovee_attendence/modals/updateEnquire_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';

class EnquirDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  var selectedTabIndex = 0.obs;

  var isLoading = true.obs;

  var enquirList = <Data>[].obs;

 
          // final tuteeController = TextEditingController();
  

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
      fetchEnquirList(type);
    });

    // Initially load "Pending" list
    fetchEnquirList("Pending");
  }

  void fetchEnquirList(String type) async {
    try {
      var batchData = {
        "status": type,
      };
      isLoading(true);
      var classesResponse = await WebService.fetchEnquireList(batchData);
      if (classesResponse.data != null) {
        enquirList.value = classesResponse.data!;
      }
    } catch (e) {
      // Handle errors if needed
    } finally {
      isLoading(false);
    }
  }

  // void updateEnquire(BuildContext context, String enquiryId,String type ) async {
  //   isLoading.value = true;
  //   try {
      // var batchData = {
      //   "status":type,
      //   "enquiryId": enquiryId
      // };

  //     final updateEnquiryStatusModel? response =
  //         await WebService.updateEnquire(batchData);

  //     if (response != null && response.statusCode == 200) {
  //       // SnackBarUtils.showSuccessSnackBar(
  //       //       context, 'Class update successfully');
  //       //Get.off(()=>TutorClassList());
  //       fetchEnquirList("Pending");
  //     } else {
  //       SnackBarUtils.showErrorSnackBar(
  //           context, response?.message ?? 'Failed to update Class');
  //     }
  //   } catch (e) {
  //     SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
  //   } finally {
  //     isLoading.value = false;
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
        Get.snackbar('Update enquire successfully');
        fetchEnquirList('Pending');
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

  void navigateBack() {
    Get.back();
  }
}
