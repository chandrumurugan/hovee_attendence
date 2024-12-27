import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/ratings_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/view/ratingCard.dart';
import 'package:hovee_attendence/widget/ratingsContainer.dart';

class MyReviewScreen extends StatelessWidget {
  const MyReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RatingsController controller = Get.put(RatingsController());
    return Scaffold(
        appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            Get.back();
          },
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width * 0.024,
                  ),
                  color: Colors.grey.shade200,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          ' My Class | Reviews',
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        controller.myreview == []
                            ? const Center(child: Text('No Ratings Available'))
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    RatingConatiner(
                                      reviewImage: null ?? '',
                                      reviewAddress: controller
                                          .myreview!.courseDetails!.address!,
                                      reviewShortName: controller
                                          .myreview!.courseDetails!.subject!,
                                      expectedRent: controller
                                          .myreview!.courseDetails!.subject!,
                                      userRatedCount: controller
                                          .reviews.value[0].ratingPoints!,
                                      userRating: controller.ratingsCount.value,
                                      propertyCategory: controller
                                          .myreview!.courseDetails!.subject!,
                                    ),
                                    Text(
                                      'Tutee list',
                                      textScaleFactor: 1.4,
                                      style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black),
                                    ),
                                    Column(
                                      children:
                                          controller.myreview!.courseDetails!.reviews.map((rating) {
                                        return Ratingcard(
                                          classReviewData:
                                              rating, // Pass the current rating directly
                                        );
                                      }).toList(),
                                    )
                                  ])
                      ])));
        })
        );
  }
}
