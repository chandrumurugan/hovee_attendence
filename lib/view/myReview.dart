import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/modals/getRatingDashboardListModel.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
class MyReviews extends StatelessWidget {
   MyReviews({super.key, required this.review});
final List<BestReviews> review;
 final controller = PageController(viewportFraction: 1.0);
  final _controller = SuperTooltipController();
  @override
  Widget build(BuildContext context) {
    double widthPadding = MediaQuery.of(context).size.width;
    double heightPadding = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: widthPadding * .04, vertical: heightPadding * .01),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                        text: 'My Reviews',
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.black),
                        children: [
                        ]),
                  ),
              
                  SuperTooltip(
                    showBarrier: true,
                    controller: _controller,
                    showDropBoxFilter: false,
                    popupDirection: TooltipDirection.down,
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Understand How Our Rating System Works!",
                            softWrap: true,
                            style: GoogleFonts.nunito(
                                color: AppConstants.secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "1. Authentic Reviews",
                            softWrap: true,
                            style: GoogleFonts.nunito(
                                color: AppConstants.secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Our platform encourages genuine feedback from current and former residents. "
                            "Users can submit reviews quarterly, which allows them to really get to know their collaborator.",
                            softWrap: true,
                            style: GoogleFonts.nunito(
                                color: Colors.black, fontSize: 14),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "2. Thorough Review Screening",
                            softWrap: true,
                            style: GoogleFonts.nunito(
                                color: AppConstants.secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "We ensure the quality of our reviews through manual screening. "
                            "Our team meticulously checks each review to maintain the highest standards of authenticity.",
                            softWrap: true,
                            style: GoogleFonts.nunito(
                                color: Colors.black, fontSize: 14),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "3. Scoring-Based Rating Calculation",
                            softWrap: true,
                            style: GoogleFonts.nunito(
                                color: AppConstants.secondaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Our ratings are based on a scoring system where users rate their experiences on a scale of 1 to 5. "
                            "Additionally, users rate specific aspects of the property or locality. "
                            "This detailed approach ensures a nuanced overall rating.",
                            softWrap: true,
                            style: GoogleFonts.nunito(
                                color: Colors.black, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.info,
                        color: AppConstants.secondaryColor,
                      ),
                      onPressed: () async {
                        await _controller.showTooltip();

                        // Action when the icon is pressed
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
       ... List.generate(
          review[0].details!.length,
                (indexs) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: AppConstants.secondaryColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.84,
                                      child: Text(
                                       review[0].details![indexs],
                                        textScaleFactor: 1.1,
                                        style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
        )
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.07,
          //   child: PageView.builder(
          //     controller: controller,
          //     itemCount: review.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Container(
          //         padding: const EdgeInsets.all(5),
          //         decoration: BoxDecoration(
          //             border: Border.all(
          //                 color: AppConstants.primaryColor),
          //             borderRadius: BorderRadius.circular(8)),
          //         child: Text(
          //           review[index].toString(),
          //           overflow: TextOverflow.ellipsis,
          //           // ignore: deprecated_member_use
          //           textScaleFactor: 1.2,
          //           style: GoogleFonts.nunito(
          //             fontWeight: FontWeight.bold,
          //             color: AppConstants.primaryColor,
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          ,
          SizedBox(
            height: 15,
            child: SmoothPageIndicator(
              controller: controller,
              count: review.length,
              effect: ExpandingDotsEffect(
                dotHeight: ScreenUtils.calculateHeightPercentage(context, 60),
                dotWidth: ScreenUtils.calculateWidthPercentage(context, 40),
                dotColor: const Color.fromRGBO(237, 181, 46, 0.4),
                activeDotColor: AppConstants.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ScreenUtils {
  static double calculateWidthPercentage(BuildContext context, double value) {
    final screenWidth = MediaQuery.of(context).size.width;
    return (value / screenWidth) * 100;
  }

  static double calculateHeightPercentage(BuildContext context, double value) {
    final screenHeight = MediaQuery.of(context).size.height;
    return (value / screenHeight) * 100;
  }
}
