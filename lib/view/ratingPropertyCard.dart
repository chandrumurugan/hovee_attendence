import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/ratings_controller.dart';
import 'package:hovee_attendence/modals/getRatingTutorListModel.dart';
import 'package:intl/intl.dart';

class Ratingpropertycard extends StatelessWidget {
  final RatingsData  propertyRR;
   Ratingpropertycard({super.key, required this.propertyRR});

  @override
  Widget build(BuildContext context) {
    final RatingsController controller =
      Get.put(RatingsController());
   double widthPadding = MediaQuery.of(context).size.width;
    double heightPadding = MediaQuery.of(context).size.height;
    DateTime dateTime =
        DateTime.parse(propertyRR.updatedAt!);
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
            child: Center(child: Icon(Icons.person),) ,
            backgroundImage:
            propertyRR==[] ? 
                CachedNetworkImageProvider("${propertyRR}") : null,
            radius: 35,
          ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.030,
                      ),
                      Text(
                          "${propertyRR.userId!.firstName} ${propertyRR.userId!.lastName}",
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
            Divider(
              thickness: 2.0,
            ),
            Container(
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: [

                    Container(
                      color: Colors.white,
                      // surfaceTintColor: Colors.white,
                      // elevation: 20.0,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.18,
                            child: _buildTabContainer(
                              context: context,
                                        widthPadding: widthPadding,
                                        heightPadding: heightPadding,
                                        ratingCount: propertyRR.ratingPoints!,
                                      ratings: propertyRR.ratingPoints!.split(','),
                                        text:
                                            controller.details!),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 2.0,
            ),
            propertyRR.comments != null
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
                                vertical: heightPadding * 0.02),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Text(
                              propertyRR.comments!,
                              textScaleFactor: 1.2,
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _buildTabContainer(
      { required BuildContext context,
        required double widthPadding,
      required double heightPadding,
      required String ratingCount,
      required List<String> text,
      required List<String> ratings,}) {
    var rating = double.parse(ratingCount);
    print(
        "getting values====>${ratingCount}===>${ratings.toList().toString()}");
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ratingCount == ""
              ? Center(
                  child: Text("Ratings will be update on three month cycle"),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Container(
                    //     padding: EdgeInsets.all(5),
                    //     decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.black),
                    //         borderRadius: BorderRadius.circular(8)),
                    //     child: Text('${text}',
                    //         textScaler: TextScaler.linear(1.2),
                    //         style: GoogleFonts.nunito(
                    //             fontWeight: FontWeight.w600,
                    //             color: Colors.black)),
                    //   ),
                    // ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: rating,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 25.0,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(
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
                                '${rating}',
                                textScaler: TextScaler.linear(1.0),
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
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
                    SizedBox(height: heightPadding * 0.002),
                   Column(
  children: List.generate(
    text.length,
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
            text[index],
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

                  ],
                ),
        ),
      ),
    );
  }
}
