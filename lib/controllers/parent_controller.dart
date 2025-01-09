import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/modals/getHomeDashboardModel.dart';
import 'package:hovee_attendence/modals/getUserTokenList_model.dart';
import 'package:hovee_attendence/modals/login_data_model.dart';
import 'package:hovee_attendence/modals/parentLoginDataModel.dart';
import 'package:hovee_attendence/modals/parentLoginModel.dart';
import 'package:hovee_attendence/modals/update_parent_status_model.dart';
import 'package:hovee_attendence/modals/userProfile_modal.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/dashBoard.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/view/home_screen/tutee_home_screen.dart';
import 'package:hovee_attendence/view/home_screen/tutor_home_screen.dart';
import 'package:hovee_attendence/view/parent_otp_screen.dart';
import 'package:hovee_attendence/view/roleSelection.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class ParentController extends GetxController {
  GlobalKey<ScaffoldState> tuteeScaffoldKey = GlobalKey<ScaffoldState>();
  var isLoading = false.obs;
  var homeDashboardNavList = <NavbarItems>[].obs;
  var homeDashboardCourseList = <CourseList?>[].obs;
  var studentDetails = <StudentDetails>[].obs;
  var notificationCount = 0.obs;
  var selectedIndex = 0.obs;

  final logInController = TextEditingController();

  var deepLink = ''.obs;
  var code = ''.obs;

  final List<Map<String, dynamic>> parentMonitorList = [
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
      'title': 'GPS Tracking',
      'image': 'assets/tuteeHomeImg/location (1).png',
      'desc': 'Lorem Ipsum is simply dummy',
      'color': const Color.fromRGBO(126, 113, 255, 1).withOpacity(0.7)
    },
    {
      'title': 'Enrollment',
      'image': 'assets/tuteeHomeImg/calendar (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(186, 1, 97, 1)
    },
    {
      'title': 'Enquiries',
      'image': 'assets/tuteeHomeImg/online-learning (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(81, 2, 112, 1)
    },
    {
      'title': 'Holiday',
      'image': 'assets/tutorHomeImg/holiday 1 (1).png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(186, 1, 97, 1)
    },
    {
      'title': 'Leave',
      'image': 'assets/tutorHomeImg/leave 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromRGBO(126, 113, 255, 1)
    },
    {
      'title': 'Annoucement',
      'image': 'assets/tutorHomeImg/online-learning (1) 1.png',
      'desc': 'Lorem Ipsum is simply dummy ',
      'color': const Color.fromARGB(255, 240, 75, 226)
    },
    // {
    //   'title': 'MSP',
    //   'image': 'assets/tuteeHomeImg/teacher (1) 1.png',
    //   'desc': 'Lorem Ipsum is simply dummy ',
    //   'color': const Color.fromRGBO(126, 113, 255, 1)
    // },
    // {
    //   'title': 'Fees',
    //   'image': 'assets/tuteeHomeImg/online-learning (1) 1.png',
    //   'desc': 'Lorem Ipsum is simply dummy ',
    //   'color': const Color.fromRGBO(81, 2, 112, 1)
    // },
    // {
    //   'title': 'Payments',
    //   'image': 'assets/tuteeHomeImg/online-learning (1) 1.png',
    //   'desc': 'Lorem Ipsum is simply dummy ',
    //   'color': const Color.fromRGBO(81, 2, 112, 1)
    // },
  ];
  //UserProfileController

  var userDetails = <UserId>[].obs;
  var userStoredData = <UserId>[].obs;

  final otpController = TextEditingController();

  var otpResponse = validateAndLoginParentModal().obs;
  var loginResponse = parentLoginModal().obs;

  final focusNode = FocusNode();
  UserDetail? childrenData;

  var userID = ''.obs;
  ParentData? parentdata;

  LoginData? loginData;
  UserDetail? userDetail;

  var userProfileResponse = UserProfileM().obs;

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //  // getUserData();
  //   //fetchHomeDashboardTuteeList();

  // }

  // void fetchHomeDashboardTuteeList() async {
  //   try {
  //     isLoading(true);
  //     var homeDashboardResponse = await WebService.fetchHomeDashboardList();
  //     if (homeDashboardResponse != null) {
  //       homeDashboardNavList.value = homeDashboardResponse.navbarItems!;
  //       studentDetails.value = homeDashboardResponse.studentDetails!;
  //       // Extracting notification count
  //       //var studentDetails = homeDashboardResponse!.studentDetails;
  //       if (studentDetails.value != null && studentDetails.value.isNotEmpty) {
  //         // Getting the unreadNotificationCount of the first student
  //         homeDashboardCourseList.value = studentDetails[0].courseList!;
  //       }
  //       getUserTokenList(homeDashboardResponse.partentId!.id!);
  //     }
  //   } catch (e) {
  //     // Get.snackbar('Failed to fetch batches');
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
 
    // fetchUserProfiles();
    
   
  }

  void getUserTokenList(String parentId) async {
    isLoading.value = true;
    try {
      var batchData = {
        "parentId": parentId,
      };

      // Fetch the data from the WebService
      final getUserTokenListModel? response =
          await WebService.getUserTokenList(batchData);

      if (response != null && response.statusCode == 200) {
        // Get the userId list from the response
        userDetails.value = response.data!.userId!;
        List<UserId>? userIds = response.data?.userId;

        if (userIds != null && userIds.isNotEmpty) {
          // Get the first UserId object (index 0)
          UserId firstUser = userIds[0];

          // Convert UserId object to JSON string
          String userJson = firstUser.toJson().toString();

          // Save the JSON string in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String? userDataJson = prefs.getString('firstUserId');

          if (userDataJson != null) {
            // Decode the JSON string into a Map
            Map<String, dynamic> userMap = jsonDecode(userDataJson);

            // Retrieve the wowId and name from the Map
            String wowId = userMap['wowId'];
            String name = userMap['name'];
            String token = userMap['token '];
            prefs.setString('Token', token);
            // Debugging: Check if the values are retrieved correctly
            print('User ID: $wowId, User Name: $name');
          } else {
            print('No user data found in SharedPreferences');
          }

          // userDetails.value = firstUser.sId!;
        } else {
          // Handle empty userId list
          print('UserId list is empty');
        }
      } else {
        // Handle API failure or response error
        print('Failed to fetch user token list');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  bool validateLogin(BuildContext context) {
    String input = logInController.text.trim();

    // Check if the input is a phone number (10 digits)
    if (RegExp(r'^[0-9]+$').hasMatch(input)) {
      if (input.length != 10) {
        SnackBarUtils.showErrorSnackBar(
          context,
          'Invalid Phone number',
        );
        return false;
      }
      return true; // It's a valid phone number
    }
    // If the input is a valid email
    return true;
  }

  bool validateOtp(BuildContext context) {
    if (otpController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the acceptance code',
      );
      return false;
    }
    return true;
  }

  Future<parentLoginModal?> logIn(
      String identifiers, BuildContext context) async {
    if (validateLogin(context)) {
      isLoading.value = true;
      try {
        var response = await WebService.parentLogin(identifiers, context);
        if (response != null) {
          loginResponse.value = response;
          isLoading.value = false;
          logInController.clear();
          return response;
        } else {
          isLoading.value = false;
          return null;
        }
      } catch (e) {
        print(e);
        return null;
      }
    }
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

//  void getValidateLink(String identifiers) async {
//               var parentresponse = await WebService.getParentInviteCode(identifiers);
//         if (parentresponse != null) {
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             deepLink.value=parentresponse.data!.invitationLink!;
//            code.value= parentresponse.data!.parentCode!;
//            prefs.setString('deepLink',parentresponse.data!.invitationLink!);
//             prefs.setString('OtpCode',parentresponse.data!.parentCode!);
//             code.value =prefs.getString('OtpCode')??'';
//             prefs.setString('Token','');
//             print(' ${prefs.setString('deepLink',parentresponse.data!.invitationLink!)}');
//              print(' ${code.value}');
//          //print(code);
//            print(deepLink);
//           // showDialog(
//           //   context: context,
//           //   barrierDismissible: false,
//           //   builder: (BuildContext context) {
//           //     return AlertDialog(
//           //       title: Text('Success'),
//           //       content: Column(
//           //         children: [
//           //           Text('Deeplink: ${deepLink.value}'),
//           //           Text('Code: ${parentresponse.data!.parentCode!}'),
//           //         ],
//           //       ),
//           //       actions: [
//           //         TextButton(
//           //           onPressed: () {
//           //             Clipboard.setData(ClipboardData(text: deepLink.value!));
//           //             ScaffoldMessenger.of(context).showSnackBar(
//           //               SnackBar(
//           //                   content: Text('Deeplink copied to clipboard!')),
//           //             );
//           //             Navigator.of(context).pop(); // Close the dialog
//           //           },
//           //           child: Text('Copy'),
//           //         ),
//           //         TextButton(
//           //           onPressed: () {
//           //             Share.share(deepLink.value!);
//           //             Navigator.of(context).pop(); // Close the dialog
//           //           },
//           //           child: Text('Share'),
//           //         ),
//           //       ],
//           //     );
//           //   },
//           // );
//   String url = deepLink.value;

//   // Parse the URL
//   Uri uri = Uri.parse(url);

//   // Extract the 'code' query parameter
//   String? code1 = uri.queryParameters['code'];

//     prefs.setString('code', code1!);

//   if (code != null) {
//     print('Extracted Code: $code1');
//    //Get.to(() => ParentOtpScreen());

//   } else {
//     print('Code parameter not found in the URL');
//   }
//         } else {
//           Logger().e('Failed to load AppConfig');
//           isLoading.value = false;
//         }
//   }

  Future<validateAndLoginParentModal?> otp(BuildContext context) async {
    if (validateOtp(context)) {
      isLoading.value = true;
      try {
        // Logger().i("moving to otp ===>$");
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final accountVerificationToken = Get.arguments['code'] ?? '';
        var response = await WebService.otpParent(
            otpController.text, accountVerificationToken, context);
        if (response != null) {
          otpResponse.value = response;
          userID.value = otpResponse.value.userDetail!.sId.toString();
          userDetail = otpResponse.value.userDetail!;
          print(userID.value);
          prefs.setString('Token', response.parentToken!);
          prefs.setString('WowId', otpResponse.value.userDetail!.wowId!);
          // prefs.setString('Rolename', response.data!.roles!.roleName??'');
          //  var validateTokendata = response.parentDetail!;
          //   //if(response.parentData=='true'){
          //     fetchHomeDashboardTuteeList();
          //     getUserTokenList(response.parentDetail!.sId!);
          //  // }

          // LoginData loginData = LoginData(
          //   firstName: validateTokendata.firstName,
          //   lastName: validateTokendata.lastName,
          //   wowId: validateTokendata.wowId,
          // );
          // prefs.setString('userData', jsonEncode(loginData.toJson()));
          // getUserData();
          isLoading.value = false;
          //getUserTokenList(otpResponse.value.parentDetail!.sId!);
          return response;
        } else {
          isLoading.value = false;
          return null;
        }

        //     Get.snackbar(
        // '', response.message!);
      } catch (e) {
        print(e);
        return null;
      }
    }
  }

  void updateEnrollment(
    BuildContext context,
    String parentId,
    String userId,
  ) async {
    isLoading.value = true;
    try {
      var batchData = {"parentId": parentId, "userId": userId};
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final UpdateParentStausModel? response =
          await WebService.updateParentStatus(batchData);

      if (response != null && response.statusCode == 200) {
        parentdata = response.data;
        //fetchHomeDashboardTuteeList();
        // getUserTokenList(response.data!.sId!);
        // }
        // getUserTokenList(parentId);
        //   loginData = LoginData(
        //       firstName: parentdata!.firstName,
        //       lastName: parentdata!.lastName,
        //       wowId: parentdata!.wowId,
        //       id: parentdata!.sId
        //     );
        //     prefs.setString('userData', jsonEncode(loginData!.toJson()));
        //  await getUserData();
        Get.snackbar(
          icon: const Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 40,
          ),
          response.message!,
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
        );
        Get.off(() => DashboardScreen(rolename: 'Parent'));
      } else {
        Get.snackbar(
          icon: const Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 40,
          ),
          response!.message!,
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
        );
      }
    } catch (e) {
      //SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateParentStatus(
    BuildContext context,
    String parentId,
    String userId,
  ) async {
    isLoading.value = true;
    try {
      var batchData = {"parentId": parentId, "userId": userId};
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final UpdateParentStausModel? response =
          await WebService.updateParentStatus(batchData);

      if (response != null && response.statusCode == 200) {
        parentdata = response.data;
        Get.snackbar(
          icon: const Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 40,
          ),
          'Accepted successfully',
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
        );
        Get.offAll(() =>  RoleSelection(
              isFromParentOtp: false,
              parentId:parentId, isGoogleSignIn: false,
            ));
      } else {
        Get.snackbar(
          icon: const Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 40,
          ),
          response!.message!,
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
        );
      }
    } catch (e) {
      //SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
