import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/modals/getSubscriptionModel.dart';
import 'package:hovee_attendence/modals/getcurrentsubscriptionModel.dart';
import 'package:hovee_attendence/modals/postPayment_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:logger/logger.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlanList extends StatefulWidget {
  final bool fromBottomNav;
  final String type;
  final VoidCallback? onDashBoardBack;
  const PlanList(
      {super.key,
      required this.fromBottomNav,
      required this.type,
      this.onDashBoardBack});

  @override
  State<PlanList> createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  bool isMonthlySelected = true;
  int selectedIndex = -1;
  late Razorpay _razorpay;
  // List<Map<String, dynamic>> populateSampleData = [
  //   {
  //     "plan_name": "Bronze",
  //     "is_popular": true,
  //     "price": "1000",
  //     "features": [
  //       "New plan for today start",
  //       "most common plan",
  //       "effective plan",
  //       "cost efficient"
  //     ]
  //   },
  //   {
  //     "plan_name": "Silver",
  //     "is_popular": true,
  //     "price": "2000",
  //     "features": [
  //       "New plan for today start",
  //       "most common plan",
  //       "effective plan",
  //       "cost efficient"
  //     ]
  //   },
  //   {
  //     "plan_name": "Gold",
  //     "is_popular": true,
  //     "price": "3000",
  //     "features": [
  //       "New plan for today start",
  //       "most common plan",
  //       "effective plan",
  //       "cost efficient"
  //     ]
  //   }
  // ];
  List<Datum> data = [];
  List<Plan> populateSampleData = [];
  bool isLoadingcategoryList = false;
  String? lastSelectedPlanName;
  final userProfileData = Get.find<UserProfileController>();
  String? subscriptionId;
  currentsubscriptionData? currentSubscription;
  @override
  void initState() {
    super.initState();
    getcurrentsubscription();
    fetchSubscriptionData("month");
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> fetchSubscriptionData(String type) async {
    setState(() {
      isLoadingcategoryList = true;
    });
    Map<String, dynamic> requestPayload = {
      "type": type, // Pass "month" or "year"
    };

    GetSubscriptionModel? response =
        await WebService.getSubscription(requestPayload);

    if (response != null && response.data != null) {
      setState(() {
        populateSampleData = response.data[0].plans;
        subscriptionId = response.data[0].id;
        isLoadingcategoryList = false; // Update list with API response
      });
    } else {
      setState(() {
        isLoadingcategoryList = false; // Update list with API response
      });
    }
  }

  Future<void> getcurrentsubscription() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoadingcategoryList = true;
    });
    GetcurrentsubscriptionModel? response =
        await WebService.getcurrentsubscription();

    if (response!.success == true) {
      setState(() {
        // Update list with API response
        currentSubscription = response.data;
        Logger().i("currentSubscription==>${currentSubscription}");
        prefs.setString("planName", "${currentSubscription!.planName}");
         prefs.setString("planColorCode", "${currentSubscription!.planColorCode}");
        isLoadingcategoryList = false;
      });
    } else {
      setState(() {
        // Update list with API response
        isLoadingcategoryList = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            if (widget.fromBottomNav && widget.onDashBoardBack != null) {
              // Call onDashBoardBack if navigating from bottom navigation
              widget.onDashBoardBack!();
            } else {
              // Navigate to Dashboard if not from bottom navigation
              Get.offAll(DashboardScreen(
                rolename: widget.type,
              ));
            }
          }),
      body: isLoadingcategoryList
          ? const Center(child: CircularProgressIndicator())
          : populateSampleData!.isEmpty
              ? const Center(child: Text("No subscription available"))
              : Container(
                  height: height,
                  width: width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                        "Choose the perfect plan for effortless attendance tracking!",
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
                            onTap: () async {
                              setState(() {
                                isMonthlySelected = true;
                                selectedIndex = -1;
                              });
                              getcurrentsubscription();
                              await fetchSubscriptionData("month");
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isMonthlySelected
                                    ? Colors.white
                                    : Colors.transparent,
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
                            onTap: () async {
                              setState(() {
                                isMonthlySelected = false;
                                selectedIndex = -1;
                              });
                              getcurrentsubscription();
                              await fetchSubscriptionData("year");
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
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
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              var plan = populateSampleData[index];
                              List<String> features = plan.description;
                              bool isActive = currentSubscription != null
                                  ? currentSubscription!.planId == plan.id
                                  : false;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex =
                                        index; // Update selected index
                                  });
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.61,
                                  //height: MediaQuery.of(context).size.height * 0.4,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.white),
                                    color: Colors.transparent,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      Text(
                                        "${plan.category}",
                                        style: GoogleFonts.nunito(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      ),
                                      // const SizedBox(
                                      //   height: 15,
                                      // ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          "Most popular",
                                          style: GoogleFonts.nunito(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Text(
                                        plan.price.toString() + " ₹/month",
                                        style: GoogleFonts.nunito(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Center(
                                        child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: features.map((index) {
                                              return dotRow(name: index);
                                            }).toList()),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
InkWell(
  onTap: (currentSubscription == null) ||
          (!isMonthlySelected
              ? (plan.category == "Bronze" && currentSubscription!.allowBronzeYear!) ||
                (plan.category == "Silver" && currentSubscription!.allowSilverYear!) ||
                (plan.category == "Gold" && currentSubscription!.allowGoldYear!)
              : (plan.category == "Bronze" && currentSubscription!.allowBronze!) ||
                (plan.category == "Silver" && currentSubscription!.allowSilver!) ||
                (plan.category == "Gold" && currentSubscription!.allowGold!)
          )
      ? () {
          handlePayment(plan);
        }
      : null, // Disable if the plan is not allowed
  child: Container(
    width: 160,
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.white),
      color: currentSubscription == null ? Colors.transparent :
        (currentSubscription != null && currentSubscription!.planName == plan.category &&  ((isMonthlySelected &&
                        currentSubscription!.durationType!.toLowerCase() ==
                            "month") ||
                    (!isMonthlySelected &&
                        currentSubscription!.durationType!.toLowerCase() ==
                            "year")))
        ? Colors.green // Display "Active" if the current plan matches
        : (!isMonthlySelected
            ? (plan.category == "Bronze" && currentSubscription!.allowBronzeYear!) ||
              (plan.category == "Silver" && currentSubscription!.allowSilverYear!) ||
              (plan.category == "Gold" && currentSubscription!.allowGoldYear!)
            : (plan.category == "Bronze" && currentSubscription!.allowBronze!) ||
              (plan.category == "Silver" && currentSubscription!.allowSilver!) ||
              (plan.category == "Gold" && currentSubscription!.allowGold!)
          )
          ? Colors.transparent // Enabled state
          : Colors.grey, // Disabled state
    ),
    child: Center(
  child: Text(
    currentSubscription == null
        ? "Pay Now"
        : (currentSubscription!.planName == plan.category &&
                ((isMonthlySelected &&
                        currentSubscription!.durationType!.toLowerCase() ==
                            "month") ||
                    (!isMonthlySelected &&
                        currentSubscription!.durationType!.toLowerCase() ==
                            "year")))
            ? "Active" // Display "Active" if the current plan matches and the durationType is correct
            : "Pay Now", // Otherwise, show "Pay Now"
    style: GoogleFonts.nunito(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
)


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
                        "Payment Terms:",
                        style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Subscription fees are non-refundable and billed as per the selected plan.",
                        style: GoogleFonts.nunito(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 13),
                      ),
                      Text(
                        "Cancellation or upgrades can be managed through your account settings.",
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

  void handlePayment(Plan plan) {
    var options = {
      'key': 'rzp_test_ZkLOvWs7XmF5xN',
      'amount': int.parse("${plan.price!.toInt()}") * 100,
      'currency': 'INR',
      'name': userProfileData.userProfileResponse.value.data!.firstName
              .toString() +
          " " +
          userProfileData.userProfileResponse.value.data!.lastName.toString(),
      'description': 'Subscription Payment for ${plan.category}',
      'prefill': {
        'contact': userProfileData.userProfileResponse.value.data!.phoneNumber,
        'email': userProfileData.userProfileResponse.value.data!.email
      },
    };
    lastSelectedPlanName = plan.id;
    _razorpay.open(options);
  }

  Widget dotRow({required String name}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 5,
        ),
        const SizedBox(
          width: 5,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            name,
            style: GoogleFonts.nunito(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        )
      ],
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    Logger().d(response.data!);
    String paymentId = response.paymentId! ?? "";
    Plan selectedPlan = populateSampleData.firstWhere(
      (plan) => plan.id == lastSelectedPlanName,
      orElse: () => populateSampleData.first, // Default in case of failure
    );
    String durationType = selectedPlan.durationType!.trim().toLowerCase();
    String duration = selectedPlan.duration.toString().trim();
    String planName = selectedPlan.category!;
    String planId = selectedPlan.id!;

    Logger().d(
      "Payment successful: $paymentId, Plan: $planName, Duration: $duration, Duration Type: $durationType",
    );
    Map<String, dynamic> requestPayload = {
      "subscription_id": subscriptionId,
      "plan_id": planId,
      "duration_type": duration,
      "duration": 1, // next month added subscription
      "payment_txt_id": paymentId ?? '',
      "payment_status": 1,
    };

    PostPaymentModel? result = await WebService.postPayment(requestPayload);

    if (result != null && result.data != null) {
      setState(() {
        showConfirmationDialog1(result.message ?? '');
      });
    } else {
      setState(() {});
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) async {
    // Do something when payment fails
    Logger().d(response.error);
    Plan selectedPlan = populateSampleData.firstWhere(
      (plan) => plan.id == lastSelectedPlanName,
      orElse: () => populateSampleData.first, // Default in case of failure
    );
    String planId = selectedPlan.id!;
    String durationType = selectedPlan.durationType!.trim().toLowerCase();
    String duration = selectedPlan.duration.toString().trim();
    String planName = selectedPlan.category!;
    String price = selectedPlan.price.toString();

    Map<String, dynamic> requestPayload = {
      "subscription_id": subscriptionId,
      "plan_id": planId,
      "duration_type": duration,
      "duration": 1, // next month added subscription
      "payment_txt_id": '',
      "payment_status": 0,
    };

    PostPaymentModel? result = await WebService.postPayment(requestPayload);

    if (result != null && result.data != null) {
      setState(() {
        showConfirmationDialog1(result.message ?? '');
      });
    } else {
      setState(() {});
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    Logger().d(response.walletName);
  }

  void showConfirmationDialog1(String msg) {
    Get.dialog(
      CustomDialogBox2(
        title1: msg,
        title2: '',
        subtitle: '',
        icon: const Icon(
          Icons.help_outline,
          color: Colors.white,
        ),
        color: const Color(0xFF833AB4), // Set the primary color
        color1: const Color(0xFF833AB4), // Optional gradient color
        singleBtn: true, // Show only one button
        btnName: 'OK', // Set the button name
        onTap: () {
          // Call API to add enrollmen
          Navigator.pop(context);
          getcurrentsubscription();
        },
      ),
      barrierDismissible: false, // Prevent dismissing by tapping outside
    );
  }
}
