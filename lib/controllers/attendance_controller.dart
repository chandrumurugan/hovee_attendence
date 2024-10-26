
import 'package:get/get.dart';
import 'package:hovee_attendence/services/webServices.dart';

class AttendanceCourseListController extends GetxController {
  var attendanceCourseList = [].obs;
  var isLoading = true.obs;


@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAttendanceCourseList();
  }

    void fetchAttendanceCourseList() async {
    try {
      isLoading(true);
      var attendanceCourseResponse = await WebService.fetchAttendanceCourseList();
      if (attendanceCourseResponse.data != null) {
        attendanceCourseList.value = attendanceCourseResponse.data!;
      }
    } catch (e) {
      // Get.snackbar('Failed to fetch batches');
    } finally {
      isLoading(false);
    }
  }

}