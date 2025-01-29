import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByBatch_model.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByHostelModel.dart';
import 'package:hovee_attendence/modals/getHomeDashboardModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HostelController extends GetxController with GetSingleTickerProviderStateMixin{

 GlobalKey<ScaffoldState> hostelScaffoldKey = GlobalKey<ScaffoldState>();
  var isLoading = true.obs;
  var homeDashboardNavList = <NavbarItems>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     fetchHomeDashboardTuteeList();
  }

   void fetchHomeDashboardTuteeList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      isLoading(true);
      var homeDashboardResponse = await WebService.fetchHomeDashboardList();
      if (homeDashboardResponse != null) {
        homeDashboardNavList.value = homeDashboardResponse.navbarItems!;
      }
    } catch (e) {
      // Get.snackbar('Failed to fetch batches');
    } finally {
      isLoading(false);
    }
  }

  
}