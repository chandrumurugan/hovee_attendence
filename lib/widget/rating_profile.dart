import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingProfile extends StatefulWidget {
  final String profileImage;
  final String name;
  final String wowId;
  final double starRating;
  final int ratedUser;
  RatingProfile(
      {super.key,
      required this.profileImage,
      required this.name,
      required this.wowId,
      required this.starRating,
      required this.ratedUser});

  @override
  State<RatingProfile> createState() => _RatingProfileState();
}

class _RatingProfileState extends State<RatingProfile> {
  @override
  Widget build(BuildContext context) {
    double widthPadding = MediaQuery.of(context).size.width;
    double heightPadding = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(vertical: heightPadding * .02),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200], 
            child: widget.profileImage.isEmpty ? Center(child: Icon(Icons.person),) : null ,
            backgroundImage:
            widget.profileImage.isNotEmpty ? 
                CachedNetworkImageProvider("${widget.profileImage}") : null,
            radius: 35,
          ),
          SizedBox(
            height: heightPadding * .010,
          ),
          Text(
            "${widget.name}",
            textScaleFactor: 1.6,
            style: GoogleFonts.nunito(
                fontWeight: FontWeight.w600, color: Colors.black),
          ),
          SizedBox(
            height: heightPadding * .010,
          ),
          Text(
            "ID: ${widget.wowId}",
            textScaleFactor: 1.2,
            style: GoogleFonts.nunito(
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          SizedBox(height: heightPadding * .010),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: widthPadding * .02, vertical: heightPadding * .004),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${widget.starRating}",
                    textScaleFactor: 1.2,
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w700, color: Colors.white)),
                SizedBox(
                  width: widthPadding * .010,
                ),
                Image.asset(
                  'assets/icons/starbig.png',
                  color: Colors.white,
                  scale: 2.2,
                ),
              ],
            ),
          ),
          SizedBox(
            height: heightPadding * .010,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBarIndicator(
                rating: widget.starRating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 25.0,
                direction: Axis.horizontal,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widthPadding * .040),
                child: Container(
                  height: heightPadding * .020,
                  width: widthPadding * .004,
                  color: Colors.black,
                ),
              ),
              Text(
                '${widget.ratedUser} Rated',
                textScaleFactor: 1.2,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(.5),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
