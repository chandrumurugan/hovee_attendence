import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/ratings_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/widget/ratingsContainer.dart';

class MyReviewClasslist extends StatelessWidget {
  const MyReviewClasslist({super.key});

  @override
  Widget build(BuildContext context) {
    final RatingsController controller = Get.put(RatingsController());
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          Get.back();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Text(
              'My classes',
              style: GoogleFonts.nunito(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.myrating == []) {
                // Display "No data found" when the list is empty
                return Center(
                  child: Text(
                    'No list found',
                    style: GoogleFonts.nunito(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                  ),
                );
              } else {
                // Display the list of batches
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.myrating!.ratings!.courseDetails!.length,
                  itemBuilder: (context, index) {
                    final course = controller.myrating!.ratings!.courseDetails![index];
                    final address =
                        '${controller.myrating!.doorNo}, ${controller.myrating!.street}, ${controller.myrating!.city}, ${controller.myrating!.state} ${controller.myrating!.country}';
                    return GestureDetector(
                      onTap: () {
                        controller.getReviews(course.sId!);
                      },
                      child: RatingConatiner(
                        reviewImage: null ?? '',
                        reviewAddress: address,
                        reviewShortName: course.subject!,
                        expectedRent: course.subject!,
                        userRatedCount: controller.myrating!.ratings!.averageRating!,
                        userRating: controller.myrating!.ratings!.totalRatings != null
                            ? controller.myrating!.ratings!.totalRatings!
                            : "0.0",
                        propertyCategory: course.subject!, batchName: course.batchName!, board: course.board!, className: course.className!,
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
