// class AuthControllers extends GetxController
//     with GetSingleTickerProviderStateMixin{

//     }

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/modals/appConfigModal.dart';
import 'package:hovee_attendence/modals/login_data_model.dart';
import 'package:hovee_attendence/modals/phonenumberVerfication_model.dart';
import 'package:hovee_attendence/modals/userProfile_modal.dart';
import 'package:hovee_attendence/services/firestoreService.dart';
import 'package:hovee_attendence/services/liveLocationService.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/view/loginSignup/otp_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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
     final tutionController = TextEditingController();
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

    var boardController = ''.obs;
    var classController = ''.obs;
      var subjectController = ''.obs;

      List<String> board1 = [];
   RxList<String> classList = <String>[].obs;
   RxList<String> subject = <String>[].obs;
   var appConfig = AppConfig().obs;
    List<String> batchName = [];

    RxBool isNonEdit = true.obs;
    File? pickedFile;
     RxBool accountVerified = false.obs;
     PhnData? loginResponse;

     var isPhoneNumberVerified = false.obs;

     final TextEditingController autoCompleteController = TextEditingController();

     var isLocationSearched = false.obs;

     var latitudeL = 0.0.obs;
  var longitudeL = 0.0.obs;
   var focusNode = FocusNode();
   late GoogleMapController mapController;
    var marker = Rxn<Marker>();
     var isFirstTime = true.obs;

     final updatePhController = TextEditingController();

     var image = Rx<File?>(null);
     final ImagePicker picker = ImagePicker();

     String? profileImage;

     int changeDp = 0;
     File? _byteData;

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
     if (tutionController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the tution name',
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
    fetchAppConfig();
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
       
        String organizationName = fetchProfile.data!.qualificationDetails.isNotEmpty?
            fetchProfile.data!.qualificationDetails[0].organizationName!:'';
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
      roleId.value =fetchProfile.data!.rolesId!.id!;
      roleTypeId.value =fetchProfile.data!.rolesTypeId!;
      Logger().i( "roleId ${fetchProfile.data!.rolesId!.id!}");
      Logger().i( "roleTypeId ${fetchProfile.data!.rolesTypeId}");
       profileImage = fetchProfile.data!.profileUrl ?? '';
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
      tutionController.text=userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].tutionName ?? ""
        : "";
    //  education info
    highestQualifications.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].highestQualification ?? ""
        : "";
    classController.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].selectClass ?? ""
        : "";
    boardController.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].selectBoard ?? ""
        : "";
         subjectController.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].selectSubject ?? ""
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

        resumePath.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].attachResume ?? ""
        : "";
         educationCertPath.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].attachEducationCertificate ?? ""
        : "";
          experienceCertPath.value = userdata.qualificationDetails.isNotEmpty
        ? userdata.qualificationDetails[0].attachExperienceCertificate ?? ""
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
        "id_proof_label": selectedIDProof.value,
        'rolesId': roleId.value,
        'rolesTypeId': roleTypeId.value,
      };
     // tabController.animateTo(1);
      Logger().i(personalInfo.value);
    }
  }

  void storeAddressInfo(BuildContext context, String selectedRoleTypeName,
      String roleId, String roleTypeId, selectedRole) {
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
           //tabController.animateTo(2);
         // : Container();
         Logger().i("addressInfo ${addressInfo.value}");
    }
  }

  void storeAddressInfoParent(BuildContext context, String selectedRoleTypeName,
      String roleId, String roleTypeId, selectedRole) {
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
         Logger().i(addressInfo.value);
         if (selectedRole == 'Parent') {
        submitSetup(context,roleId, roleTypeId, selectedRole);
      } else if (selectedRole == 'Hosteller') {
        submitSetup(context,roleId, roleTypeId, selectedRole, );
      }  
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
          resumePath: resumePath.value,
          educationCertPath: educationCertPath.value,
          experienceCertPath: experienceCertPath.value,
          latitude: latitude.toString(),
          longitude: longitude.toString(), idproof: pickedFile!.path,
          profileImage:  _byteData!.path);

      // Handle the response
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        final firstName = personalInfo.value['first_name'] ?? '';
      final lastName = personalInfo.value['last_name'] ?? '';
      
      String? wowId =prefs.getString("WowId") ?? "";

 LoginData loginData = LoginData(
            firstName: firstName,
            lastName: lastName,
            wowId: wowId,
          );
         await prefs.setString('userData', jsonEncode(loginData!.toJson()));
         print('Wow ID: ${loginData!.toJson().toString()}');
// Print or use the `wowId`
print('Wow ID: $wowId');
     isNonEdit.value=true;
     update();
 Get.snackbar(
          'Profile updated successfully',
          icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
          shouldIconPulse: false,
          messageText: const SizedBox(
            height: 40, // Set desired height here
            child: Center(
              child: Text(
                'Profile updated successfully',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        );
        // Get.offAll(() => DashboardScreen(
        //       rolename: 'Tutor',
        //         firstname: firstName,
        //       lastname: lastName,
        //       wowid: wowId
        //     ));
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
          "tution_name": tutionController.text,
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
          "select_class": classController.value,
          "organization_name": tuteorganizationController.text,
          "select_board": boardController.value,
          "select_subject": subjectController.value,
        };
         Logger().i(tuteEducationInfo.value);
        submitTuteeAccountSetup(context);
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
     if (boardController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please select board.",
      );
      return false;
    }
    if (classController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please select class.",
      );
      return false;
    }
     if (subjectController.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        "Please select subject.",
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
          longitude: longitude.toString(),
          idproof: pickedFile!.path,
         profileImage:  _byteData!.path
          );
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print(responseBody);
        isNonEdit.value=true;
        update();
        isLoading.value = false;
         Get.snackbar(
          'Profile updated successfully',
          icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
          shouldIconPulse: false,
          messageText: const SizedBox(
            height: 40, // Set desired height here
            child: Center(
              child: Text(
                'Profile updated successfully',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        );
                final firstName = personalInfo.value['first_name'] ?? '';
      final lastName = personalInfo.value['last_name'] ?? '';
      
      String? wowId =prefs.getString("WowId") ?? "";

 LoginData loginData = LoginData(
            firstName: firstName,
            lastName: lastName,
            wowId: wowId,
          );
         await prefs.setString('userData', jsonEncode(loginData!.toJson()));
         print('Wow ID: ${loginData!.toJson().toString()}');
// Print or use the `wowId`
print('Wow ID: $wowId');
        // Get.offAll(() => DashboardScreen(
        //       rolename: 'Tutee',
        //         firstname: firstName,
        //       lastname: lastName,
        //       wowid: wowId
        //     ));
        //Get.offAll(() => TutorHome());
        // Handle success (e.g., show a success message)
       
      } else {
        Logger().e(response.stream.bytesToString());
        print(response.statusCode);
        isLoading.value = false;
        // Handle failure (e.g., show an error message)
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

   Future<void> fetchAppConfig() async {
    try {
      var response = await WebService.fetchAppConfig();
      if (response != null) {
        appConfig.value = response;
        
        // Store the response data in GetStorage
        final storage = GetStorage();
        storage.write('appConfig', response.toJson());
batchName = (storage.read<List<dynamic>>('batchList') ?? [])
    .map((item) => item.toString()) 
    .toList();
        // Create board list by explicitly casting each part of the chain
        board1 = response.data?.studentCategory
            ?.expand((category) => category.label?.labelData ?? [])
            .map((labelData) => labelData.board ?? '')
            .where((board) => board.isNotEmpty)
            .toSet() // Removes duplicates
            .cast<String>() // Ensures all items are strings
            .toList() ?? [];

        Logger().i('AppConfig loaded successfully');
      } else {
        Logger().e('Failed to load AppConfig');
      }
    } catch (e) {
      Logger().e(e);
    }
  }

   void updateClassList(String board) {
    boardController.value = board;
    classList.value = appConfig.value.data?.studentCategory
            ?.expand((category) => category.label?.labelData ?? [])
            .where((labelData) => labelData.board == board)
            .expand((labelData) => labelData.classes ?? [])
            .map((classItem) => classItem.className ?? '')
            .where((className) => className.isNotEmpty)
            .toSet() // Removes duplicates
            .cast<String>() // Ensures all items are strings
            .toList() ?? [];
  }

  void updateSubjectList(String className) {
    classController.value = className;
    subject.value = appConfig.value.data?.studentCategory
            ?.expand((category) => category.label?.labelData ?? [])
            .expand((labelData) => labelData.classes ?? [])
            .where((classItem) => classItem.className == className)
            .expand((classItem) => classItem.subjects ?? [])
            .map((subject) => subject.name ?? '')
            .where((subjectName) => subjectName.isNotEmpty)
            .toSet()
            .cast<String>()
            .toList() ?? [];
  }

     void setBoard(String value) {
  boardController.value = value;
   updateClassList(value);
}

void setClass(String value) {
  classController.value = value;
   updateSubjectList(value);
}

void setSubject(String value) {
  subjectController.value = value;
}

  Future<bool> phoneNumberVerified(String identifiers, BuildContext context) async {
    if (validateLogin(context)) {
      isLoading.value = true;
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var response =
            await WebService.phoneNumberVerified(identifiers, context);
        if (response != null) {
          loginResponse = response.data;
          await prefs.setString("OTP", response.data!.otp ?? '');
          await prefs.setString("AccountVerificationToken",
              response.data!.accountVerificationToken ?? '');
          isPhoneNumberVerified.value = true;
          isLoading.value = false;
          phController.clear();
          updatePhController.clear();
          final result = await Get.to(
            () => OtpScreen(
              phnNumber: identifiers,
            ),
            arguments: isNonEdit.value,
          );
          if (result != null) {
            phController.text = result['phnNumber']; // Update phone number
            accountVerified.value = result['accountVerified'];
          }
          return true;
        } else {
          Logger().e('Failed to load AppConfig');
          isLoading.value = false;
          isPhoneNumberVerified.value = false;
          return false;
        }
      } catch (e) {
        isPhoneNumberVerified.value = false;
        Logger().e(e);
        return false;
      }
    }
    return false;
  }

   bool validateLogin(BuildContext context) {
    String input = updatePhController.text.trim();

    if (input.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
        context,
        'Please enter the phone number',
      );
      return false;
    }

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

    void handleAutoCompleteSelection(Prediction prediction) async {
    isLocationSearched.value = false;
    latitudeL.value = double.parse(prediction.lat!);
    longitudeL.value = double.parse(prediction.lng!);
    mapController.animateCamera(
      CameraUpdate.newLatLng(LatLng(latitudeL.value, longitudeL.value)),
    );

    setMarker(LatLng(latitudeL.value, longitudeL.value));
    isLocationSearched.value = true;
  }

  void setMarker(LatLng position) {
    latitudeL.value = position.latitude;
    longitudeL.value = position.longitude;
    //if(!isLocationSearched.value){
    marker.value = Marker(
      markerId: const MarkerId('selected-location'),
      position: position,
      draggable: true,
      onDragEnd: onMarkerDragEnd,
    );
    updateLocationDetails(position.latitude, position.longitude);
    // }
  }

  void onMarkerDragEnd(LatLng position) {
    latitudeL.value = position.latitude;
    longitudeL.value = position.longitude;
    updateLocationDetails(latitudeL.value, longitudeL.value);
  }

  void updateLocationDetails(double lat, double lng) async {
    latitudeL.value = lat;
    longitudeL.value = lng;
    latitude = lat;
    longitude = lng;

    try {
      List<Placemark>? placemarks =
          await placemarkFromCoordinates(latitude ?? 0.0, longitude ?? 0.0);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark place = placemarks[0];

        address1Controller.text = place.subThoroughfare ?? "";
        address2Controller.text =
            place.thoroughfare ?? "" + "" + place.subLocality! ?? "";
        cityController.text = place.locality ?? "";
        stateController.text = place.administrativeArea ?? "";
        countryController.text = place.country ?? "";
        pincodesController.text = place.postalCode ?? "";
      }
    } catch (e) {
      Logger().e(e);
    }
    print("Updated location: ($lat, $lng)");
  }


void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    if (!isFirstTime.value) return;
    //isLoading.value = true; // Show loader
    try {
      // Position position = await Geolocator.getCurrentPosition(
      //   desiredAccuracy: LocationAccuracy.high,
      // );

      LatLng? position =
          await LocationService.getCurrentLocation() ?? const LatLng(0, 0);
      latitudeL.value = position.latitude;
      longitudeL.value = position.longitude;

      mapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(latitudeL.value, longitudeL.value),
        ),
      );

      setMarker(LatLng(latitudeL.value, longitudeL.value));
      isFirstTime.value = false;
      //  isLocationSearched.value = true;
    } catch (e) {
      Logger().e("Error getting current location: $e");
    } finally {
      isLoading.value = false; // Hide loader
    }
  }

  void uploadFile(File? file){
    pickedFile = file;

              isNonEdit.value = false;
              update()  ;
  }

  Future<void> submitSetup(
     BuildContext context,String roleId, String roleTypeId,
      String selectedRole) async {
    final box = GetStorage(); // Get an instance of GetStorage
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    Get.log("Latitude: ${latitude}, Longitude: ${longitude}");
    latitude = prefs.getDouble('latitude');
    longitude = prefs.getDouble('longitude');
    isLoading.value = true;
    try {
      // Call the API using the WebService
      http.StreamedResponse response = await WebService.submitSetupEdit(
          token: token, // Add the actual token here
          personalInfo: personalInfo.value,
          addressInfo: addressInfo.value,
          latitude: latitude.toString(),
          longitude: longitude.toString(), idproof: pickedFile!.path);

      // Handle the response
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        final firstName = personalInfo.value['first_name'] ?? '';
      final lastName = personalInfo.value['last_name'] ?? '';
      
      String? wowId =prefs.getString("WowId") ?? "";

 LoginData loginData = LoginData(
            firstName: firstName,
            lastName: lastName,
            wowId: wowId,
          );
         await prefs.setString('userData', jsonEncode(loginData!.toJson()));
         print('Wow ID: ${loginData!.toJson().toString()}');
// Print or use the `wowId`
print('Wow ID: $wowId');
     isNonEdit.value=true;
     update();
 Get.snackbar(
          'Profile updated successfully',
          icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
          shouldIconPulse: false,
          messageText: const SizedBox(
            height: 40, // Set desired height here
            child: Center(
              child: Text(
                'Profile updated successfully',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        );
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print('Error occurred: $e');
      // Handle any exception (e.g., network failure)
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getImage(ImageSource source) async {
    XFile? pickedFile = await picker.pickImage(source: source);

   
      if (pickedFile != null) {
        image.value = File(pickedFile.path);
      }
      profileImage = "";
   
    _byteData = image.value!.path.isNotEmpty ? File(image.value! .path) : null;
      image.value = _byteData;
      update()  ;
      profileImage = "";
      CustomCacheManager.instance.emptyCache();
  }

   removeProfilePicture() async {
      image.value = null;
      profileImage = "";
    // ;;await ;
  }
}

class CustomCacheManager {
  static final instance = CacheManager(
    Config(
      'customCacheKey',
      stalePeriod: const Duration(days: 1),
      maxNrOfCacheObjects: 20,
    ),
  );
}
