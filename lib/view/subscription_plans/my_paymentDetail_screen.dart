import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/widget/pdf_view_screen.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class MyPaymentDetailScreen extends StatelessWidget {
   final paymentDetail;
  const MyPaymentDetailScreen({super.key, this.paymentDetail});

  @override
  Widget build(BuildContext context) {
    var paymentDetail;
    Logger().d(paymentDetail.toJson());
    // Logger().d(paymentDetail.id);
    // Logger().d(paymentDetail.method);
    return Scaffold(
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppConstants.secondaryColor,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: CachedNetworkImage(
                        imageUrl: "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(
                          Icons.shopping_bag_outlined,
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Plan name : ${paymentDetail.name}",
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "₹ ${paymentDetail.price}",
                style: GoogleFonts.nunito(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (paymentDetail.status == "Paid")
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    )
                  else
                    Icon(
                      Icons.cancel_presentation_outlined,
                      color: Colors.red,
                    ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${paymentDetail.status}",
                    style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
                indent: 80,
                endIndent: 80,
              ),
              SizedBox(
                height: 10,
              ),
              if (paymentDetail.status == "Paid")
                Text(DateFormat("d MMM yyyy")
                    .format(DateTime.parse(paymentDetail.purchaseDate!))),
              SizedBox(
                height: 20,
              ),
              Container(
                // height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppConstants.secondaryColor, width: 1.0)),
                padding: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment),
                          Text(
                            paymentDetail.invoice,
                            style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          )
                        ],
                      ),
                      if (paymentDetail.status == "Paid") Divider(),
                      if (paymentDetail.status == "Paid")
                        _buildDetail(
                            "Expiry date",
                            DateFormat("dMMMyyyy").format(
                                DateTime.parse(paymentDetail.expiryDate!))),
                      if (paymentDetail.status == "Paid")
                        _buildDetail("Method", paymentDetail.method),
                      _buildDetail(
                          "Plan status",
                          paymentDetail.expiryStatus.isNotEmpty
                              ? paymentDetail.expiryStatus
                              : "Failed"),
                      _buildDetail("Package", paymentDetail.durationType),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    var pdf =
                        "https://www.ocean.washington.edu/courses/oc410/reading/RogerAnderson/Planet_Earth_Topic_3.pdf";
                    Get.to(
                      PDFScreen(
                        path: pdf,
                      ),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 500),
                    );
                  },
                  child: Container(
                    height: 48,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      gradient: LinearGradient(
                        colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Upload',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetail(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.nunito(
              fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        Text(
          value,
          style: GoogleFonts.nunito(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Colors.black.withOpacity(0.5)),
        )
      ],
    );
  }
}
