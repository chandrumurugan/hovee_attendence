
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/view/add_batch.dart';
import 'package:hovee_attendence/view/add_leave_screen.dart';

class TuteeLeaveController extends GetxController {



  void navigateToAddBatchScreen() {
    Get.to(() => TuteeAddLeaveScreen());
  }
}