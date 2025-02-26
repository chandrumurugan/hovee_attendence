
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/view/subscription_plans/my_paymentDetail_screen.dart';
import 'package:intl/intl.dart';

class MyPaymentScreen extends StatefulWidget {
   final String type;
   final String? firstname,lastname,wowid;
  const MyPaymentScreen({super.key, required this.type, this.firstname, this.lastname, this.wowid});

  @override
  State<MyPaymentScreen> createState() => _MyPaymentScreenState();
}

class _MyPaymentScreenState extends State<MyPaymentScreen> {

  bool isLoading = false;
  // List<Datum> paymentList = [];
  // List<Datum> filteredList = [];
 var paymentList =[];
 var filteredList =[];
  String selectedFilter = "All";

  void initState() {
    super.initState();
   // _getPaymentList();
  }

  // Future<void> _getPaymentList() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var response = await WebService.getMyPaymentList();
  //   if (response.success) {
  //     setState(() {
  //       paymentList = response.data;
  //       filteredList = paymentList;
  //       isLoading = false;
  //     });
  //   } else {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  void _filterPayments(String status) {
    setState(() {
      selectedFilter = status;
      if (status == "All") {
        filteredList = paymentList;
      } else {
        
        filteredList =
            paymentList.where((payment) => payment.status == status).toList();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            Get.offAll(DashboardScreen(
              rolename: widget.type,
              firstname:widget. firstname,lastname:widget. lastname,wowid: widget.wowid,
            ));
          }),
    body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.sizeOf(context).width * 0.024),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'My payments',
                                style: GoogleFonts.nunito(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              PopupMenuButton<String>(
                                onSelected: _filterPayments,
                                itemBuilder: (BuildContext context) {
                                  return ["All", "Paid", "Failed"]
                                      .map((String choice) =>
                                          PopupMenuItem<String>(
                                            value: choice,
                                            child: Text(choice,
                                                style: GoogleFonts.nunito(
                                                    fontSize: 16)),
                                          ))
                                      .toList();
                                },
                                icon: Icon(Icons.filter_list,
                                    color: Colors.black),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: filteredList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Get.to(
                                    MyPaymentDetailScreen(
                                      paymentDetail: filteredList[index],
                                    ),
                                    transition: Transition.rightToLeft,
                                    duration: Duration(milliseconds: 500),
                                  );
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      border: Border.all(
                                          color: AppConstants.secondaryColor)),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                            color: AppConstants.secondaryColor
                                                .withOpacity(0.6),
                                            child: CachedNetworkImage(
                                              imageUrl: "imageUrl",
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                              color: Colors.white,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                Icons.shopping_bag_outlined,
                                                color: Colors.white,
                                              ),
                                            )),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _buildPaymentItem("Plan name",
                                                filteredList[index].name),
                                            _buildPaymentItem("Price",
                                                "₹ ${filteredList[index].price}"),
                                                 _buildPaymentItem("Payment date",
                                                 DateFormat("d MMM yyyy")
                  .format(DateTime.parse(filteredList[index].purchaseDate ?? ""))),
                                              
                                            _buildPaymentItem("Status",
                                                filteredList[index].status),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        ])));
  }

  Widget buildNoListingFoundView() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 30),
          Image.asset(
            'assets/logo/No_Verification_Found_Image_app.png',
            height: 200,
          ),
          SizedBox(height: 30),
          Center(
            child: Text(
              "No listing found",
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text(title,
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black)),
          const Spacer(),
          Text(value,
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withOpacity(0.5))),
        ],
      ),
    );
  }
}
