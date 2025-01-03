// controllers/batch_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/batch_controller.dart';
import 'package:hovee_attendence/modals/add_course_data_model.dart';
import 'package:hovee_attendence/modals/appConfigModal.dart';
import 'package:hovee_attendence/modals/deletebatch_model.dart';
import 'package:hovee_attendence/modals/getCouseList_model.dart';

import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/add_course_screen.dart';
import 'package:logger/logger.dart';



class CourseController extends GetxController {
  var courseList = <Data1>[].obs;
  var isLoading = true.obs;
  var batchNameController = ''.obs;
    var boardController = ''.obs;
     var classController = ''.obs;
      var subjectController = ''.obs;
       var remarksController = ''.obs;
  //     var courseShortNameController = ''.obs;
  String? selectedBatchId;
  var validationMessages = <String>[].obs;

  List<String> batchName = [];
   List<String> board = [];
   RxList<String> classList = <String>[].obs;
   RxList<String> subject = <String>[].obs;
   var appConfig = AppConfig().obs;

    final remarks = TextEditingController();

     var selectedCourseCode = ''.obs;
  // Observable to store course codes
  var courseCodes = <String>[].obs;

  var selectedCourseDetails = Data1().obs; // Observable to store selected course details
  var courseList1 = <Data1>[].obs;

  final BatchController controller = Get.put(BatchController());

  var filteredCourseList = [].obs; // Filtered list for display
  var searchKey = ''.obs;
  List<String> batchNamebyCourse = [];
   RxBool initialLoad = true.obs;
  // Method to fetch batch list
//   void fetchCourseList() async {
//   try {
//     isLoading(true);
//     var courseResponse = await WebService.fetchCourseList();
//     if (courseResponse.data != null) {
//       print('Course data fetched: ${courseResponse.data}');
//       courseList.value = courseResponse.data!;
      
//       // Extract the course codes into a List<String>
//       // Extract the course codes into a List<String>
//         courseCodes.value = courseResponse.data!
//             .map((course) => course.courseCode ?? '') // Handle null values for courseCode
//             .where((code) => code.isNotEmpty) // Filter out empty codes
//             .toList();
//       // Store the complete course data and courseCode list in GetStorage
//       final storage = GetStorage();
//       storage.write('courseList',courseResponse.data!.map((batch) => batch.courseCode ?? '').toList());
//       storage.write('courseCode', courseCodes);

//     } else {
//       print('Course data is null');
//     }
//   } catch (e) {
//     print('Error: $e');
//     //  SnackBarUtils.showSuccessSnackBar(context,'Failed to fetch course');
//   } finally {
//     isLoading(false);
//   }
// }




  void fetchCourseList({String searchTerm = ''}) async {
  try {
     isLoading.value=true;
     initialLoad.value=true;
    var courseResponse = await WebService.fetchCourseList(searchTerm);
    if (courseResponse.data != null) {
      print('Course data fetched: ${courseResponse.data}');
      courseList.value = courseResponse.data!;
      
      // Extract the course codes into a List<String>
      // Extract the course codes into a List<String>
        courseCodes.value = courseResponse.data!
            .map((course) => course.courseCode ?? '') // Handle null values for courseCode
            .where((code) => code.isNotEmpty) // Filter out empty codes
            .toList();
      // Store the complete course data and courseCode list in GetStorage
      final storage = GetStorage();
      storage.write('courseList',courseResponse.data!.map((batch) => batch.courseCode ?? '').toList());
      storage.write('courseCode', courseCodes);

    } else {
      print('Course data is null');
    }
  } catch (e) {
    print('Error: $e');
    //  SnackBarUtils.showSuccessSnackBar(context,'Failed to fetch course');
  } finally {
     isLoading.value=false;
     initialLoad.value=false;
  }
}

 void fetchBatchList({String searchTerm = '', String type = ''}) async {
  try {
    isLoading.value = true; // Start loading

    // Prepare the request payload
    final requestPayload = {
      'searchTerm': searchTerm,
       'key': 'Course',
    };

    // Fetch batch list from the API
    var batchResponse = await WebService.fetchBatchList(requestPayload);

    if (batchResponse.data != null) {
    
      // Update batch naes based on the type
     
        batchNamebyCourse = batchResponse.data!
            .map((batch) => batch.batchName ?? '')
            .toList();
      

      // Map batch names to their IDs for later retrieval
    } else {
     
    }
  } catch (e) {
    print('Error fetching batch list: $e');
  } finally {
    isLoading.value = false; // Stop loading
  }
}



 void fetchCourseDetails(String courseCode) {
    var course = courseList.firstWhere(
      (c) => c.courseCode == courseCode,
      orElse: () => Data1(),
    );
    selectedCourseDetails.value = course; // Update selected course details
  }

   void navigateToAddCourseScreen() {
    Get.to(() => TutorAddCourseScreen());
  }

  void navigateBack() {
    Get.back();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchCourseList();
    fetchAppConfig();
    fetchBatchList();
    _clearData();
  }

   void setBoard(String value) {
  boardController.value = value;
   updateClassList(value);
}

void setBatchName(String value) {
  batchNameController.value = value;
  selectedBatchId = controller.batchIdMap[value];
  Logger().i('Selected Batch ID: $selectedBatchId');
}

void setClass(String value) {
  classController.value = value;
   updateSubjectList(value);
}

void setSubject(String value) {
  subjectController.value = value;
}
 Future<void> fetchAppConfig() async {
    try {
      var response = await WebService.fetchAppConfig();
      if (response != null) {
        appConfig.value = response;
        
        // Store the response data in GetStorage
        final storage = GetStorage();
        storage.write('appConfig', response.toJson());
batchName = (storage.read<List<dynamic>>('batchList') ?? [])
    .map((item) => item.toString()) 
    .toList();
        // Create board list by explicitly casting each part of the chain
        board = response.data?.studentCategory
            ?.expand((category) => category.label?.labelData ?? [])
            .map((labelData) => labelData.board ?? '')
            .where((board) => board.isNotEmpty)
            .toSet() // Removes duplicates
            .cast<String>() // Ensures all items are strings
            .toList() ?? [];

        Logger().i('AppConfig loaded successfully');
      } else {
        Logger().e('Failed to load AppConfig');
      }
    } catch (e) {
      Logger().e(e);
    }
  }




  void updateClassList(String board) {
    boardController.value = board;
    classList.value = appConfig.value.data?.studentCategory
            ?.expand((category) => category.label?.labelData ?? [])
            .where((labelData) => labelData.board == board)
            .expand((labelData) => labelData.classes ?? [])
            .map((classItem) => classItem.className ?? '')
            .where((className) => className.isNotEmpty)
            .toSet() // Removes duplicates
            .cast<String>() // Ensures all items are strings
            .toList() ?? [];
  }

  void updateSubjectList(String className) {
    classController.value = className;
    subject.value = appConfig.value.data?.studentCategory
            ?.expand((category) => category.label?.labelData ?? [])
            .expand((labelData) => labelData.classes ?? [])
            .where((classItem) => classItem.className == className)
            .expand((classItem) => classItem.subjects ?? [])
            .map((subject) => subject.name ?? '')
            .where((subjectName) => subjectName.isNotEmpty)
            .toSet()
            .cast<String>()
            .toList() ?? [];
  }
  
   bool validateFields(BuildContext context) {
    validationMessages.clear();
    if (batchNameController.value.isEmpty) {
       SnackBarUtils.showErrorSnackBar(context,'Batch name is required',);
      return false;
    }
    if (boardController.value.isEmpty) {
       SnackBarUtils.showErrorSnackBar(context,'Board is required',);
      return false;
    }
    if (classController.value.isEmpty) {
       SnackBarUtils.showErrorSnackBar(context,'Class is required',);
      return false;
    }
    
    
    if (subjectController.value.isEmpty) {
       SnackBarUtils.showErrorSnackBar(context,'Subject is required',);
      return false;
    }
    // if (remarks.text.isEmpty) {
    //   SnackBarUtils.showErrorSnackBar(context, 'Batch timing End is required');
    //   return false;
    // }
     return true;
   }

  void addCourse(BuildContext context) async {
    if (validateFields(context)) {
      isLoading.value = true;
      try {
        var batchData = {
          'batch_name': batchNameController.value,
          'board': boardController.value,
          'class_name': classController.value,
          'subject': subjectController.value,
          'remarks': '',
           'course_image':'',
          'courseId':'',
             "type": "N",
             "batchId": selectedBatchId,
         
        };
          
        final AddCourseDataModel? response = await WebService.addCourse(batchData);

        if (response != null && response.success == true) {
          _clearData();
           SnackBarUtils.showSuccessSnackBar(context,'Course added successfully',);
        //    SnackBarUtils.showSuccessSnackBar(context,
        // 'Course added successfully',,);
          //SnackBarUtils.showSuccessSnackBar(context,'Course added successfully',,);
           Get.back();
           onInit();
        } else {
            SnackBarUtils.showSuccessSnackBar(context, response?.message ?? 'Failed to add Course',);
        }
      } catch (e) {
         SnackBarUtils.showSuccessSnackBar(context, 'Error: $e',);
      } finally {
        isLoading.value = false;
      }
    }
  
}


  void _clearData(){
         batchNameController.value = '';
          boardController.value = '';
          classController.value = '';
          subjectController.value = '';
    }

    
  //   void filterCourseList() {
  //   if (searchKey.value.isEmpty) {
  //     // If search key is empty, show all batches
  //     filteredCourseList.assignAll(courseList);
  //   } else {
  //     // Filter batch list based on search key
  //    filteredCourseList.assignAll(
  //     courseList.where((course) => 
  //       (course.subject?.toLowerCase().contains(searchKey.value.toLowerCase()) ?? false) ||
  //       (course.board?.toLowerCase().contains(searchKey.value.toLowerCase()) ?? false) ||
  //       (course.courseCode?.toLowerCase().contains(searchKey.value.toLowerCase()) ?? false)
  //     ).toList(),
  //   );
    
  //   }
  // }

  void deleteCourse(BuildContext context, String courseId) async {
    isLoading.value = true;
    try {
      var courseData = {
        "courseId": courseId,
      };

      final deleteBatchDataModel? response =
          await WebService.deleteCourse(courseData);

      if (response != null && response.success == true) {
        _clearData();
        fetchCourseList();
        SnackBarUtils.showSuccessSnackBar(context, 'Course delete successfully');
        //  Get.back();
        //  onInit();
      } else {
      Get.snackbar(response?.message ?? "");
       
        // SnackBarUtils.showErrorSnackBar(
        //     // ignore: use_build_context_synchronously
        //     context, response?.message ?? 'Failed to delete course');
      }
    } catch (e) {
         Get.snackbar(e.toString().replaceFirst("Exception: ", "") ?? "",backgroundColor: AppConstants.primaryColor,colorText: Colors.white);
      
        // SnackBarUtils.showErrorSnackBar(
        //     // ignore: use_build_context_synchronously
        //     context, e.toString() );
      // SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
     
      Logger().e("delete course==>${e}");
    } finally {
      isLoading.value = false;
    }
  }

  void updateCourse(BuildContext context,String courseId) async {
     if (validateFields(context)) {
      isLoading.value = true;
      try {
        var batchData = {
          'batch_name': batchNameController.value,
          'board': boardController.value,
          'class_name': classController.value,
          'subject': subjectController.value,
          'remarks': '',
           'course_image':'',
          'courseId':courseId,
             "type": "U",
             "batchId": selectedBatchId,
         
        };
          
        final AddCourseDataModel? response = await WebService.addCourse(batchData);

        if (response != null && response.success == true) {
          _clearData();
           SnackBarUtils.showSuccessSnackBar(context,'Course updated successfully',);
        //    SnackBarUtils.showSuccessSnackBar(context,
        // 'Course added successfully',,);
          //SnackBarUtils.showSuccessSnackBar(context,'Course added successfully',,);
           Get.back();
           onInit();
        } else {
            SnackBarUtils.showSuccessSnackBar(context, response?.message ?? 'Failed to updated Course',);
        }
      } catch (e) {
         SnackBarUtils.showSuccessSnackBar(context, 'Error: $e',);
      } finally {
        isLoading.value = false;
      }
    }
  }

}
