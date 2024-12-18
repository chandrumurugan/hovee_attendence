import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/modals/addHolidaymodel.dart';
import 'package:hovee_attendence/modals/appConfigModal.dart';
import 'package:hovee_attendence/modals/deleteHolidayModel.dart';
import 'package:hovee_attendence/modals/deletebatch_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/add_holiday_screen.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

import '../modals/getHolidayDataModel.dart';

class HolidayController extends GetxController {
  var holidayDataList = <Data1>[].obs;
  var holidayTuteeDataList = <Data1>[].obs;
  var isLoading = true.obs;

  var batchNameController = ''.obs;
  final batchNameController1 = TextEditingController();
  List<String> batchName = [];
  String? selectedBatchId;
  var holidayNameController = ''.obs;
  final BatchController controller = Get.put(BatchController());
  final holidayName = TextEditingController();
  var descriptionController = ''.obs;
  final description = TextEditingController();
  var validationMessages = <String>[].obs;
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  List<String> holidayaType = [];
  var holidayTypeController = ''.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchBatchList();
    fetchHoliDataTuteeList();
    _clearData();
    holidayaType = getBatchDays();
  }

  bool validateFields(BuildContext context) {
    validationMessages.clear();
    if (batchNameController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Batch name is required',
      );
      return false;
    }
    if (holidayName.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Holiday name is required');
      return false;
    }
    if (holidayTypeController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Holiday type is required',
      );
      return false;
    }
    if (startDateController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'From Date is required',
      );
      return false;
    }
    if (endDateController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'End Date is required',
      );
      return false;
    }
    // if (description.text.isEmpty) {
    //   SnackBarUtils.showErrorSnackBar(context, 'Batch name is required');
    //   return false;
    // }

    return true;
  }

  void fetchBatchList({String searchTerm = ''}) async {
    try {
      isLoading(true);
      var holidayResponse = await WebService.fetchHoliDataList(
          searchTerm); // Pass the searchTerm to the API

      if (holidayResponse.data != null) {
        holidayDataList.value = holidayResponse.data!;
      }
    } catch (e) {
      // Handle errors if needed
    } finally {
      isLoading(false);
    }
  }

   void fetchHoliDataTuteeList({String searchTerm = ''}) async {
    try {
      isLoading(true);
      var holidayResponse = await WebService.fetchHoliDataTuteeList(
          searchTerm,); // Pass the searchTerm to the API

      if (holidayResponse.data != null) {
        holidayTuteeDataList.value = holidayResponse.data!;
      }
    } catch (e) {
      // Handle errors if needed
    } finally {
      isLoading(false);
    }
  }

  

  void addHoliday(BuildContext context) async {
    if (validateFields(context)) {
      isLoading.value = true;
      try {
        var batchData = {
          // 'branch_short_name': branchShortName.text,
          "batch_name": batchNameController.value,
          "description": description.text,
          "holidayId": "",
          "holiday_from_date": startDateController.text,
           "holiday_end_date": endDateController.text,
          "holiday_name": holidayName.text,
          "holiday_type": holidayTypeController.value,
          "type": "N",
          "batchId":selectedBatchId,
        };

        final AddHolidayModel? response =
            await WebService.addHoliday(batchData);

        if (response != null && response.success == true) {
           Get.back();
          onInit();
          _clearData();
          SnackBarUtils.showSuccessSnackBar(
            context,
            'Holiday added successfully',
          );
         
        } else {
          SnackBarUtils.showErrorSnackBar(
              context, response?.message ?? 'Holiday already exists for these dates');
        }
      } catch (e) {
        SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }

  void updateHoliday(BuildContext context, String holidayId) async {
    if (validateFields(context)) {
      isLoading.value = true;
      try {
        var batchData = {
          // 'branch_short_name': branchShortName.text,
          "batch_name": batchNameController.value,
          "description": description.text,
          "holidayId": holidayId,
          "holiday_from_date": startDateController.text,
           "holiday_end_date": endDateController.text,
          "holiday_name": holidayName.text,
          "holiday_type": holidayTypeController.value,
          "type": "U"
        };

        final AddHolidayModel? response =
            await WebService.addHoliday(batchData);

        if (response != null && response.success == true) {
          _clearData();
         SnackBarUtils.showSuccessSnackBar(
            context,
            'Holiday updated successfully',
          );
          Get.back();
          onInit();
        } else {
          SnackBarUtils.showErrorSnackBar(
              context, response?.message ?? 'Failed to update holiday');
        }
      } catch (e) {
        SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }

  void deleteHoliday(BuildContext context, String holidayId) async {
    isLoading.value = true;
    try {
      var batchData = {
        "batch_name": "",
        "description": "",
        "holidayId": holidayId,
        "holiday_from_date": "",
           "holiday_end_date": "",
        "holiday_name": "",
        "holiday_type": "",
        "type": "D"
      };

      final deleteHolidayModel? response =
          await WebService.deleteHoliday(batchData);

      if (response != null && response.success == true) {
         _clearData();
        fetchBatchList();

         Get.snackbar(icon: Icon(Icons.check_circle,color: Colors.white,size: 40,)
        ,'Holiday deleted successfully',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
      // SnackBarUtils.showSuccessSnackBar(context, 'Holiday delete successfully');
        //  Get.back();
         onInit();
      } else {
     Get.snackbar(icon: Icon(Icons.info,color: Colors.white,size: 40,),response?.message ?? 'Failed to update Enquire',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
      }
    } catch (e) {
       Get.snackbar(icon: Icon(Icons.info,color: Colors.white,size: 40,), 'Error: $e',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToAddHolidatScreen() {
    Get.to(() => AddHolidayScreen());
  }

  void setBatchName(String value) {
    batchNameController.value = value;
    selectedBatchId = controller.batchIdMap[value];
    Logger().i('Selected Batch ID: $selectedBatchId');
  }

  void setHolidayType(String value) => holidayTypeController.value = value;

  void _clearData() {
    batchNameController.value = '';
    holidayName.clear();
    holidayTypeController.value = '';
    startDateController.clear();
    endDateController.clear();
    description.clear();
  }

  List<String> getBatchDays() {
    final storage = GetStorage();
    final appConfigDataBatchdays = storage.read('appConfig');

    if (appConfigDataBatchdays != null) {
      final appConfig = AppConfig.fromJson(appConfigDataBatchdays);
      if (appConfig.data != null) {
        return appConfig.data!.holidayType!
            .map((item) => item.label ?? '')
            .toList();
      }
    }
    return [];
  }
}
