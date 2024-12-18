import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/components/tutorHomeComponents.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:logger/logger.dart';

import '../modals/getRatingsListModel.dart';

class RatingsController extends GetxController {

  bool isRated = false;
  double ratings = 0.0;
    var isLoading = false.obs;
  var showSubCategoriesList = false.obs;
  Map<String, bool> selectedCheckboxes = {};
  String categoryName = '';
  double baseRating = 0.0;
  double finalRating = 0.0;
  List<String>? selectedSubcategories=[];
 

  void updateSelectedSubcategories(int rating) async {
  try {
    var batchData = {
      "stars": rating, // Send the selected rating
    };

    isLoading(true); // Show a loading indicator

    // Fetch data from the API
    var result = await WebService.updateSelectedSubcategories(batchData);

    if (result != null && result.data != null) {
      // Parse and update the details list
      selectedSubcategories = result.data!.details ?? [];
    }
  } catch (e) {
    // Handle errors if needed
  } finally {
    isLoading(false); // Hide loading indicator
  }
}

}