import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/widget/pdf_view_screen.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../modals/getsubscriptionPdfModel.dart';


class MyPaymentDetailScreen extends StatefulWidget {
  final paymentDetail;
  const MyPaymentDetailScreen({super.key, this.paymentDetail});

  @override
  State<MyPaymentDetailScreen> createState() => _MyPaymentDetailScreenState();
}

class _MyPaymentDetailScreenState extends State<MyPaymentDetailScreen> {
  bool isLoading = false;
  Data? paymentList;
  initState() {
    super.initState();
    _getPaymentList();
  }

  Future<void> _getPaymentList() async {
    setState(() {
      isLoading = true;
    });
    var response = await WebService.getsubscriptionPdfInvoice(widget.paymentDetail.id);
    if (response.success!) {
      setState(() {
        paymentList = response.data;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
     Color parsedColor = Color(int.parse(widget.paymentDetail.selectedPlan.colorCode.replaceFirst("#", "0xff")));
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
              const SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppConstants.secondaryColor,
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: parsedColor,
                      child: CachedNetworkImage(
                        imageUrl: "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.shopping_bag_outlined,
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Plan name : ${widget.paymentDetail.selectedPlan.category}",
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "₹ ${widget.paymentDetail.selectedPlan.price}",
                style: GoogleFonts.nunito(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.paymentDetail.paymentStatus == "Paid")
                    const Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                    )
                  else
                    const Icon(
                      Icons.cancel_presentation_outlined,
                      color: Colors.red,
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${widget.paymentDetail.paymentStatus == "Unpaid" ? "Failed" : widget.paymentDetail.paymentStatus}",
                    style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ],
              ),
              const Divider(
                color: Colors.black,
                indent: 80,
                endIndent: 80,
              ),
              const SizedBox(
                height: 10,
              ),
              if (widget.paymentDetail.paymentStatus == "Paid")
                Text(
                   DateFormat("d MMM yyyy").format(DateFormat("dd/MM/yyyy").parse(widget.paymentDetail.purchaseDate))
                  // DateFormat("d MMM yyyy")
                  //   .format(DateTime.parse(paymentDetail.purchaseDate!))
                    ),
              const SizedBox(
                height: 20,
              ),
              Container(
                // height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppConstants.secondaryColor, width: 1.0)),
                padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.assignment),
                          Text(
                            widget.paymentDetail.invoiceId,
                            style: GoogleFonts.nunito(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                          )
                        ],
                      ),
                      if (widget.paymentDetail.paymentStatus == "Paid") const Divider(),
                      if (widget.paymentDetail.paymentStatus == "Paid")
                        _buildDetail(
                            "Expiry date",
                             DateFormat("d MMM yyyy").format(DateFormat("dd/MM/yyyy").parse(widget.paymentDetail.expiryDate))
                            // DateFormat("dMMMyyyy").format(
                            //     DateTime.parse(paymentDetail.expiryDate!))
                                
                                ),
                      // if (paymentDetail.paymentStatus == "Paid")
                      //   _buildDetail("Method", paymentDetail.method),
                      // _buildDetail(
                      //     "Plan status",
                      //     paymentDetail.expiredStatus.isNotEmpty
                      //         ? paymentDetail.expiredStatus
                      //         : "Failed"),
                      _buildDetail("Package", widget.paymentDetail.durationType),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (widget.paymentDetail.paymentStatus == "Paid")
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Get.to(
                      PDFScreen(
                        path: paymentList!.pdfFilepath,
                      ),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 500),
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
                    child: const Center(
                      child: Text(
                        'View Invoice',
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