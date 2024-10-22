// controllers/batch_controller.dart
import 'package:get/get.dart';
import 'package:hovee_attendence/modals/getCouseList_model.dart';

import 'package:hovee_attendence/services/webServices.dart';



class CourseController extends GetxController {
  var courseList = <Data>[].obs;
  var isLoading = true.obs;

  // Method to fetch batch list
  void fetchCourseList() async {
  try {
    isLoading(true);
    var courseResponse = await WebService.fetchCourseList();
    if (courseResponse.data != null) {
      print('Course data fetched: ${courseResponse.data}');
      courseList.value = courseResponse.data!;
    } else {
      print('Course data is null');
    }
  } catch (e) {
    print('Error: $e');
    Get.snackbar('Failed to fetch course');
  } finally {
    isLoading(false);
  }
}


   void navigateToAddCourseScreen() {
   // Get.to(() => TutorAddBatchScreen());
  }

  void navigateBack() {
    Get.back();
  }
}
