import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/modals/enrollment_success_model.dart';
import 'package:hovee_attendence/modals/getHostelEnrollmentListModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:logger/logger.dart';

class HostelEnrollementController extends GetxController
    with GetTickerProviderStateMixin {
  var isLoading = true.obs;
  late TabController tabController;

  var selectedTabIndex = 0.obs;

  var enrollmentList = <Datum>[].obs;

   final otpController = TextEditingController();

   final focusNode = FocusNode();
   String? lastWord;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
   lastWord = Get.arguments ?? '';
    tabController = TabController(length: 3, vsync: this);
    selectedTabIndex.value = 0;
     if (lastWord == '1') {
    // Change tab index to 1 (Approved)
    selectedTabIndex.value = 1;
    tabController.animateTo(1);

    // Fetch approved data list
    fetchHostelEnrollmentList("Approved");
  }
  else if (lastWord == '2') {
    // Change tab index to 1 (Approved)
    selectedTabIndex.value = 2;
    tabController.animateTo(2);

    // Fetch approved data list
    fetchHostelEnrollmentList("Rejected");
  }else{
     fetchHostelEnrollmentList("Pending");
  }
  }

   void handleTabChange(int index) {
    // Determine the type based on the selected tab index
    String type = _getTypeFromIndex(index);
    selectedTabIndex.value = index;

    // Fetch the list for the selected type
    fetchHostelEnrollmentList(type);

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

    void fetchHostelEnrollmentList(String type) async {
    try {
      var batchData = {
        "status": type,
      };
      isLoading(true);
      var classesResponse = await WebService.getHostelEnrollment(batchData);
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
        await WebService.updateEnrollmentHostel(batchData);

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