import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/components/tutorHomeComponents.dart';
import 'package:hovee_attendence/modals/getRatingDashboardListModel.dart';
import 'package:hovee_attendence/modals/getRatingTutorListModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/myReview_screen.dart';
import 'package:logger/logger.dart';

import '../modals/getRatingsListModel.dart';

class RatingsController extends GetxController {
  var isLoading = true.obs;
  RatingsData? myreview;
  DasRatingData? myrating;
  var details = <String>[].obs;
  var reviews = <Review>[].obs;
  var ratingsCount = ''.obs;
  List<String> detailsList = [];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getMyRatings();
  }

  void getMyRatings() async {
    // isLoading(true);

    try {
      var myratings = await WebService.getMyRatings();
      if (myratings != null && myratings.statusCode == 200) {
        myrating = myratings.data;
        isLoading(false);
      } else {
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);

      Logger().e(e);
    }
  }

  void getReviews(String courseId) async {
    try {
      var batchData = {
        "courseId": courseId,
      };
      var courseResponse = await WebService.getRatings(batchData);
      if (courseResponse!.data != null) {
        // Store the reviews
        myreview = courseResponse.data!;
        reviews.value = courseResponse.data!.courseDetails!.reviews;

        // Extract details from reviews
        detailsList = reviews.value
            .expand((review) => review.details)
            .toList(); // Flatten and store all details

        // Navigate to the review screen
        Get.to(const MyReviewScreen());
      } else {
        print('Course data is null');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
