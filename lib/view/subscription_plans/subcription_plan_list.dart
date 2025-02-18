import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PlanList extends StatefulWidget {
  const PlanList({super.key});

  @override
  State<PlanList> createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  bool isMonthlySelected = true;
  int selectedIndex = -1;
  late Razorpay _razorpay;
  List<Map<String, dynamic>> populateSampleData = [
    {
      "plan_name": "Bronze",
      "is_popular": true,
      "price": "1000",
      "features": [
        "New plan for today start",
        "most common plan",
        "effective plan",
        "cost efficient"
      ]
    },
    {
      "plan_name": "Silver",
      "is_popular": true,
      "price": "2000",
      "features": [
        "New plan for today start",
        "most common plan",
        "effective plan",
        "cost efficient"
      ]
    },
    {
      "plan_name": "Gold",
      "is_popular": true,
      "price": "3000",
      "features": [
        "New plan for today start",
        "most common plan",
        "effective plan",
        "cost efficient"
      ]
    }
  ];

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarHeader(needGoBack: true, navigateTo: () {}),
      body: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE60079), Color(0xFF160B47)],
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Choose your Plan",
              style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
              style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMonthlySelected = true;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color:
                          isMonthlySelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Monthly",
                        style: GoogleFonts.nunito(
                            color: isMonthlySelected
                                ? AppConstants.primaryColor
                                : Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMonthlySelected = false;
                    });
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: !isMonthlySelected
                          ? Colors.white
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Yearly",
                        style: GoogleFonts.nunito(
                            color: !isMonthlySelected
                                ? AppConstants.primaryColor
                                : Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: height * 0.4,
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var data = populateSampleData[index];

                    List<String> features =
                        populateSampleData[index]["features"];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index; // Update selected index
                        });
                      },
                      child: Container(
                        // width: 173,
                        // height: 320,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: selectedIndex == index
                                  ? Colors.transparent
                                  : Colors.white),
                          color: selectedIndex == index
                              ? const Color(0xFFF07721) // Selected color
                              : Colors.transparent,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${data["plan_name"]}",
                              style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Most popular",
                                style: GoogleFonts.nunito(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              data["price"] + " ₹/month",
                              style: GoogleFonts.nunito(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Center(
                              child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: features.map((index) {
                                    return dotRow(name: index);
                                  }).toList()),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                              width: 160,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.white)),
                              child: Center(
                                child: Text(
                                  "Select",
                                  style: GoogleFonts.nunito(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                  itemCount: populateSampleData.length),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Terms & Conditiom",
              style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
              style: GoogleFonts.nunito(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  void handlePayment() {
    var options = {
      'key': 'rzp_test_ZkLOvWs7XmF5xN',
      'amount': int.parse("${"plan.price"}") * 100,
      'currency': 'INR',
      'name': " userDetails!.userDetails.firstName" +
          " " +
          " userDetails!.userDetails.lastName",
      'description': 'Subscription Payment for ${"plan.name"}',
      'prefill': {
        'contact': " userDetails!.userDetails.mobileNo",
        'email': " userDetails!.userDetails.email"
      },
    };
    // lastSelectedPlanName = plan.name;
    _razorpay.open(options);
  }

  Widget dotRow({required String name}) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 5,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          name,
          style: GoogleFonts.nunito(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        )
      ],
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {}

  void _handlePaymentError(PaymentFailureResponse response) async {}

  void _handleExternalWallet(ExternalWalletResponse response) {}
}
