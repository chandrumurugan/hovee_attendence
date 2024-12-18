// class AuthControllers extends GetxController
//     with GetSingleTickerProviderStateMixin{

//     }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/modals/appConfigModal.dart';
import 'package:hovee_attendence/modals/userProfile_modal.dart';
import 'package:hovee_attendence/services/firestoreService.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
// import 'package:hovee_attendence/services/webServices.dart';

class UserProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final box = GetStorage();
  late AuthControllers authControllers;
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
    final additionalInfoController = TextEditingController();
      final tuteorganizationController = TextEditingController();

  //education info
  // Dropdown values
  var highestQualification = ''.obs;
  var QualificationClass = ''.obs;
  var board = ''.obs;
  var organizationName = ''.obs;

  var highestQualifications = ''.obs;
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

  List<String> qualifications = [];
  List<String> skills = [];
  List<String> techs = [];
  List<String> techsExperience = [];
  List<String> tuteeQualifications = [];
  List<String> tuteeSpeciallizationClass = [];

  List<String> qualificationsProfile = ['School', 'College'];
  List<String> classProfile = [
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
    'Class 5'
  ];

  var qualificationsProfile1 = ''.obs;
  var classProfile1 = ''.obs;

  var personalInfo = {}.obs;
  var addressInfo = {}.obs;
  var educationInfo = {}.obs;

  var roleId =''.obs;
   var roleTypeId =''.obs;

   double? latitude, longitude;

   var tuteEducationInfo = {}.obs;

  void setHighestQualification(String value) =>
      highestQualification.value = value;
  //void setTeachingSkills(String value) => teachingSkills.value = value;
  void setWorkingTech(String value) => QualificationClass.value = value;
  void setTeachingExperience(String value) => board.value = value;
  void setAdditionalInfo(String value) => organizationName.value = value;
  void setHighestQualificationProfile(String value) =>
      qualificationsProfile1.value = value;
  void setHighestQualificationClassProfile(String value) =>
      classProfile1.value = value;

  void setHighestQualifications(String value) =>
      highestQualification.value = value;
  void setTeachingSkills(String value) => teachingSkills.value = value;
  void setWorkingTechs(String value) => workingTech.value = value;
  void setTeachingExperiences(String value) => teachingExperience.value = value;
  void setAdditionalInfos(String value) => additionalInfo.value = value;

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

   bool validatePersonalFields(BuildContext context) {
    if (firstNameController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the first name.',
      );
      return false;
    }
    if (lastNameController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the last name.',
      );
      return false;
    }
    if (emailController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the email.',
      );
      return false;
    }
    // Email format validation
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Invalid email format',
      );
      return false;
    }
    if (dobController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please select the DOB.',
      );
      return false;
    }

    if (phController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the mobile number.',
      );
      return false;
    }
    if (!RegExp(r'^[0-9]{10}$').hasMatch(phController.text)) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Invalid mobile number',
      );
      return false;
    }

    if (pincodeController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the pincode.',
      );
      return false;
    }

    // if (pincodeController.text.length != 6) {
    //  SnackBarUtils.showSuccessSnackBar(context,'Invalid pincode.',);
    //   return false;
    // }

    if (selectedIDProof.value.isEmpty && idProofController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please select the Id proof',
      );
      return false;
    }

    // Add more validation as needed
    return true;
  }

  bool validateAddressInfo(BuildContext context) {
    if (address1Controller.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please enter the door no",
      );
      return false;
    }
    if (address2Controller.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please enter the street & area",
      );
      return false;
    }
    if (cityController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please enter the city",
      );
      return false;
    }
    if (stateController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please enter the state",
      );
      return false;
    }
    if (countryController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please enter the country",
      );
      return false;
    }
    if (pincodesController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please enter the pincode",
      );
      return false;
    }

    // if (pincodesController.text.length != 6) {
    //    SnackBarUtils.showSuccessSnackBar(context,'Invalid pincode.',);
    //   return false;
    // }
    return true;
  }

    bool validateAllTabs(BuildContext context) {
    // Validate Personal Info
    if (!validatePersonalFields(context)) {
      // Navigate to the personal info tab
      validatePersonalFields(context);
      return false;
    }

    // Validate Address Info
    if (!validateAddressInfo(context)) {
      // Navigate to the address tab
      validateAddressInfo(context);
      return false;
    }

    // Validate Education Info (both general and tutee education info)
    if (!validateFields(context)) {
      // Navigate to the education tab
      tabController.animateTo(2);
      return false;
    }

    // All validations passed
    return true;
  }

   bool validateFields(BuildContext context) {
    validationMessages.clear();

    if (highestQualification.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please select a highest qualification.",
      );
      return false;
    }
    if (teachingSkills.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please select a teaching skill set.',
      );
      return false;
    }
    if (workingTech.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please select a work type.',
      );
      return false;
    }
    if (teachingExperience.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please select your teaching experience.',
      );
      return false;
    }
    if (resumePath.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please attach  a resume.',
      );
      return false;
    }
    if (experienceCertPath.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please attach a experience certificate.',
      );
      return false;
    }
    return true;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    authControllers = Get.find<AuthControllers>();
    tabController = TabController(length: 3, vsync: this);
    Logger().i(token.read('Token') ?? "");
     qualifications = getQualifications();
      skills = getSkills();
    techs = getTechs();
    techsExperience = getTechsExperiencechs();
     tuteeQualifications = getTuteeQualifications();
    fetchUserProfiles();
    _loadDropdownData();
  }

  void _loadDropdownData() async {
    // Load data from GetStorage into lists
    qualifications = getQualifications();
    
    skills = getSkills();
    techs = getTechs();
    techsExperience = getTechsExperiencechs();
    tuteeSpeciallizationClass = getSkills();
    tuteeQualifications = getTuteeQualifications();
              Logger().i("gettoing1234567890====");
              

  }

    List<String> getTuteeQualifications() {
    final storage = GetStorage();
    final appConfigDataTuteeQualifications = storage.read('appConfig');

    if (appConfigDataTuteeQualifications != null) {
      final appConfig = AppConfig.fromJson(appConfigDataTuteeQualifications);
      if (appConfig.data != null) {
        return appConfig.data!.tuteeHighestQualification!
            .map((item) => item.label ?? '')
            .toList();
      }
    }
    return [];
  }

    List<String> getQualifications() {
    final storage = GetStorage();
    final appConfigData = storage.read('appConfig');

    if (appConfigData != null) {
      final appConfig = AppConfig.fromJson(appConfigData);
      if (appConfig.data != null) {
        return appConfig.data!.highestQualification!
            .map((item) => item.label ?? '')
            .toList();
      }
    }
    return [];
  }
    List<String> getSkills() {
    final storage = GetStorage();
    final appConfigDataSkills = storage.read('appConfig');

    if (appConfigDataSkills != null) {
      final appConfig = AppConfig.fromJson(appConfigDataSkills);
      if (appConfig.data != null) {
        return appConfig.data!.teachingSkill!
            .map((item) => item.label ?? '')
            .toList();
      }
    }
    return [];
  }

    List<String> getTechs() {
    final storage = GetStorage();
    final appConfigDatatechs = storage.read('appConfig');

    if (appConfigDatatechs != null) {
      final appConfig = AppConfig.fromJson(appConfigDatatechs);
      if (appConfig.data != null) {
        return appConfig.data!.teaching!
            .map((item) => item.label ?? '')
            .toList();
      }
    }
    return [];
  }

    List<String> getTechsExperiencechs() {
    final storage = GetStorage();
    final appConfigDatatechsExperience = storage.read('appConfig');

    if (appConfigDatatechsExperience != null) {
      final appConfig = AppConfig.fromJson(appConfigDatatechsExperience);
      if (appConfig.data != null) {
        return appConfig.data!.workExperience!
            .map((item) => item.label ?? '')
            .toList();
      }
    }
    return [];
  }



  void fetchUserProfiles() async {
    final storage = GetStorage();
    isLoading(true);
    try {
      UserProfileM? fetchProfile = await WebService.fetchUserProfile();
      if (fetchProfile != null) {
        userProfileResponse.value = fetchProfile;
        _populateFieldsFromResponse(fetchProfile.data!);
        String organizationName =
            fetchProfile.data!.qualificationDetails.first.organizationName??'';
        // Store relevant fields in GetStorage
        storage.write('doorNo', fetchProfile.data!.doorNo);
        storage.write('street', fetchProfile.data!.street);
        storage.write('city', fetchProfile.data!.city);
        storage.write('state', fetchProfile.data!.state);
        storage.write('country', fetchProfile.data!.country);
        storage.write('pincode', fetchProfile.data!.pincode);
        storage.write('id', fetchProfile.data!.id);
        String name = "${fetchProfile.data!.firstName} "
            "${fetchProfile.data!.lastName}";
        storage.write('firstName', name);
        storage.write('email', fetchProfile.data!.email);
        storage.write('phoneNumber', fetchProfile.data!.phoneNumber);
        storage.write('organizationNames', organizationName);
        storage.write('role', fetchProfile.data!.rolesId!.roleName!);
        String address = "${fetchProfile.data!.doorNo}, "
            "${fetchProfile.data!.street}, "
            "${fetchProfile.data!.city}, "
            "${fetchProfile.data!.state}, "
            "${fetchProfile.data!.country} - "
            "${fetchProfile.data!.pincode}";
        storage.write('address', address);

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

  void _populateFieldsFromResponse(UserData userdata) {
    phController.text = userdata.phoneNumber ?? "";
    firstNameController.text = userdata.firstName ?? "";
    lastNameController.text = userdata.lastName ?? "";
    emailController.text = userdata.email ?? "";
    dobController.text = userdata.dob ?? "";
    pincodeController.text =
        userdata.pincode.toString() ?? "";
    selectedIDProof.value = userdata.idProofLabel ?? "";

    //adddress
    address1Controller.text = userdata.doorNo ?? "";
    address2Controller.text = userdata.street ?? "";
    cityController.text = userdata.city ?? "";
    stateController.text = userdata.state ?? "";
    countryController.text = userdata.country ?? "";
    stateController.text = userdata.state ?? "";
    tuteorganizationController.text=userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].organizationName ?? ""
        : "";
    pincodesController.text = userdata.pincode.toString() ?? "";
    additionalInfoController.text=userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].additionalInfo ?? ""
        : "";

    //  education info
    highestQualifications.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].highestQualification ?? ""
        : "";
    QualificationClass.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].selectClass ?? ""
        : "";
    board.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].selectBoard ?? ""
        : "";
    organizationName.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].organizationName ?? ""
        : "";
    additionalInfo.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].additionalInfo ?? ""
        : "";

    highestQualification.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].highestQualification ?? ""
        : "";
    teachingSkills.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].teachingSkillSet ?? ""
        : "";
    workingTech.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].workingTech ?? ""
        : "";
    teachingExperience.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].teachingexperience ?? ""
        : "";
    additionalInfo.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].additionalInfo ?? ""
        : "";
  }

  Future<void> storePersonalInfo(
      BuildContext context,) async {
    if (validatePersonalFields(context)) {
      personalInfo.value = {
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "email": emailController.text,
        "dob": dobController.text,
        "phone_number": phController.text,
        "pincode": pincodeController.text,
        "user_type": 2,
        "id_proof_label": idProofController.text,
       
      };
      tabController.animateTo(1);
      Logger().i(personalInfo.value);
    }
  }

  void storeAddressInfo(BuildContext context, String selectedRoleTypeName,
      ) {
    if (validateAddressInfo(context)) {
      String address = "${address1Controller.text}, "
          "${address2Controller.text}, "
          "${cityController.text}, "
          "${stateController.text}, "
          "${countryController.text} - "
          "${pincodesController.text}";
      addressInfo.value = {
        "door_no": address1Controller.text,
        "street": address2Controller.text,
        "city": cityController.text,
        "state": stateController.text,
        "country": countryController.text,
        "pincode": pincodesController.text,
        "phone_number": phController.text,
        "address": address,
      };
      // selectedRoleTypeName == 'I Run an Institute'
         // submitAccountSetup(context);
      //     : Container();
      // selectedRoleTypeName != 'I Run an Institute'
           tabController.animateTo(2);
         // : Container();
    }
  }

   Future<void> submitAccountSetup(
     BuildContext context) async {
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    // final token = box.read('Token') ?? '';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    Get.log("Latitude: ${latitude}, Longitude: ${longitude}");
    latitude = prefs.getDouble('latitude');
    longitude = prefs.getDouble('longitude');
    isLoading.value = true;
    try {
      // Call the API using the WebService
      http.StreamedResponse response = await WebService.submitAccountSetupEdit(
          token: token, // Add the actual token here
          personalInfo: personalInfo.value,
          addressInfo: addressInfo.value,
          educationInfo: educationInfo.value,
          resumePath: '',
          educationCertPath: '',
          experienceCertPath: '',
          latitude: latitude.toString(),
          longitude: longitude.toString());

      // Handle the response
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        // print(responseBody);
        // SnackBarUtils.showSuccessSnackBar(
        //     context, "Account setup successfully completed.");
        Get.offAll(() => DashboardScreen(
              rolename: 'Tutor',
            ));
        //Get.offAll(() => TutorHome());
        // Handle success (e.g., show a success message)
      } else {
        print(response.statusCode);
        // Handle failure (e.g., show an error message)
      }
    } catch (e) {
      print('Error occurred: $e');
      // Handle any exception (e.g., network failure)
    } finally {
      isLoading.value = false;
    }
  }

    void storeEducationInfo(
      BuildContext context) {
    if (!validateAllTabs(context)) {
    } else {
      if (validateFields(context)) {
        educationInfo.value = {
          "highest_qualification": highestQualification.value,
          "teaching_skill_set": teachingSkills.value,
          "working_tech": workingTech.value,
          "teaching_experience": teachingExperience.value,
          "additional_info": additionalInfoController.text,
        };
        submitAccountSetup(context);
      }
    }
  }

    void storeTuteeeducationInfo(
      BuildContext context) {
    if (!validateAllTabs1(context)) {
    } else {
      if (validateTuteEducationInfo(context)) {
        tuteEducationInfo.value = {
          "highest_qualification": highestQualifications.value,
          "select_class": QualificationClass.value,
          // "select_board": tuteeboardController.text,
          "organization_name": tuteorganizationController.text
        };
        submitTuteeAccountSetup( context);
      }
    }
  }

  bool validateAllTabs1(BuildContext context) {
    // Validate Personal Info
    if (!validatePersonalFields(context)) {
      // Navigate to the personal info tab
      validatePersonalFields(context);
      return false;
    }

    // Validate Address Info
    if (!validateAddressInfo(context)) {
      // Navigate to the address tab
      validateAddressInfo(context);
      return false;
    }

    // Validate Education Info (both general and tutee education info)
    if (!validateTuteEducationInfo(context)) {
      // Navigate to the education tab
      tabController.animateTo(2);
      return false;
    }

    // All validations passed
    return true;
  }

   bool validateTuteEducationInfo(BuildContext context) {
    if (highestQualifications.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please select highest qualification.",
      );
      return false;
    }
    if (QualificationClass.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please select class/specialization.",
      );
      return false;
    }
    // if(tuteeboardController.text.isEmpty){
    //     SnackBarUtils.showErrorSnackBar(
    //       context, "Please enter board.");
    //       return false;

    // }
    if (tuteorganizationController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please enter the school/college/other.",
      );
      return false;
    }
    return true;
  }

  Future<void> submitTuteeAccountSetup(
     BuildContext context) async {
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    //final token = box.read('Token') ?? '';
    Logger().i(personalInfo.value);
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
   
    latitude = prefs.getDouble('latitude');
    longitude = prefs.getDouble('longitude');
    isLoading.value = true;
      Logger().i("Latitude====>: ${latitude}, Longitude: ${longitude}");
    try {
      http.StreamedResponse response = await WebService.submitTuteeAccountSetupEdit(
          token: token, // Add the actual token here
          personalInfo: personalInfo.value,
          addressInfo: addressInfo.value,
          educationInfo: tuteEducationInfo.value,
          latitude: latitude.toString(),
          longitude: longitude.toString()
          // resumePath: '',
          // educationCertPath: '',
          // experienceCertPath: '',
          // roleId:roleId ,
          // roleTypeId: roleTypeId
          );
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print(responseBody);
        SnackBarUtils.showSuccessSnackBar(
            context, "Account setup successfully completed.");
        Get.offAll(() => DashboardScreen(
              rolename: 'Tutee',
            ));
        //Get.offAll(() => TutorHome());
        // Handle success (e.g., show a success message)
      } else {
        print(response.statusCode);
        // Handle failure (e.g., show an error message)
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

}
