// controllers/batch_controller.dart
import 'package:get/get.dart';
import 'package:hovee_attendence/modals/getbatchlist_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/add_batch.dart';



class BatchController extends GetxController {
  var batchList = <Data>[].obs;
  var isLoading = true.obs;

  // Method to fetch batch list
  void fetchBatchList() async {
    try {
      isLoading(true);
      var batchResponse = await WebService.fetchBatchList();
      if (batchResponse.data != null) {
        batchList.value = batchResponse.data!;
      }
    } catch (e) {
      Get.snackbar('Failed to fetch batches');
    } finally {
      isLoading(false);
    }
  }

  void navigateToAddBatchScreen() {
    Get.to(() => TutorAddBatchScreen());
  }

  void navigateBack() {
    Get.back();
  }
}
