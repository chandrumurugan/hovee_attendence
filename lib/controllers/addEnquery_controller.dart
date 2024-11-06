import 'package:get/get.dart';
import 'package:hovee_attendence/services/webServices.dart';

class AddEnqueryController extends GetxController {
  //course category
  var courseCategories = <String>[].obs;
  var selectedIndex = 0.obs;
  var isLoadingcategory = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourseCategory();
  }

  void fetchCourseCategory() async {
    isLoadingcategory(true);
    var response = await WebService.fetchCoursecategory();

    if (response.isNotEmpty) {
      courseCategories.assignAll(response);
      // courseCategories.value = response;
      isLoadingcategory(false);
    }
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
    update();
  }
}
