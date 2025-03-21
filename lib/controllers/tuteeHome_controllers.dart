import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/enrollment_controller.dart';
import 'package:hovee_attendence/controllers/notification_controller.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/modals/getHomeDashboardModel.dart';
import 'package:hovee_attendence/modals/getmarkedNotification_model.dart';
import 'package:hovee_attendence/modals/userProfile_modal.dart';
import 'package:hovee_attendence/services/chat_service.dart';
import 'package:hovee_attendence/services/firestoreService.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';
import 'package:hovee_attendence/view/chat_screen/chat_screen.dart';
import 'package:hovee_attendence/view/enrollment_screen.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TuteeHomeController extends GetxController with GetSingleTickerProviderStateMixin{

  late AnimationController animationController;
  GlobalKey<ScaffoldState> tuteeScaffoldKey = GlobalKey<ScaffoldState>();
  var attendanceCourseList = [].obs;
  var isLoading = true.obs;
  final List<Map<String, dynamic>> tuteeMonitorList = [
    // {
    //   'title': 'Enquiries',
    //   'image': 'assets/online-learning (1) 1.png',
    //   'desc': 'Lorem Ipsum is simply dummy',
    //   'color': const Color.fromRGBO(126, 113, 255, 1)
    // },
    {
      'title': 'Attendance',
      'image': 'assets/tuteeHomeImg/desktop-computer 1.png',
      'desc': 'Lorem Ipsum is simply dummy',
      'color': const Color.fromRGBO(240, 119, 33, 1)
    },
    {
      'title': 'Courses',
      'image': 'assets/tutorHomeImg/online-learning (2) 1 (1).png',
      'desc': 'Lorem Ipsum is simply dummy',
      'color': const Color.fromRGBO(126, 113, 255, 1).withOpacity(0.7)
    },
    {
      'title': 'Enquiries',
      'image': 'assets/tuteeHomeImg/online-learning (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(81, 2, 112, 1)
    },
    {
      'title': 'Enrollment',
      'image': 'assets/tuteeHomeImg/leave 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(240, 119, 33, 1)
    },
    {
      'title': 'Leave',
      'image': 'assets/tuteeHomeImg/calendar (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(186, 1, 97, 1)
    },
    {
      'title': 'MSP',
      'image': 'assets/tuteeHomeImg/teacher (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(126, 113, 255, 1)
    },
    {
      'title': 'Chat',
      'image': 'assets/tuteeHomeImg/leave 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(240, 119, 33, 1)
    },
    {
      'title': 'Fees',
      'image': 'assets/tuteeHomeImg/online-learning (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(81, 2, 112, 1)
    },
    {
      'title': 'Payments',
      'image': 'assets/tuteeHomeImg/online-learning (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(81, 2, 112, 1)
    },
  ];

  var homeDashboardNavList = <NavbarItems>[].obs;
  var homeDashboardCourseList = <CourseList?>[].obs;
  var studentDetails = <StudentDetails>[].obs;
  var categories = <String>[].obs;
  var selectedIndex = 0.obs;
  var notificationList = [].obs;
  var notificationData = getMarkNotificationAsReadModel().data.obs;
  //final UserProfileController controller = Get.put(UserProfileController());
   var userProfileResponse = UserProfileM().obs;
  String? role;

  final otpController = TextEditingController();
  final focusNode = FocusNode();

  var savedOtp;

  final EnrollmentController enrollmentController =
      Get.put(EnrollmentController());

  LocationPermission? permission;
  Position? lastKnownLocation;

  var notificationCount = 0.obs; // Observable
  
  final NotificationController noticontroller = Get.put(NotificationController());

   final ChatService _chatService = ChatService();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
        animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
     fetchUserProfiles();
    startTrackingTuteeLocation();
    fetchHomeDashboardTuteeList();
    //fetchNotificationsType();
    fetchAttendanceCourseList();
     noticontroller.fetchNotifications('Tutee',false);
  }

  void fetchUserProfiles() async {
    final storage = GetStorage();
    isLoading(true);
    try {
      UserProfileM? fetchProfile = await WebService.fetchUserProfile();
      if (fetchProfile != null) {
        userProfileResponse.value = fetchProfile;
         SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('firstName', fetchProfile.data!.firstName!);
          prefs.setString('lastName', fetchProfile.data!.lastName!);
          prefs.setString('wowId', fetchProfile.data!.wowId!);
          prefs.setString('RoleType', fetchProfile.data!.rolesId!.roleName!);
        isLoading(false);
      } else {
        // SnackBarUtils.showErrorSnackBar(context, message)
        isLoading(false);
      }
    } catch (e) {
      print(e);
      isLoading(false);
    }
  }

  //getlocationupdates of tutee
  Future<void> startTrackingTuteeLocation() async {
    bool serviceEnabled;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        bool locationServiceRequest = await Geolocator.openLocationSettings();
        if (!locationServiceRequest) {
          throw 'Location services are disabled.';
        }
        // Wait for the user to enable location services
        await Future.delayed(const Duration(seconds: 1));
        // throw 'Location services are disabled.';
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }
    } catch (e) {
      print(e);
    }
  }

  void fetchAttendanceCourseList() async {
    try {
      isLoading(true);

      var attendanceCourseResponse =
          await WebService.fetchAttendanceCourseList();
      if (attendanceCourseResponse.data != null) {
        attendanceCourseList.value = attendanceCourseResponse.data!;
      }
    } catch (e) {
      // Get.snackbar('Failed to fetch batches');
    } finally {
      isLoading(false);
    }
  }

  void fetchHomeDashboardTuteeList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      isLoading(true);
      var homeDashboardResponse = await WebService.fetchHomeDashboardList();
      if (homeDashboardResponse != null) {
        // prefs.setString(
        //                                                   'Rolename',
        //                                                  homeDashboardResponse.roleName??
        //                                                       '');
        homeDashboardNavList.value = homeDashboardResponse.navbarItems!;
        studentDetails.value = homeDashboardResponse.studentDetails!;
        // Extracting notification count
        //var studentDetails = homeDashboardResponse!.studentDetails;
        print("ghetting value1234567890==");
        if (studentDetails.value != null && studentDetails.value.isNotEmpty) {
          // Getting the unreadNotificationCount of the first student
          homeDashboardCourseList.value = studentDetails[0].courseList!;

          // if (permission == LocationPermission.whileInUse ||
          //     permission == LocationPermission.always) {
            Geolocator.getPositionStream(
                locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
              distanceFilter: 10,
              // timeLimit: Duration(seconds: 10),
            )).listen((Position position) async {
              if (_shouldUpdateLocation(position)) {
                 lastKnownLocation = position;
                FirestoreService.updateTuteeLocation(
                    userId: studentDetails[0].wowId.toString(),
                    lat: position.latitude,
                    long: position.longitude,
                    username:
                        "${studentDetails[0].firstName} ${studentDetails[0].lastName}");
              }
            });
      
          // }

      
        }
      }
    } catch (e) {
      // Get.snackbar('Failed to fetch batches');
    } finally {
      isLoading(false);
    }
  }

  bool _shouldUpdateLocation(Position position) {
    if (lastKnownLocation == null) return true;

    final distance = Geolocator.distanceBetween(
      lastKnownLocation!.latitude,
      lastKnownLocation!.longitude,
      position.latitude,
      position.longitude,
    );

    return distance > 10; // Update only if moved >10m
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
     animationController.dispose();
  }

  // Future<void> startChat(BuildContext context) async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user == null) return;

  //   var agents = await FirebaseFirestore.instance
  //       .collection('users')
  //       .where('role', isEqualTo: 'agent')
  //       .where('isAvailable', isEqualTo: true)
  //       .limit(1)
  //       .get();

  //   if (agents.docs.isNotEmpty) {
  //     var agent = agents.docs.first;
  //     String chatId = FirebaseFirestore.instance.collection('chats').doc().id;

  //     await FirebaseFirestore.instance.collection('chats').doc(chatId).set({
  //       'customerId': user.uid,
  //       'agentId': agent.id,
  //       'isActive': true
  //     });

  //     await FirebaseFirestore.instance.collection('users').doc(agent.id).update({
  //       'isAvailable': false,
  //       'assignedChatId': chatId
  //     });
  //         await _chatService.sendNotificationToAgent(chatId, user.displayName ?? "Customer");

  //     Navigator.push(context, MaterialPageRoute(builder: (_) => CustomerChat(chatId: chatId)));
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No agents available")));
  //   }
  // }
}
