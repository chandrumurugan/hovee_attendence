import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/ratings_controller.dart';
import 'package:hovee_attendence/modals/getRatingTutorListModel.dart';
import 'package:intl/intl.dart';

class Ratingcard extends StatelessWidget {
  final Review classReviewData;
  Ratingcard({super.key, required this.classReviewData});

  @override
  Widget build(BuildContext context) {
    final RatingsController controller = Get.put(RatingsController());
    double widthPadding = MediaQuery.of(context).size.width;
    double heightPadding = MediaQuery.of(context).size.height;
    DateTime dateTime = DateTime.parse(classReviewData.updatedAt!.toString());
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    // String? reviewText = getReviewText();
    return Card(
      elevation: 10.0,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width * 0.04,
                  vertical: MediaQuery.sizeOf(context).height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        backgroundImage: classReviewData == []
                            ? CachedNetworkImageProvider("${classReviewData}")
                            : null,
                        radius: 35,
                        child: const Center(
                          child: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.030,
                      ),
                      Text(
                          "${classReviewData.userId!.firstName} ${classReviewData.userId!.lastName}",
                          textScaleFactor: 1.2,
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                    ],
                  ),
                  Text(
                    "${formattedDate}",
                    textScaleFactor: 1.2,
                    style: GoogleFonts.nunito(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 2.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RatingBarIndicator(
                    rating: double.parse(classReviewData.ratingPoints!),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 25.0,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: widthPadding * .02,
                        vertical: heightPadding * .004),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${double.parse(classReviewData.ratingPoints!)}',
                          textScaler: const TextScaler.linear(1.0),
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        SizedBox(
                          width: widthPadding * .010,
                        ),
                        Image.asset(
                          'assets/icons/starbig.png',
                          color: Colors.white,
                          scale: 2.4,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: List.generate(
                  classReviewData.details.length,
                  (index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Index number with a dot
                      Text(
                        '${index + 1}. ',
                        textScaleFactor: 1.1,
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(.7),
                        ),
                      ),
                      // The detail text
                      Expanded(
                        child: Text(
                          classReviewData.details[index],
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
              ),
            ),

            Visibility(
              visible:  classReviewData.comments!.isNotEmpty,
              child: const Divider(
                thickness: 2.0,
              ),
            ),
            classReviewData.comments!.isNotEmpty
                ? Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.030,
                      vertical: MediaQuery.sizeOf(context).height * 0.010,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Comments',
                              textScaleFactor: 1.2,
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black)),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.010,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: widthPadding * 0.04,
                                vertical: heightPadding * 0.00),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Text(
                              classReviewData.comments!,
                              textScaleFactor: 1.2,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

}
