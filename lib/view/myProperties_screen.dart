import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/ratings_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/view/ratingPropertyCard.dart';
import 'package:hovee_attendence/widget/ratingsPropertiesContainer.dart';

class MypropertiesReviewScreen extends StatelessWidget {
  const MypropertiesReviewScreen({super.key});

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
      body: Container(
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
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.myreview.isEmpty) {
                return const Center(child: Text('No Ratings Available'));
              }
              return Container(
                height: MediaQuery.of(context).size.height * 0.800,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.myreview.length,
                  itemBuilder: (context, index) {
                    final rating = controller.myreview[index];
                    final address =
                        '${controller.myrating!.doorNo}, ${controller.myrating!.street}, ${controller.myrating!.city}, ${controller.myrating!.state} ${controller.myrating!.country}';
                        controller.ratingsCount.value=controller.myrating!.ratings!.totalRatings!.toString();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RatingPropertyConatiner(
                          propertyImage: null ?? '',
                          propertyAddress: address,
                          propertyShortName: rating.courseId!.subject!,
                          expectedRent: rating.courseId!.subject!,
                          userRatedCount: rating.ratingPoints!,
                          userRating: controller.ratingsCount.value,
                          propertyCategory: rating.courseId!.subject!,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Tutee',
                          textScaleFactor: 1.4,
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                        Ratingpropertycard(
                          propertyRR: rating, // Pass the current rating directly
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.020,
                        ),
                      ],
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
