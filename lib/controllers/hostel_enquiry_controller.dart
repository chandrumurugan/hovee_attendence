import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/modals/getHostelEnquiryListModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HostelEnquiryController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;

  var selectedTabIndex = 0.obs;

  var isLoading = true.obs;

  var enquirList = <Datum>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
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
      var classesResponse = await WebService.fetchHostelEnquireList(batchData);
      if (classesResponse.data != null) {
        enquirList.value = classesResponse.data!;
          SharedPreferences prefs = await SharedPreferences.getInstance();
      }
    } catch (e) {
      // Handle errors
    } finally {
      isLoading(false);
    }
  }

   @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    tabController.dispose();
  }

    }