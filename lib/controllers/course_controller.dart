// controllers/batch_controller.dart
import 'package:get/get.dart';
import 'package:hovee_attendence/modals/getCouseList_model.dart';

import 'package:hovee_attendence/services/webServices.dart';



class CourseController extends GetxController {
  var courseList = <CouseData>[].obs;
  var isLoading = true.obs;

  // Method to fetch batch list
  void fetchCourseList() async {
    try {
      isLoading(true);
      var courseResponse = await WebService.fetchCourseList();
      if (courseResponse.data != null) {
        courseList.value = courseResponse.data!;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch course');
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
