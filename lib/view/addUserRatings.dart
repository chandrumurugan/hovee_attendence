import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/view/enrollment_screen.dart';

class AddUserRatingsScreen extends StatefulWidget {
  final String? firstName,
      lastName,
      address,
      email,
      phNo,
      tutorId,
      batchId,
      courseId;

  const AddUserRatingsScreen(
      {Key? key,
      this.firstName,
      this.lastName,
      this.address,
      this.email,
      this.phNo,
      this.tutorId,
      this.batchId,
      this.courseId})
      : super(key: key);

  @override
  _AddUserRatingsScreenState createState() => _AddUserRatingsScreenState();
}

class _AddUserRatingsScreenState extends State<AddUserRatingsScreen> {
  double baseRating = 0.0;
  double finalRating = 0.0;
  bool showSubCategoriesList = false;
  List<String> selectedSubcategories = [];
  Map<String, bool> selectedCheckboxes = {};
  bool isLoading = false;
   int? ratingPayload;
  final TextEditingController _commentController = TextEditingController();

  Future<void> updateSelectedSubcategories(int rating) async {
    var batchData = {
      "stars": rating, // Send the selected rating
    };
    setState(() {
      isLoading = true;
    });

    try {
      // Simulate an API call
      var result = await WebService.updateSelectedSubcategories(batchData);

      if (result != null && result.data != null) {
        // Parse and update the details list
        selectedSubcategories = result.data!.details ?? [];
      }
      await Future.delayed(Duration(seconds: 1));
      // Mock data for selected subcategories
      setState(() {
        selectedSubcategories = result!.data!.details ?? [];
        selectedCheckboxes = {
          for (var subcategory in selectedSubcategories) subcategory: true
        };
        updateFinalRating();
      });
    } catch (e) {
      // Handle error
      print("Error fetching subcategories: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateFinalRating() {
    int selectedCount = selectedCheckboxes.values.where((v) => v).length;
    double extraRating = (selectedCount > 0 ? selectedCount : 1) * 0.2;
    setState(() {
      finalRating = double.parse((baseRating + extraRating).toStringAsFixed(1));
    });
  }

  submitOwnerRatings() async {
    List<String> selectedSubcategoryIds = selectedCheckboxes.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    setState(() {
      isLoading = true;
    });

    await WebService.submitRatings(
            context,
            widget.tutorId!,
            widget.batchId!,
            widget.courseId!,
            ratingPayload.toString(),
            selectedSubcategoryIds,
            _commentController.text)
        .then((value) {
      if (value == 200) {
        showModalBottomSheet(
          isDismissible: false,
          enableDrag: false,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return CustomDialogBox(
              title1: 'Ratings posted successfully !',
              title2: '',
              subtitle: '',
              btnName: 'Ok',
              onTap: () {
                Navigator.pop(context);
                Get.to(() => DashboardScreen(
                      //type: '',
                      //fromBottomNav: true,
                      rolename: 'Tutee',
                        firstname: widget.firstName,
              lastname: widget.lastName,
              wowid:''
                    ));
              },
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ),
              color: const Color(0xFF833AB4),
              singleBtn: true,
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthPadding = MediaQuery.of(context).size.width;
    double heightPadding = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            Get.back();
          }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12),
            Text(
              'Ratings & Reviews',
              style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 16),
            ),
            SizedBox(height: heightPadding * 0.02),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 15),
                child: Text("Tutor Info",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 16)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey.withOpacity(0.75),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: CachedNetworkImage(
                          imageUrl: "",
                          fit: BoxFit.fitWidth,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.person),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.firstName} ${widget.lastName}",
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w800,
                                color: Colors.black.withOpacity(.5))),
                        Text("${widget.address}",
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w800,
                              color: Colors.black.withOpacity(.5),
                            )),
                        Text("${widget.email}",
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w800,
                                color: Colors.black.withOpacity(.5))),
                        Text("${widget.phNo}",
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w800,
                                color: Colors.black.withOpacity(.5))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Please Rate Your Experience!',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: Center(
                      child: RatingBar.builder(
                          initialRating: 0.0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) =>
                              Icon(Icons.star, color: Colors.amber),
                          onRatingUpdate: (rating) async {
                            setState(() {
                              baseRating = rating - 1;
                              showSubCategoriesList = rating > 0;
                              updateSelectedSubcategories(rating.toInt());
                              ratingPayload=rating.toInt();
                            });

                            if (rating == 0.0) {
                              // Mark all checkboxes as selected
                              setState(() {
                                selectedCheckboxes = {
                                  for (var subcategory in selectedSubcategories)
                                    subcategory: false
                                };
                                print(selectedCheckboxes);
                              });
                            } else {
                              // Fetc h subcategories for the selected rating
                              showSubCategoriesList = true;
                            }
                          }),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: widthPadding * .02,
                          vertical: heightPadding * .004),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            finalRating.toString(),
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          SizedBox(width: widthPadding * .010),
                          Icon(Icons.star, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15, child: Divider()),
            if (showSubCategoriesList)
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isLoading)
                      Center(child: CircularProgressIndicator())
                    else if (selectedSubcategories.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: selectedSubcategories.length,
                        itemBuilder: (context, index) {
                          final subcategory = selectedSubcategories[index];
                          return Row(
                            children: [
                              Checkbox(
                                value: selectedCheckboxes[subcategory] ?? false,
                                onChanged: (bool? value) {
                                  setState(() {
                                    selectedCheckboxes[subcategory] =
                                        value ?? false;
                                    updateFinalRating();
                                  });
                                },
                              ),
                              Text(subcategory),
                            ],
                          );
                        },
                      )
                    else
                      Center(child: Text("No subcategories available")),
                  ],
                ),
              ),
            Visibility(
              visible: showSubCategoriesList,
              child: SizedBox(
                height: 18,
                child: Center(
                  child: Divider(),
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                visible: showSubCategoriesList,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(' Comments (if any)',
                      style: GoogleFonts.nunito(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black)),
                ),
              ),
            ),
            Visibility(
              visible: showSubCategoriesList,
              child: SizedBox(
                height: heightPadding * 0.010,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                visible: showSubCategoriesList,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 0.75,
                      color: Colors.grey.withOpacity(0.75),
                    ),
                  ),
                  child: TextFormField(
                    controller: _commentController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: 'Type comment',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: heightPadding * 0.020,
            ),
            Visibility(
              visible: showSubCategoriesList,
              child: Center(
                child: InkWell(
                  onTap: () {
                    if (finalRating == 0.0) {
                      SnackBarUtils.showErrorSnackBar(
                          context, "Please select the star ratings");
                    } else if (selectedCheckboxes.isEmpty) {
                      SnackBarUtils.showErrorSnackBar(
                          context, "Please select the rate experience");
                    } else {
                      showModalBottomSheet(
                          // useRootNavigator: true,
                          barrierColor: Colors.black.withOpacity(0.8),
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(0.0)), // Set border radius
                          ),
                          builder: (BuildContext context) {
                            return RemoveVerificationModal(
                              okBtnText: "Submit",
                              onAccept: () {
                                submitOwnerRatings();
                              },
                            );
                          });
                    }
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) => RatingHome()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: widthPadding * 0.10,
                          vertical: heightPadding * 0.020),
                      decoration: BoxDecoration(
                          color: AppConstants.primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text('Submit',
                          style: GoogleFonts.nunito(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RemoveVerificationModal extends StatelessWidget {
  final VoidCallback onAccept;
  final String? okBtnText;
  const RemoveVerificationModal(
      {super.key, required this.onAccept, this.okBtnText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 8,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(12)),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Post rating confirmation',
            style: GoogleFonts.nunito(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Do you want to submit your rating?',
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    // height: 50,
                    // width: ,
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppConstants.primaryColor)),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppConstants.primaryColor),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    onAccept();
                  },
                  child: Container(
                    // height: 50,
                    // width: ,
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        okBtnText ?? "Accept",
                        style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
