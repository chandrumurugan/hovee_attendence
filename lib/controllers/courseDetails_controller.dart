import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/modals/addClassData_model.dart';
import 'package:hovee_attendence/modals/getClassTuteeById_model.dart';
import 'package:hovee_attendence/modals/submitEnquirModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/Tutee/tutee_courseDetails.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailController extends GetxController {
  var isLoading = true.obs;
  var classesList = [].obs;
  String? username, email, phoneNumber, organizationName;
 final UserProfileController controller =
      Get.put(UserProfileController());
  void getClassTuteeById(BuildContext context, String className, String subject,
      String TutorId) async {
       controller. fetchUserProfiles();
    isLoading.value = true;
    final storage = GetStorage();
    username = storage.read('firstName');
    email = storage.read('email');
    phoneNumber = storage.read('phoneNumber');
    organizationName = storage.read('organizationNames');
    try {
      var batchData = {
        'className': className,
        'subject': subject,
        'TutorId': TutorId,
      };

      final getClassTuteeByIdModel? response =
          await WebService.getClassTuteeById(batchData);

      if (response != null && response.statusCode == 200) {
        // SnackBarUtils.showSuccessSnackBar(
        //     context, 'Class and batch details retrieved successfully');

        // Pass response data to CourseDetailScreen
        Get.to(CourseDetailScreen(
          data: response.data!,
        ));
      } else {
        SnackBarUtils.showErrorSnackBar(context,
            response?.message ?? 'Failed to retrieve class and batch details');
      }
    } catch (e) {
      SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void addEnquirs(BuildContext context, String courseId, String studentId,
      String tutorId) async {
    isLoading.value = true;
    try {
      var batchData = {
        "courseId": courseId,
        "studentId": studentId,
        "tutorId": tutorId,
        "enquiry_message": "I want this course",
        "enquiryType": "Tutee" // Tutee or Tutor
      };

      final submitEnquiryModel? response =
          await WebService.addEnquirs(batchData);

      if (response != null && response.statusCode == 200) {
        SnackBarUtils.showSuccessSnackBar(
            context, response.message!);
          Get.back();
        // Show the modal bottom sheet
        showModalBottomSheet(
          isDismissible: false,
          enableDrag: false,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return CustomDialogBox(
              title1: 'Enquiry form details have been successfully sent',
              title2: '',
              subtitle:
                  'Note: Once the tutor is verified, we will notify you through a notification.',
              btnName: 'Ok',
              onTap: () {
                Get.back(); // Close the modal and navigate back
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

        Get.back(); // Optional: Close the current screen if needed
        onInit();
      } else {
        SnackBarUtils.showErrorSnackBar(
            context, response?.message ?? 'Failed to retrieve enquir details');
      }
    } catch (e) {
      SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

   void makePhoneCall(String number) async {
    String phoneNumber = 'tel:+$number'; // Replace with your phone number
    // ignore: deprecated_member_use
    if (await canLaunch(phoneNumber)) {
      // ignore: deprecated_member_use
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  void navigateBack() {
    Get.back();
  }
}
