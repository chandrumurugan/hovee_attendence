import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/ratings_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/view/myPropertyList.dart';
import 'package:hovee_attendence/view/myReview.dart';
import 'package:hovee_attendence/widget/rating_profile.dart';
import 'package:hovee_attendence/widget/ratingsContainer.dart';

class MyRatingsScreen extends StatelessWidget {
  final bool fromBottomNav;
    final String type;
     final VoidCallback? onDashBoardBack;

  MyRatingsScreen({super.key, required this.fromBottomNav, required this.type, this.onDashBoardBack,});

  @override
  Widget build(BuildContext context) {
    final RatingsController controller =
        Get.put(RatingsController(), permanent: true);
    double widthPadding = MediaQuery.of(context).size.width;
    double heightPadding = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBarHeader(
            needGoBack: fromBottomNav,
            navigateTo: () {
             if (fromBottomNav && onDashBoardBack != null) {
            // Call onDashBoardBack if navigating from bottom navigation
            onDashBoardBack!();
          } else {
            // Navigate to Dashboard if not from bottom navigation
            Get.offAll(DashboardScreen(
              rolename: type,
            ));
          }
            }),
        body: Obx(() {
          if (controller.isLoading.value) {
            // Call your refresh logic here, e.g., re-fetch data
            // Reset the refresh state
            return const Center(child: CircularProgressIndicator());
          } else if (controller.myrating == null) {
            // Call your refresh logic here, e.g., re-fetch data
            // Reset the refresh state
            return const Center(child: Text("No data found"));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                RatingProfile(
                  profileImage: null ?? "",
                  wowId: controller.myrating!.wowId!,
                  name:
                      "${controller.myrating!.firstName} ${controller.myrating!.lastName}",
                  starRating: double.parse(
                      controller.myrating!.ratings!.averageRating!),
                  ratedUser: controller.myrating!.ratings!.totalRatings!,
                ),
                const Divider(),
                controller.myrating != null
                    ? MyReviews(
                        review: controller.myrating!.ratings!.bestReviews!,
                      )
                    : const SizedBox.shrink(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widthPadding * .04,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' My Classes',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          print("object");
                          Get.to(const MyReviewClasslist());
                        },
                        child: Text(' See all',
                            style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.secondaryColor)),
                      )
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    final address =
                        '${controller.myrating!.doorNo}, ${controller.myrating!.street}, ${controller.myrating!.city}, ${controller.myrating!.state} ${controller.myrating!.country}';
                    return InkWell(
                      onTap: () {
                        controller.getReviews(controller
                            .myrating!.ratings!.courseDetails![index].sId!);
                      },
                      child: RatingConatiner(
                        reviewImage: null ?? '',
                        reviewAddress:
                            //'${propertyRR!.propertyDetails!.location!.street!},${propertyRR!.propertyDetails!.location!.city!}',
                            address,
                        reviewShortName: controller
                            .myrating!.ratings!.courseDetails![index].subject!,
                        expectedRent: controller
                            .myrating!.ratings!.courseDetails![index].subject!,
                        userRatedCount:
                            controller.myrating!.ratings!.averageRating!,
                        userRating: controller
                                    .myrating!.ratings!.totalRatings !=
                                null
                            ? controller.myrating!.ratings!.totalRatings!
                            // ? propertyRR!
                            //     .tenants!.current!.reviews?.quarter1?.rating
                            : "0.0", //propertyRR!.overallRating!.toDouble()
                        propertyCategory: controller
                            .myrating!.ratings!.courseDetails![index].subject!, batchName: controller
                            .myrating!.ratings!.courseDetails![index].batchName!,
                            board: controller
                            .myrating!.ratings!.courseDetails![index].board!, className: controller
                            .myrating!.ratings!.courseDetails![index].className!,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }));
  }
}
