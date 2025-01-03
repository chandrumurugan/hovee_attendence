import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/controllers/attendance_controller.dart';
import 'package:hovee_attendence/modals/getEnquireList_model.dart';
import 'package:hovee_attendence/modals/updateEnquire_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:logger/logger.dart';

class EnquirDetailController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  var selectedTabIndex = 0.obs;

  var isLoading = true.obs;

  var enquirList = <Data>[].obs;
   final AttendanceCourseListController controller =
      Get.put(AttendanceCourseListController());
 
          // final tuteeController = TextEditingController();
  
 String? lastWord;

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    tabController.dispose();
  }
//   @override
//   void onInit() {
//     super.onInit();
//    print("object");
//     lastWord=  Get.arguments?? 'Tutee';
//     tabController = TabController(length: 3, vsync: this);
//     selectedTabIndex.value=0;
//     print(selectedTabIndex.value);
   
//       // Check if `lastWord` is not null and not an empty string
//   if (lastWord =='Approved' && lastWord!.isNotEmpty) {
//     // Change tab index to 1 (Approved)
//     selectedTabIndex.value = 1;
//     tabController.animateTo(1);

//     // Fetch approved data list
//     fetchEnquirList("Approved");
//   }
//  else if (lastWord =='Rejected' &&lastWord!.isNotEmpty) {
//     // Change tab index to 1 (Approved)
//     selectedTabIndex.value = 2;
//     tabController.animateTo(2);

//     // Fetch approved data list
//     fetchEnquirList("Rejected");
//   }else{
//      fetchEnquirList("Pending");
//   }
//   }


 @override
  void onInit() {
    super.onInit();

    lastWord = Get.arguments ?? 'Tutee';
    tabController = TabController(length: 3, vsync: this);

    if (lastWord == 'Approved') {
      selectedTabIndex.value = 1;
      tabController.animateTo(1);
      fetchEnquirList("Approved");
    } else if (lastWord == 'Rejected') {
      selectedTabIndex.value = 2;
      tabController.animateTo(2);
      fetchEnquirList("Rejected");
    } else {
      fetchEnquirList("Pending");
    }
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

  void updateEnquire(BuildContext context,String enquiryId,String type ) async {
      isLoading.value = true;
      try {
        var batchData = {
        "status":type,
        "enquiryId": enquiryId
      };

        final UpdateEnquiryStatusModel ? response =
            await WebService.updateEnquire(batchData);

        if (response != null && response.statusCode == 200) {
          // SnackBarUtils.showSuccessSnackBar(
          //     context, 'Update enquire successfully');
          if(response.enquiry!.status=='Approved'){
        // SnackBarUtils.showSuccessSnackBar(context,'Enquiry accepted successfully',);
        tabController.animateTo(1);
                                    handleTabChange(1);
                                    print(selectedTabIndex.value);
          }
          else{
              //SnackBarUtils.showSuccessSnackBar(context,'Enquiry rejected successfully');
        tabController.animateTo(2);
                                    handleTabChange(2);
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

  void navigateBack() {
    Get.back();
  }
}
