import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/enquir_controller.dart';
import 'package:hovee_attendence/controllers/userProfileView_controller.dart';
import 'package:hovee_attendence/modals/addClassData_model.dart';
import 'package:hovee_attendence/modals/getClassTuteeById_model.dart';
import 'package:hovee_attendence/modals/submitEnquirModel.dart';
import 'package:hovee_attendence/modals/submitEnquiryHostelModel.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/customDialogBox.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_enquiry_list.dart';
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
    }
  
  void getClassTuteeById(BuildContext context, String className, String subject,
      String TutorId,tutorname,fees,MaxSlots,startDate,endDate,String address,String courseId,ratings) async {
     
    isLoading.value = true;
   
   
    try {
      var batchData = {
        'className': className,
        'subject': subject,
        'TutorId': TutorId,
        'courseId':courseId,
      };

      final GetClassTuteeByIdModel? response =
          await WebService.getClassTuteeById(batchData);

      if (response != null && response.statusCode == 200) {
        // SnackBarUtils.showSuccessSnackBar(
        //     context, 'Class and batch details retrieved successfully');

        // Pass response data to CourseDetailScreen
        Get.to(CourseDetailScreen(
          data: response.data!, tutorname: response.data!.tutorDetails!.firstName ?? '',
          fees: fees.toString(), maxSlots: MaxSlots, startDate: startDate, endDate: endDate, address: address, ratings: ratings ?? '0' ,
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

  Future<bool> addEnquirs(BuildContext context, String courseId, String studentId,
      String tutorId,String batch,subject,tutorname) async {
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
        return true;
      } else {
        Get.snackbar(
          '',
  icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
   messageText:    SizedBox(
    height: 30, // Set desired height here
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        "Enquiry already submitted",
      textAlign: TextAlign.start,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
);
 return false;
      }
    } catch (e) {
          Get.snackbar(
         '',
  icon: const Icon(Icons.info, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
 messageText:    SizedBox(
    height: 30, // Set desired height here
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        "Error: $e",
      textAlign: TextAlign.start,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
);
 return false;
      //  Get.snackbar(icon: Icon(Icons.info,color: Colors.white,size: 40,)
      //   ,'Error: $e',);
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

  
    Future<bool> addHostelEnquirs(BuildContext context, String hostelId, String hostelObjectId,
      String hostellerObjectId) async {
    isLoading.value = true;
    try {
      var batchData = {
        "hostelId": hostelId,
        "hostel_ObjectId": hostelObjectId,
        "hosteller_ObjectId": hostellerObjectId,
        "enquiry_message": '',
      };

      final SubmitEnquiryHostelModel? response =
          await WebService.addEnquirsHostel(batchData);

      if (response != null && response.statusCode == 200) {
 return true;
        // Get.delete<EnquirDetailController>();
        //  Get.off(() => HostelEnquiryList(type: 'Hostel', fromBottomNav: true,)); 
      } else {
        Get.snackbar(
          '',
  icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
 messageText:    SizedBox(
    height: 30, // Set desired height here
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        "Enquiry already submitted",
      textAlign: TextAlign.start,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
);
return false;
      }
    } catch (e) {
          Get.snackbar(
         '',
  icon: const Icon(Icons.info, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
 messageText:    SizedBox(
    height: 30, // Set desired height here
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        "Error: $e",
      textAlign: TextAlign.start,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
);
return false;
      //  Get.snackbar(icon: Icon(Icons.info,color: Colors.white,size: 40,)
      //   ,'Error: $e',);
    } finally {
      isLoading.value = false;
    }
  }


}
