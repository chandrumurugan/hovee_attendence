
// class AuthControllers extends GetxController
//     with GetSingleTickerProviderStateMixin{

//     }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/modals/userProfile_modal.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class UserProfileController extends GetxController with GetSingleTickerProviderStateMixin{


 final box = GetStorage();

  late TabController tabController;
  var currentTabIndex = 0.obs;
    RxBool isLoading = false.obs;


    //personaL INFO
      final phController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();

  final pincodeController = TextEditingController();
  final idProofController = TextEditingController();
  var selectedIDProof = ''.obs;

    //address info
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final pincodesController = TextEditingController();

    //education info
  // Dropdown values
  var highestQualification = ''.obs;
  var teachingSkills = ''.obs;
  var workingTech = ''.obs;
  var teachingExperience = ''.obs;

  // Additional info text field
  var additionalInfo = ''.obs;

  // File paths for uploads
  var resumePath = ''.obs;
  var educationCertPath = ''.obs;
  var experienceCertPath = ''.obs;
   var userProfileResponse = UserProfileM().obs;

  // Validation messages
  var validationMessages = <String>[].obs;

    final List<String> qualifications = [
    'PhD',
    'Masters',
    'Bachelors',
    'Diploma'
  ];
  final List<String> skills = [
    'CBSE(1-5)',
    'CBSE(1-7)',
    'CBSE(1-9)',
    'CBSE(1-10)',
    "CBSE(1-12)"
  ];
  final List<String> techs = ['Full Time', 'Part Time'];
  final List<String> techsExperience = ['1yr', '3yrs', '5yrs', '7yrs'];
    void setHighestQualification(String value) =>
      highestQualification.value = value;
  void setTeachingSkills(String value) => teachingSkills.value = value;
  void setWorkingTech(String value) => workingTech.value = value;
  void setTeachingExperience(String value) => teachingExperience.value = value;
  void setAdditionalInfo(String value) => additionalInfo.value = value;

  Future<void> pickFile(String type) async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
       Logger().i(file.path);
      if (type == 'resume') {
       
        resumePath.value = file.path;
      } else if (type == 'education') {
        educationCertPath.value = file.path;
      } else if (type == 'experience') {
        experienceCertPath.value = file.path;
      }
    }
  }

 var token = GetStorage();

    @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
       tabController = TabController(length: 3, vsync: this);
        Logger().i(token.read('Token') ?? "");
       fetchUserProfiles();
   


  }

  void fetchUserProfiles()async{
    isLoading(true);
    try {
    UserProfileM? fetchProfile = await WebService.fetchUserProfile();
      if(fetchProfile != null){
        userProfileResponse.value = fetchProfile;
        _populateFieldsFromResponse(fetchProfile.data!);
         isLoading(false);
    
      
      }
      else{
        // SnackBarUtils.showErrorSnackBar(context, message)
         isLoading(false);
      }

    } catch (e) {
      print(e); 
       isLoading(false);

    }
  }

  void _populateFieldsFromResponse(UserData userdata){
    phController.text = userdata.phoneNumber ?? "";
    firstNameController.text = userdata.firstName ?? "";
    lastNameController.text = userdata.lastName ?? "";
    emailController.text = userdata.email ?? "";
    dobController.text = userdata.dob ?? "";
    pincodeController.text = userdata.pincode.toString() ?? "";
    selectedIDProof.value = userdata.idProofLabel ?? "";

    //adddress
    address1Controller.text = userdata.doorNo ?? "";
    address2Controller.text = userdata.street ?? "";
    cityController.text = userdata.city ?? "";
    stateController.text = userdata.state??"";
    countryController.text = userdata.country ?? "";
    stateController.text = userdata.state ?? "";

    pincodesController.text = userdata.pincode.toString() ?? "";


  //  education info
    highestQualification.value = userdata.qualificationDetails.isNotEmpty ? userdata.qualificationDetails[0].highestQualification ?? "" : "";
    teachingSkills.value =  userdata.qualificationDetails.isNotEmpty ? userdata.qualificationDetails[0].teachingSkillSet ?? "" : "";
    workingTech.value =  userdata.qualificationDetails.isNotEmpty ? userdata.qualificationDetails[0].workingTech ?? "" : "";
    teachingExperience.value = userdata.qualificationDetails.isNotEmpty ? userdata.qualificationDetails[0].workingTech ?? "" : "";
    additionalInfo.value =  userdata.qualificationDetails.isNotEmpty ? userdata.qualificationDetails[0].additionalInfo ?? "" : "";


  }


}