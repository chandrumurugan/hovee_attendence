import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/parent_accountsetup_controller.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/modals/getHomeDashboardModel.dart';
import 'package:hovee_attendence/modals/getUserTokenList_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';
import 'package:hovee_attendence/view/announcement_screen.dart';
import 'package:hovee_attendence/view/enrollment_screen.dart';
import 'package:hovee_attendence/view/leave_screen.dart';
import 'package:hovee_attendence/view/parent_login_screen.dart';
import 'package:hovee_attendence/view/tutee_holiday_screen.dart';
import 'package:hovee_attendence/view/userProfile.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/notification_controller.dart';
import 'package:hovee_attendence/controllers/parent_dashboard_controller.dart';
import 'package:hovee_attendence/view/Tutee/tuteeAttendanceList.dart';
import 'package:hovee_attendence/view/parent/trackTuteeLocation.dart';
import 'package:hovee_attendence/view/profile_card.dart';
import 'package:hovee_attendence/view/sidemenu.dart';
import 'package:hovee_attendence/widget/gifController.dart';

class ParentView extends StatefulWidget {
  String userId;
  String rolename;
  final String? firstname, lastname, wowid;
   final VoidCallback onDashBoardBack;
  ParentView({
    Key? key,
    required this.userId,
    required this.rolename,
    this.firstname,
    this.lastname,
    this.wowid, required this.onDashBoardBack,
  }) : super(key: key);

  @override
  State<ParentView> createState() => _ParentViewState();
}

class _ParentViewState extends State<ParentView> {
  // final FirestoreService _locationService = FirestoreService();
   
   //UserProfileController
  final NotificationController noticontroller =
      Get.put(NotificationController());
  final parentController = Get.find<ParentController>();
  final ParentAccountSetupController controller =
      Get.put(ParentAccountSetupController(), permanent: true);
         final UserProfileController userProfileData = Get.put(UserProfileController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Logger().i("${widget.firstname}message");
    //fetchHomeDashboardTuteeList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: parentController.tuteeScaffoldKey,
        drawer: SideMenu(
          isGuest: false,
          type: 'Parent',
          firstname: widget.firstname,
          lastname: widget.lastname,
          wowid: widget.wowid,
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 5,
          shadowColor: Colors.grey.shade100,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      parentController.tuteeScaffoldKey.currentState!
                          .openDrawer();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const SideMenu()));
                    },
                    child: Image.asset(
                      'assets/appbar/Group 2322.png',
                      color: AppConstants.primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const LogoGif()
                  // SvgPicture.asset(
                  //   'assets/appbar/hovee_attendance_app_icon_.svg',
                  //   height: 40,
                  // ),
                  // Image.asset(
                  //   'assets/appConstantImg/colorlogoword.png',
                  //   height: 30,
                  // ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade200),
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            // Get.to(() => NotificationScreen(
                            //       type: 'Tutee',
                            //     ));
                          },
                          child: Image.asset(
                            'assets/appbar/bell 5.png',
                            color: Colors.black.withOpacity(0.4),
                            height: 30,
                          ),
                        ),
                        Obx(() => Positioned(
                              right: 1,
                              top: 1,
                              child: noticontroller.notificationCount.value > 0
                                  ? Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 12,
                                        minHeight: 12,
                                      ),
                                      child: Text(
                                        '${noticontroller.notificationCount.value}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : const SizedBox(),
                            )),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const ChatScreen()));
                      },
                      child: Icon(
                        Icons.message,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          centerTitle: false,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        body:
            Obx(() {
          if (parentController.isLoading.value || userProfileData.isLoading.value ) {
            // Call your refresh logic here, e.g., re-fetch data
            // Reset the refresh state
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                        onTap: () {
                          Get.to(() => UserProfile(type: "Parent",));
                        },
                        child: HomePageHeader(
                          title: 'Attendance Monitoring',
                          userType: "Parent",
                          firstName: widget.firstname,
                          lastName: widget.lastname,
                          wowId: widget.wowid,
                        ),
                      ),
                  const SizedBox(
                    height: 10,
                  ),
                  parentController.userDetails.isNotEmpty
                      ? Row(
                          mainAxisAlignment:
                              MainAxisAlignment.start, //spaceBetween
                          children: [
                            const Text(
                              'My Children',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                  Obx(() {
                    // Store token for the first item if not already stored
                    if (!parentController.isLoading.value &&
                        parentController.userDetails.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        //if (prefs.getString('initialToken') == null) {
                        var firstUserDetails = parentController.userDetails[0];
                        await prefs.setString(
                            'Token', firstUserDetails.token ?? '');
                        //  print('Initial token stored: ${firstUserDetails.token}');
                        // }
                      });
                    }

                    if (parentController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (parentController.userDetails.isEmpty) {
                      return Center(child: SizedBox.shrink());
                    } else {
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: parentController.userDetails.length,
                        itemBuilder: (context, index) {
                          var userDetails = parentController.userDetails[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5),
                            child: GestureDetector(
                              onTap: () async {
                                parentController.selectedIndex.value = index;

                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setString(
                                  'firstUserId',
                                  jsonEncode({
                                    'wowId': userDetails.wowId,
                                    'firstName': userDetails.firstName,
                                    'Token': userDetails.token,
                                  }),
                                );
                                await prefs.setString(
                                    'Token', userDetails.token!);
                                print('Token stored: ${userDetails.token}');
                              },
                              child: Card(
                                elevation: 10,
                                shadowColor: Colors.black,
                                surfaceTintColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: Colors.transparent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/Ellipse 261.png',
                                        height: 60,
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            userDetails.firstName ?? '',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: 'ID : ',
                                                  style: const TextStyle(
                                                    color: Colors
                                                        .black, // Same color

                                                    fontWeight: FontWeight
                                                        .bold, // Bold for "ID"
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: userDetails.wowId ?? '',
                                                  style: const TextStyle(
                                                    color: Colors
                                                        .black, // Same color
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Text(
                                          //   userDetails.wowId ?? '',
                                          //   style: const TextStyle(
                                          //     fontWeight: FontWeight.w400,
                                          //     fontSize: 14.0,
                                          //     color: Colors.black,
                                          //   ),
                                          // ),
                                          Text(
                                            userDetails.email ?? '',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          const CircleAvatar(
                                            radius: 3,
                                            backgroundColor: Colors.green,
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            'LIVE',
                                            style: GoogleFonts.nunito(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'My Listings',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 1.0,
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemCount: parentController.parentMonitorList.length +
                            1, // Add 1 for the extra card
                        itemBuilder: (context, int index) {
                          if (index ==
                              parentController.parentMonitorList.length) {
                            // Render the "Invite Parent" card at the last index
                            return InkWell(
                              onTap: () {
                                Get.to(() => ParentLoginScreen(
                                      rolename: 'Parent',
                                      firstname: widget.firstname,
                                      lastname: widget.lastname,
                                      wowid: widget.wowid,
                                    ));
                              },
                              child: Card(
                                elevation: 10,
                                shadowColor: Colors.grey,
                                surfaceTintColor: Colors.white,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:
                                        const Color.fromRGBO(246, 244, 254, 1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Colors.grey,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Text(
                                          "Invite children",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            // Render the existing items
                            final item =
                                parentController.parentMonitorList[index];
                            return InkWell(
                              onTap: () async {
                                // Handle tap actions based on title
                                if (item['title'] == 'GPS Tracking') {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  String? userData =
                                      prefs.getString('firstUserId');
                                  String? wowId, firstName;
                                  if (userData != null) {
                                    Map<String, dynamic> userMap =
                                        jsonDecode(userData);
                                    wowId = userMap['wowId'];
                                    firstName = userMap['firstName'];
                                    print(
                                        'User ID: $wowId, User Name: $firstName');
                                  }
                                  parentController.userDetails.isNotEmpty
                                      ? Get.to(
                                          () => TrackTuteeLocation(
                                            type: 'Parent',
                                            firstname: widget.firstname,
                                            lastname: widget.lastname,
                                            wowid: widget.wowid,
                                          ),
                                          arguments: [
                                            {
                                              "userId": wowId.toString(),
                                            }
                                          ],
                                        )
                                      : SnackBarUtils.showErrorSnackBar(
                                          context,
                                          'Child profile not linked to your account.',
                                        );
                                }
                                // Handle other actions
                                if (item['title'] == 'Attendance') {
                                  parentController.userDetails.isNotEmpty
                                      ? Get.to(
                                          () => TuteeAttendanceList(
                                            type: 'Parent',
                                            firstname: widget.firstname,
                                            lastname: widget.lastname,
                                            wowid: widget.wowid,
                                          ),
                                          arguments: "Parent",
                                        )
                                      : SnackBarUtils.showErrorSnackBar(
                                          context,
                                          'Child profile not linked to your account.',
                                        );
                                }
                                if (item['title'] == 'Enquiries') {
                                  Get.to(() => Tutorenquirlist(
                                            type: 'Parent',
                                            fromBottomNav: true,
                                            firstname: widget.firstname,
                                            lastname: widget.lastname,
                                            wowid: widget.wowid,
                                          ));
                                      
                                }
                                if (item['title'] == 'Enrollment') {
                                   Get.to(() => EnrollmentScreen(
                                            type: 'Parent',
                                            fromBottomNav: true,
                                            firstname: widget.firstname,
                                            lastname: widget.lastname,
                                            wowid: widget.wowid,
                                          ));
                                      
                                }
                                if (item['title'] == 'Leave') {
                                   Get.to(() => TuteeLeaveScreen(
                                            type: 'Parent',
                                            fromBottomNav: true,
                                            firstname: widget.firstname,
                                            lastname: widget.lastname,
                                            wowid: widget.wowid,
                                          ))
                                      ;
                                }
                                if (item['title'] == 'Holiday') {
                                  Get.to(() => TuteeHolidayScreen(
                                            type: 'Parent',
                                            firstname: widget.firstname,
                                            lastname: widget.lastname,
                                            wowid: widget.wowid,
                                          ))
                                      ;
                                }
                                if (item['title'] == 'Annoucement') {
                                   Get.to(() => AnnouncementScreen(
                                            type: 'Parent',
                                            firstname: widget.firstname,
                                            lastname: widget.lastname,
                                            wowid: widget.wowid,
                                          ))
                                      ;
                                }
                                // Add remaining conditional checks for other titles
                              },
                              child: Card(
                                elevation: 10,
                                shadowColor: Colors.grey,
                                surfaceTintColor: Colors.white,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color:
                                        const Color.fromRGBO(246, 244, 254, 1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: item['color']),
                                        child: Image.asset(
                                          item['image'] ?? '',
                                          color: Colors.white,
                                          height: 30,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Text(
                                          item['title'] ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        }));
  }
}

class TestimonialCard extends StatelessWidget {
  final String image;
  final String name;
  final String location;
  final String testimonial;
  final int currentPage;
  final int totalPages;

  TestimonialCard({
    required this.image,
    required this.name,
    required this.location,
    required this.testimonial,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Card container
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Profile picture
                Image.asset(
                  image,
                  // color: Colors.white,
                  height: 80,
                ),
                const SizedBox(width: 16.0),
                // Testimonial content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and location
                      Row(
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            location,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      // Testimonial text
                      Text(
                        testimonial,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          // Page indicator
        ],
      ),
    );
  }
}
