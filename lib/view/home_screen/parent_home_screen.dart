import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hovee_attendence/controllers/parent_accountsetup_controller.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/modals/getHomeDashboardModel.dart';
import 'package:hovee_attendence/modals/getUserTokenList_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
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
  ParentView({
    Key? key,
    required this.userId,
    required this.rolename,
    this.firstname,
    this.lastname,
    this.wowid,
  }) : super(key: key);

  @override
  State<ParentView> createState() => _ParentViewState();
}

class _ParentViewState extends State<ParentView> {
  // final FirestoreService _locationService = FirestoreService();
  final NotificationController noticontroller =
      Get.put(NotificationController());
  final parentController = Get.find<ParentController>();
  final ParentAccountSetupController controller =
      Get.put(ParentAccountSetupController(), permanent: true);

  // String? wowId, firstName;

  // void fetchHomeDashboardTuteeList() async {
  //   try {
  //     setState(() {
  //      controller.   isLoading (true);
  //     });

  //     var homeDashboardResponse = await WebService.fetchHomeDashboardParentList();
  //     if (homeDashboardResponse != null) {
  //       Logger().i("getting printed ===>${homeDashboardResponse.partentId!.id!}");
  //       controller.homeDashboardNavList.value = homeDashboardResponse.navbarItems!;
  //     //  controller.  studentDetails.value = homeDashboardResponse.studentDetails!;
  //     //   // Extracting notification count
  //     //   //var studentDetails = homeDashboardResponse!.studentDetails;
  //     //   if (controller.studentDetails.value != null &&controller. studentDetails.value.isNotEmpty) {
  //     //     // Getting the unreadNotificationCount of the first student
  //     //  controller.   homeDashboardCourseList.value = controller .studentDetails![0].courseList!;
  //     //   }
  //       getUserTokenList(homeDashboardResponse.partentId!.id!);
  //       controller.    loginData.value = ParentDataq(
  //           firstName: homeDashboardResponse.partentId!.firstName,
  //           lastName: homeDashboardResponse.partentId!.lastName,
  //           wowId: homeDashboardResponse.partentId!.wowId,
  //           id: homeDashboardResponse.partentId!.id
  //         );
  //     }
  //   } catch (e) {
  //     // Get.snackbar('Failed to fetch batches');

  //     Logger().e("getting==>${e}");
  //   } finally {
  //     controller.  isLoading(false);
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Logger().i("${widget.firstname}message");
    //fetchHomeDashboardTuteeList();
  }
  //  void getUserTokenList(String parentId) async {
  //   controller.  isLoading.value = true;
  //   try {
  //     var batchData = {
  //       "parentId": parentId,
  //     };

  //     // Fetch the data from the WebService
  //     final getUserTokenListModel? response =
  //         await WebService.getUserTokenList(batchData);

  //     if (response != null && response.statusCode == 200) {
  //       // Get the userId list from the response
  //     controller.    userDetails.value = response.data!.userId!;
  //       List<UserId>? userIds = response.data?.userId;

  //       if (userIds != null && userIds.isNotEmpty) {
  //         // Get the first UserId object (index 0)
  //         UserId firstUser = userIds[0];

  //         // Convert UserId object to JSON string
  //         String userJson = firstUser.toJson().toString();

  //         // Save the JSON string in SharedPreferences
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         String? userDataJson = prefs.getString('firstUserId');

  //         if (userDataJson != null) {
  //           // Decode the JSON string into a Map
  //           Map<String, dynamic> userMap = jsonDecode(userDataJson);

  //           // Retrieve the wowId and name from the Map
  //           String wowId = userMap['wowId'];
  //           String name = userMap['name'];
  //           String token = userMap['token '];
  //           prefs.setString('Token', token);
  //           // Debugging: Check if the values are retrieved correctly
  //           print('User ID: $wowId, User Name: $name');
  //         } else {
  //           print('No user data found in SharedPreferences');
  //         }

  //         // userDetails.value = firstUser.sId!;
  //       } else {
  //         // Handle empty userId list
  //         print('UserId list is empty');
  //       }
  //     } else {
  //       // Handle API failure or response error
  //       print('Failed to fetch user token list');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   } finally {
  //   controller.    isLoading.value = false;
  //   }
  // }
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
            //  StreamBuilder<Map<String, dynamic>>(
            //   stream: _locationService.getStudentLiveLocation(userId: widget.userId),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(child: CircularProgressIndicator());
            //     }

            //     if (!snapshot.hasData || snapshot.data?['location'] == null) {
            //       return const Center(child: Text("Location not available"));
            //     }

            //     final location = snapshot.data!['location'];
            //     _studentLocation = LatLng(location['lat'], location['lng']);

            //     return GoogleMap(
            //       initialCameraPosition: CameraPosition(
            //         target: _studentLocation!,
            //         zoom: 15,
            //       ),
            //       markers: _studentLocation != null
            //           ? {
            //               Marker(
            //                 markerId: const MarkerId("student"),
            //                 position: _studentLocation!,
            //                 infoWindow: const InfoWindow(title: "Student Location"),
            //               ),
            //             }
            //           : {},
            //     );
            //   },
            // ),
            Obx(() {
          if (parentController.isLoading.value) {
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
                      Get.to(() => UserProfile(
                            type: "Parent",
                          ));
                    },
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 40),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/tutorHomeImg/Homepage_bg_banner (1).png',
                              )),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          gradient: LinearGradient(
                            colors: [Color(0xFFC13584), Color(0xFF833AB4)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const CircleAvatar(
                                          radius: 35,
                                          // Optional: Set a background color
                                          //backgroundColor: Colors.grey[200],
                                          child: Icon(
                                            Icons
                                                .person, // Correct usage: provide IconData directly
                                            size:
                                                36, // Adjust the icon size as needed
                                            color: Colors
                                                .black, // Set the icon color
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                '${widget.firstname ?? ""} ${widget.lastname ?? ""}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20.0,
                                                  color: Colors.white,
                                                )),
                                            Text('Parent',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18.0,
                                                  color: Colors.amber,
                                                )),
                                          ],
                                        ),
                                        // const SizedBox(
                                        //   width: 10,
                                        // ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 3),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.green),
                                          child: Row(
                                            children: [
                                              const Text('0',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 10.0,
                                                    color: Colors.white,
                                                  )),
                                              Image.asset(
                                                  'assets/tutorHomeImg/star 1.png')
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 15,
                                          width: 1,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        // userType=='Parent'?
                                        // Text(
                                        //         '${parentController.loginData!.value.wowId}',
                                        //     style: const TextStyle(
                                        //       fontWeight: FontWeight.w400,
                                        //       fontSize: 13.0,
                                        //       color: Colors.white,
                                        //     )):

                                        Text('ID: ${widget.wowid ?? ''}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13.0,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5),
                              child: Text(
                                'Attendance Monitoring',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        )),
                    // HomePageHeader(
                    //   title: 'Attendance Monitoring',
                    //   userType: "Parent",
                    // ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start, //spaceBetween
                    children: [
                      const Text(
                        'My Children',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     // Get.to(() => AttendanceCourseListScreen());
                      //   },
                      //   child: const Text(
                      //     'See All',
                      //     style: TextStyle(
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w500,
                      //         color: Colors.black),
                      //   ),
                      // ),
                    ],
                  ),
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
                      return Center(
                        child: Text(
                          'No list found',
                          style: GoogleFonts.nunito(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),
                      );
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
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    childAspectRatio: 1.0,
    crossAxisCount: 3,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
  ),
  itemCount: parentController.parentMonitorList.length + 1, // Add 1 for the extra card
  itemBuilder: (context, int index) {
    if (index == parentController.parentMonitorList.length) {
      // Render the "Invite Parent" card at the last index
      return InkWell(
        onTap: () {
          Get.to(() => ParentLoginScreen(rolename: 'Parent',firstname:widget.firstname ,lastname:widget.lastname ,wowid: widget.wowid,));
        },
        child: Card(
          elevation: 10,
          shadowColor: Colors.grey,
          surfaceTintColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromRGBO(246, 244, 254, 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
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
      final item = parentController.parentMonitorList[index];
      return InkWell(
        onTap: () async {
          // Handle tap actions based on title
          if (item['title'] == 'GPS Tracking') {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? userData = prefs.getString('firstUserId');
            String? wowId, firstName;
            if (userData != null) {
              Map<String, dynamic> userMap = jsonDecode(userData);
              wowId = userMap['wowId'];
              firstName = userMap['firstName'];
              print('User ID: $wowId, User Name: $firstName');
            }
            Get.to(
              () => TrackTuteeLocation(
                type: 'Parent',
                firstname: widget.firstname,
                lastname: widget.lastname,
                wowid: widget.wowid,
              ),
              arguments: [
                {
                  "userId": wowId,
                }
              ],
            );
          }
          // Handle other actions
          if (item['title'] == 'Attendance') {
            Get.to(
              () => TuteeAttendanceList(
                type: 'Parent',
                firstname: widget.firstname,
                lastname: widget.lastname,
                wowid: widget.wowid,
              ),
              arguments: "Parent",
            );
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
              color: const Color.fromRGBO(246, 244, 254, 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: item['color']),
                  child: Image.asset(
                    item['image'] ?? '',
                    color: Colors.white,
                    height: 30,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,//spaceBetween
                  //   children: [
                  //     const Text(
                  //       'Announcement',
                  //       style: TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w500,
                  //           color: Colors.black),
                  //     ),
                  //     // InkWell(
                  //     //   onTap: () {
                  //     //     // Get.to(() => AttendanceCourseListScreen());
                  //     //   },
                  //     //   child: const Text(
                  //     //     'See All',
                  //     //     style: TextStyle(
                  //     //         fontSize: 16,
                  //     //         fontWeight: FontWeight.w500,
                  //     //         color: Colors.black),
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
                  // Card(
                  //                 elevation: 10,
                  //                 shadowColor: Colors.black,
                  //                 surfaceTintColor: Colors.white,
                  //                 shape: RoundedRectangleBorder(
                  //                   side: const BorderSide(
                  //                     color:  Colors
                  //                             .transparent, // Highlight condition
                  //                     width: 2, // Border width
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(
                  //                       8), // Rounded border
                  //                 ),
                  //                 child: Container(
                  //                   padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                  //                   child: Row(
                  //                      mainAxisAlignment:
                  //                             MainAxisAlignment.start,
                  //                     children: [
                  //                       // CircleAvatar(
                  //                       //   radius: 40,
                  //                       //   child: Icon(
                  //                       //     Icons.person,
                  //                       //     size: 20,
                  //                       //     color: Colors.black,
                  //                       //   ),
                  //                       // ),
                  //                       Image.asset(
                  //                       'assets/tutorHomeImg/Rectangle 18373.png',
                  //                       //color: Colors.white,
                  //                       height: 60,
                  //                     ),
                  //                     const SizedBox(width: 8,),
                  //                       const Column(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.spaceBetween,
                  //                             crossAxisAlignment: CrossAxisAlignment.start,
                  //                         children: [
                  //                           Text(
                  //                              'John Hook',
                  //                             style: TextStyle(
                  //                               fontWeight: FontWeight.w400,
                  //                               fontSize: 20.0,
                  //                               color: Colors.black,
                  //                             ),
                  //                           ),

                  //                           Text(
                  //                              'It is a long established fact that a reader\nwill be distracted by the readable content\nof a page when looking at its layout.',
                  //                             style: TextStyle(
                  //                               fontWeight: FontWeight.w400,
                  //                               fontSize: 14.0,
                  //                               color: Colors.black,
                  //                             ),
                  //                           ),

                  //                         ],
                  //                       )
                  //                     ],
                  //                   ),
                  //                 ),
                  //               ),
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
