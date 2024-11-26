import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/enquir_controller.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/modals/addClassData_model.dart';
import 'package:hovee_attendence/modals/getClassTuteeById_model.dart';
import 'package:hovee_attendence/modals/submitEnquirModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/Tutee/tutee_courseDetails.dart';
import 'package:hovee_attendence/view/Tutor/tutorEnquirList.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailController extends GetxController {
  var isLoading = true.obs;
  var classesList = [].obs;
  String? username, email, phoneNumber, organizationName,storedAddress ;
 final UserProfileController controller =
      Get.put(UserProfileController());

      @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUserDeatils();
  }
   void fetchUserDeatils(){
         controller. fetchUserProfiles();
          final storage = GetStorage();
          username = storage.read('firstName');
    email = storage.read('email');
    phoneNumber = storage.read('phoneNumber');
    organizationName = storage.read('organizationNames');
    storedAddress = storage.read('address');
    print(organizationName);
    }
  
  void getClassTuteeById(BuildContext context, String className, String subject,
      String TutorId,tutorname) async {
     
    isLoading.value = true;
   
   
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
        Get.off(CourseDetailScreen(
          data: response.data!, tutorname: tutorname,
        ));
      } else {
         SnackBarUtils.showSuccessSnackBar(context,
            response?.message ?? 'Failed to retrieve class and batch details',);
      }
    } catch (e) {
        SnackBarUtils.showSuccessSnackBar(context, 'Error: $e',);
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
         //SnackBarUtils.showSuccessSnackBar(context,'Enquiry submited successfully',);
         Get.snackbar('Enquiry submited successfully',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
        Get.delete<EnquirDetailController>();
         Get.off(() => Tutorenquirlist(type: 'Tutee', fromBottomNav: true,)); 
      } else {
        Get.snackbar('Enquiry already submitted',colorText: Colors.white,backgroundColor: Color.fromRGBO(186, 1, 97, 1),);
      }
    } catch (e) {
       Get.snackbar('Error: $e',);
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
