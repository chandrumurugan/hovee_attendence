import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:hovee_attendence/components/tutorHomeComponents.dart';
import 'package:hovee_attendence/modals/getRatingDashboardListModel.dart';
import 'package:hovee_attendence/modals/getRatingTutorListModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/myProperties_screen.dart';
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

    // WebService.getMyRatings().then((value) {
    //   try {
    //     if (value!.statusCode == 200) {
    //       myrating = value.data!;
    //       isLoading(false);
    //     } else {
    //       isLoading(false);

    //       print("error while fetching get rating");
    //     }

    //     isLoading(false);
    //   } catch (e) {
    //     isLoading(false);

    //     Logger().e(e);
    //   }
    // });
  }

//    void getReviews(String courseId) async {
//   try {
//     var batchData = {
//       "courseId": courseId,
//     };
//     var courseResponse = await WebService.getRatings(batchData);
//     if (courseResponse!.data != null) {
//       // Assign the received data to `myreview`
//       myreview = courseResponse.data!.courseDetails!;

//       // Extract the details from each RatingsData object and store in a new list
  // List<String> allDetails = [];
  // for (var rating in courseResponse.data!) {
  //   if (rating.details != null) {
  //     allDetails.addAll(rating.details!); // Add all details to the list
  //   }
  // }

  // details.value = allDetails; // Update your details list
  // print("Extracted details: $allDetails");

//       // Navigate to the review screen
//       Get.to(MypropertiesReviewScreen());
//     } else {
//       print('Course data is null');
//     }
//   } catch (e) {
//     print('Error: $e');
//   } finally {
//     isLoading(false);
//   }
// }

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
        Get.to(const MypropertiesReviewScreen());
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
