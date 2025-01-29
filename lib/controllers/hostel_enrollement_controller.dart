import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/modals/getHostelEnrollmentListModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:logger/logger.dart';

class HostelEnrollementController extends GetxController
    with GetTickerProviderStateMixin {
  var isLoading = true.obs;
  late TabController tabController;

  var selectedTabIndex = 0.obs;

  var enrollmentList = <Datum>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    tabController = TabController(length: 3, vsync: this);
    selectedTabIndex.value = 0;
    fetchHostelEnrollmentList("Pending");
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

    }