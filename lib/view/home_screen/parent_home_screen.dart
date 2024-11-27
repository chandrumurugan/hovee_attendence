import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/enquir_controller.dart';
import 'package:hovee_attendence/controllers/enrollment_controller.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/services/firestoreService.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/view/Tutee/tuteeAttendanceList.dart';
import 'package:hovee_attendence/view/Tutee/tutee_courseList.dart';
import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';
import 'package:hovee_attendence/view/attendanceCourseList_screen.dart';
import 'package:hovee_attendence/view/enrollment_screen.dart';
import 'package:hovee_attendence/view/home_screen/tutor_home_screen.dart';
import 'package:hovee_attendence/view/notification_screen.dart';
import 'package:hovee_attendence/view/parent/trackTuteeLocation.dart';
import 'package:hovee_attendence/view/sidemenu.dart';
import 'package:hovee_attendence/view/userProfile.dart';
import 'package:hovee_attendence/widget/gifController.dart';
import 'package:logger/logger.dart';

class ParentView extends StatefulWidget {
  String userId;

  ParentView({super.key, required this.userId});

  @override
  _ParentViewState createState() => _ParentViewState();
}

class _ParentViewState extends State<ParentView> {
  // final FirestoreService _locationService = FirestoreService();
  // LatLng? _studentLocation;
  final ParentController controller = Get.put(ParentController());
  final EnquirDetailController classController =
      Get.put(EnquirDetailController());
  final EnrollmentController enrollmentController =
      Get.put(EnrollmentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBarHeader(
          needGoBack: true,
          navigateTo: () {
            print("object");
            Get.back();
          },
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
            SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    //Get.to(() => UserProfile());
                  },
                  child: HomePageHeader(
                    title: 'Attendance Monitoring',
                    userType: "Parent",
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'My Children',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    InkWell(
                      onTap: () {
                        // Get.to(() => AttendanceCourseListScreen());
                      },
                      child: const Text(
                        'See All',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Obx(() {
                   if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else if (controller.userDetails.value.isEmpty) {
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
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.userDetails.value.length,
                    itemBuilder: (context, index) {
                      var userDetails = controller.userDetails.value[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: Card(
                          elevation: 10,
                          shadowColor: Colors.black,
                          surfaceTintColor: Colors.white,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 35,
                              // Optional: Set a background color
                              //backgroundColor: Colors.grey[200],
                              child: Icon(
                                Icons
                                    .person, // Correct usage: provide IconData directly
                                size: 36, // Adjust the icon size as needed
                                color: Colors.black, // Set the icon color
                              ),
                            ),
                            title: Text(userDetails.firstName!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.0,
                                  color: Colors.black,
                                )),
                            subtitle: Text(userDetails.wowId!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.0,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      );
                    });
  }}),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: const Text(
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
                              crossAxisSpacing: 10 // Number of columns
                              ),
                      itemBuilder: (context, int index) {
                        final item = controller.parentMonitorList[index];
                        Color myColor =
                            controller.parentMonitorList[index]['color'];

                        return InkWell(
                          onTap: () {
                            if (index == 1) {
                              Get.to(() => TrackTuteeLocation(), arguments: [
                                {"userId": widget.userId}
                              ]);
                            }
                            // if (item['title'] == 'Course list') {
                            //   var box = GetStorage();
                            //   Logger().i("${box.read('Token')}");
                            //   Get.to(() => const GetTopicsCourses(
                            //         type: 'Tutee',
                            //       ));
                            // }
                            // if (item['title'] == 'Enquires') {
                            //   classController.onInit();
                            //   Get.to(() => Tutorenquirlist(
                            //         type: 'Tutee',
                            //         fromBottomNav: true,
                            //       ));
                            // }
                            // if (item['title'] == 'Enrollments') {
                            //   enrollmentController.onInit();
                            //   Get.to(() => EnrollmentScreen(
                            //         type: 'Tutee',
                            //         fromBottomNav: true,
                            //       ));
                            // }
                            // if (item['title'] == 'Attendance') {
                            //   Get.to(
                            //       () => TuteeAttendanceList(
                            //             type: 'Tutee',
                            //           ),
                            //       arguments: "Tutee");
                            // }
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
                                      const Color.fromRGBO(246, 244, 254, 1)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: myColor),
                                    child: controller.parentMonitorList[index]
                                                ['image'] !=
                                            null
                                        ? Image.asset(
                                            controller.parentMonitorList[index]
                                                ['image'],
                                            color: Colors.white,
                                            height: 30,
                                          )
                                        : SizedBox.shrink(),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      controller.parentMonitorList[index]
                                          ['title'],
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: controller.parentMonitorList.length,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ));
  }
}
