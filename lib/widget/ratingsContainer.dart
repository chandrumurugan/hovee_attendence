import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';

class RatingConatiner extends StatefulWidget {
  final String reviewImage;
  final String reviewAddress;
  final String reviewShortName;
  final String expectedRent;
  final String userRatedCount;
  final String batchName;
  final String board;
  final String className;
  final dynamic userRating;
  final String propertyCategory;
  final bool? isEnrolled;
  RatingConatiner({
    super.key,
    required this.reviewImage,
    required this.reviewAddress,
    required this.reviewShortName,
    required this.expectedRent,
    required this.userRatedCount,
    required this.userRating,
    required this.propertyCategory,
    this.isEnrolled, required this.batchName, required this.board, required this.className,
  });

  @override
  State<RatingConatiner> createState() => _RatingPropertyState();
}

class _RatingPropertyState extends State<RatingConatiner> {
  bool isFavourite = true;
  void onTapFavourite() {
    isFavourite = !isFavourite;
    print(isFavourite);
  }

  @override
  Widget build(BuildContext context) {
    double widthPadding = MediaQuery.of(context).size.width;
    double heightPadding = MediaQuery.of(context).size.height;
    double roundedValue;
    print("getting rztings value===>${widget.userRatedCount}");
    try {
      double doubleValue = double.parse(widget.userRatedCount.toString());
      roundedValue = doubleValue;
    } catch (e) {
      roundedValue = 0; // Default value in case of conversion failure
      print("Error parsing userRating: $e");
    }
    return Card(
      elevation: 5,
      surfaceTintColor: Colors.transparent,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            horizontal: widthPadding * 0.020, vertical: heightPadding * 0.007),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: widthPadding * 0.20,
                                  height: heightPadding * 0.15,
                                  // padding: EdgeInsets.all(5),
                                  child: 
                                  CircleAvatar(
            backgroundColor: Colors.grey[200], 
            child: widget.reviewImage.isEmpty ? Center(child: Icon(Icons.person),) : null ,
            backgroundImage:
            widget.reviewImage.isNotEmpty ? 
                CachedNetworkImageProvider("${widget.reviewImage}") : null,
            radius: 35,
          ),
                                ),
                              ),
                              if (widget.isEnrolled != null &&
                                  widget.isEnrolled!)
                                Positioned(
                                  left: 10,
                                  top: 10,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.green,
                                          radius: 5,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Active",
                                          style: GoogleFonts.nunito(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: widthPadding * .03,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${widget.reviewShortName}',
                              textScaleFactor: 1.10,
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                                    Text('${widget.batchName}',
                              textScaleFactor: 1.10,
                             style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black)),
                                  Row(
                          children: [
                            Text(
                              widget.className,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 1,
                              width: 10,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.board,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            
                          ],
                        ),
                          SizedBox(
                            width: 160,
                            child: Text('${widget.reviewAddress}.',
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                textScaleFactor: 1.0,
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(.5))),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              RatingBarIndicator(
                                rating: roundedValue,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 20.0,
                                direction: Axis.horizontal,
                              ),
                              SizedBox(
                                width: widthPadding * .040,
                              ),
                              Text('${widget.userRatedCount}', //
                                  style: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
