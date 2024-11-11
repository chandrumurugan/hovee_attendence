// class AuthControllers extends GetxController
//     with GetSingleTickerProviderStateMixin{

//     }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/modals/userProfile_modal.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    authControllers = Get.find<AuthControllers>();
    tabController = TabController(length: 3, vsync: this);
    Logger().i(token.read('Token') ?? "");
    fetchUserProfiles();
    _loadDropdownData();
  }

  void _loadDropdownData() {
    // Load data from GetStorage into lists
    qualifications = GetStorage().read<List<String>>('qualifications') ?? [];
    skills = GetStorage().read<List<String>>('skills') ?? [];
    techs = GetStorage().read<List<String>>('techs') ?? [];
    techsExperience = GetStorage().read<List<String>>('techsExperience') ?? [];
  }

  void fetchUserProfiles() async {
    final storage = GetStorage();
    isLoading(true);
    try {
      UserProfileM? fetchProfile = await WebService.fetchUserProfile();
      if (fetchProfile != null) {
        userProfileResponse.value = fetchProfile;
        _populateFieldsFromResponse(fetchProfile.data!);
        String organizationName = fetchProfile.data!.qualificationDetails.first.organizationName!;
        // Store relevant fields in GetStorage
        storage.write('doorNo', fetchProfile.data!.doorNo);
        storage.write('street', fetchProfile.data!.street);
        storage.write('city', fetchProfile.data!.city);
        storage.write('state', fetchProfile.data!.state);
        storage.write('country', fetchProfile.data!.country);
        storage.write('pincode', fetchProfile.data!.pincode);
        storage.write('id', fetchProfile.data!.id);
        storage.write('firstName', fetchProfile.data!.firstName);
        storage.write('email', fetchProfile.data!.email);
        storage.write('phoneNumber', fetchProfile.data!.phoneNumber);
        storage.write('organizationNames', organizationName);
        storage.write('role', fetchProfile.data!.rolesId!.roleName!);
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
        authControllers.otpResponse.value.data!.pincode!.toString();
    selectedIDProof.value = userdata.idProofLabel ?? "";

    //adddress
    address1Controller.text = userdata.doorNo ?? "";
    address2Controller.text = userdata.street ?? "";
    cityController.text = userdata.city ?? "";
    stateController.text = userdata.state ?? "";
    countryController.text = userdata.country ?? "";
    stateController.text = userdata.state ?? "";

    pincodesController.text = userdata.pincode.toString() ?? "";

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
}
