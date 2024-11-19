import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/controllers/course_controller.dart';
import 'package:hovee_attendence/modals/addClassData_model.dart';
import 'package:hovee_attendence/modals/addbatch_model.dart';
import 'package:hovee_attendence/modals/getTutionCourseList_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/add_class_screen.dart';
import 'package:hovee_attendence/view/class_screen.dart';

class ClassController extends GetxController  with GetTickerProviderStateMixin {
  var courseCodeController = ''.obs;
  var fullAddress = ''.obs;

  List<String> courseCode = [];

  var batchNameController = ''.obs;

  List<String> batchName = [];

  var isLoading = true.obs;

  var validationMessages = <String>[].obs;

   var selectedTabIndex = 0.obs;

   var classesList = <TutionData>[].obs;

    late TabController tabController;

    var tutionCourseList = [].obs;

    var selectedCourseCode = ''.obs; // Holds the selected course code
  var selectedCourseData = TutionData().obs;

 final batchNameController1 = TextEditingController();

  final CourseController courseController = Get.put(CourseController());
  final BatchController controller = Get.put(BatchController());

 @override
  void onInit() {
    super.onInit();
    // Initialize TabController with three tabs
    tabController = TabController(length: 2, vsync: this);
    // tabController.addListener(() {
    //   selectedTabIndex.value = tabController.index;
    //   print("hi rahul ${selectedTabIndex.value}");
    //   // Update type based on the selected tab index
    //   String type;
    //   if (tabController.index == 0) {
    //     type = "Draft";
    //   } else  {
    //     type = "Public";
    //   }

    //   // Fetch the list based on the selected type
    //   fetchClassesList(type);
    // });

    // Initially load "Pending" list
    fetchClassesList("Draft");
    fetchCourseList();
     _clearData();
  }

    void handleTabChange(int index) {
    // Determine the type based on the selected tab index
    String type = _getTypeFromIndex(index);
     selectedTabIndex.value = index;

    // Fetch the list for the selected type
    fetchClassesList(type);

    // Animate to the appropriate tab
    tabController.animateTo(index);
    fetchClassesList(type);
  }

  String _getTypeFromIndex(int index) {
    switch (index) {
      case 0:
        return "Draft";
      case 1:
        return "Public";
      default:
        return "Draft";
    }
  }

 void fetchClassesList(String type) async {
    try {
      var batchData = {
        "type": type,
      };
      isLoading(true);
      var classesResponse = await WebService.fetchClassesList(batchData);
      if (classesResponse.data != null) {
        classesList.value = classesResponse.data!;
      }
    } catch (e) {
      // Handle errors if needed
    } finally {
      isLoading(false);
    }
  }


  void  updateClass(BuildContext context,String courseCode,courseId,batchId,batchName,tuitionId ) async  {
      isLoading.value = true;
      try {
        var batchData = {
          "type": "U",
          "tuitionId": tuitionId,
          "course_code": courseCode,
          "courseId": courseId,
          "batchId": batchId,
          "batch_name": batchName,
          "status": "Public"
        };
        final AddClassDataModel? response =
            await WebService.updateClass(batchData);

        if (response != null && response.statusCode == 200) {
       Get.snackbar('Your class is now live',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1));
       // onInit();
          tabController.animateTo(1);
                                    handleTabChange(1);
        //  String currentType = selectedTabIndex.value == 0 ? "Draft" : "Public";
        // fetchClassesList(currentType);
        } else {
         Get.snackbar(response?.message ?? 'Failed to update Enquire');
        }
      } catch (e) {
        //SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
      } finally {
        isLoading.value = false;
      }
   
  }
//  // Update the fetchCourseList method to populate courseCode list
  void fetchCourseList() async {
    try {
      isLoading(true);
      var tutionCourseResponse = await WebService.fetchTuitionCourseList();
      if (tutionCourseResponse.data != null) {
        tutionCourseList.value = tutionCourseResponse.data!;
        courseCode = tutionCourseResponse.data!.map((course) => course.courseCode ?? '').toList();
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  bool validateFields(BuildContext context) {
    validationMessages.clear();
    if (courseCodeController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Course code is required');
      return false;
    }
    if (batchNameController1.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Batch name is required');
      return false;
    }
    return true;
  }

  void addClass(BuildContext context) async {
    if (validateFields(context)) {
      isLoading.value = true;
      final courseDetail = selectedCourseData.value;
      try {
        var batchData = {
          "type": "N",
          "tuitionId": "",
          "course_code": courseDetail.courseCode,
          "courseId": courseDetail.sId,
          "batchId": courseDetail.batchId,
          "batch_name": courseDetail.batchName,
          "status": ""
        };

        final AddClassDataModel? response =
            await WebService.addClass(batchData);

        if (response != null && response.success == true) {
         _clearData();

          SnackBarUtils.showSuccessSnackBar(
              context, 'Class added successfully');
          Get.back();
          //onInit();
           fetchClassesList("Draft");
        } else {
          SnackBarUtils.showErrorSnackBar(
              context, response?.message ?? 'Failed to add Class');
        }
      } catch (e) {
        SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }

  void navigateBack() {
    Get.back();
  }

  void navigateToAddCourseScreen() {
    Get.to(() => TutorClassForm());
  }
 

  // Method to handle course code selection
  void onSelectCourseCode(String courseCode) {
    selectedCourseCode.value = courseCode;
    selectedCourseData.value = tutionCourseList.firstWhere(
      (course) => course.courseCode == courseCode,
      orElse: () => TutionData(),
    );
     batchNameController1.text = selectedCourseData.value.batchName ?? '';
     print(batchNameController1.text);
  }

 @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

   void _clearData(){
         batchNameController1.clear();
        courseCodeController.value='';
    }
}
