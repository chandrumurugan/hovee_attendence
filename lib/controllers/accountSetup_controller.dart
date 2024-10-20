import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/home_screen/tutor_home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class AccountSetupController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // final AuthControllers authControllers = Get.put(AuthControllers());

  late AuthControllers authControllers;
  late TabController tabController;
  var currentTabIndex = 0.obs;
  RxBool isLoading = false.obs;

  ///personal info
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

  // Validation messages
  var validationMessages = <String>[].obs;

  var personalInfo = {}.obs;
  var addressInfo = {}.obs;
  var educationInfo = {}.obs;
  final WebService webService = Get.put(WebService());

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
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    authControllers = Get.find<AuthControllers>();
    tabController = TabController(length: 3, vsync: this);
    _populateFieldsFromAuth();
  }

  void _populateFieldsFromAuth() {
    Logger().i(
        "getting idprrof value==>${authControllers.otpResponse.value.data!.idProof!}");
    phController.text = authControllers.otpResponse.value.data!.phoneNumber!;
    firstNameController.text =
        authControllers.otpResponse.value.data!.firstName!;
    lastNameController.text = authControllers.otpResponse.value.data!.lastName!;
    emailController.text = authControllers.otpResponse.value.data!.email!;
    dobController.text = authControllers.otpResponse.value.data!.dob!;
    pincodeController.text =
        authControllers.otpResponse.value.data!.pincode!.toString();
    selectedIDProof.value = authControllers.otpResponse.value.data!.idProof!;
    idProofController.text = authControllers.otpResponse.value.data!.idProof!;
  }

  bool validateAddressInfo(BuildContext context) {
    if (address1Controller.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, "Please enter address1 field");
      return false;
    }
    if (address2Controller.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, "Please enter address2 field");
      return false;
    }
    if (cityController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, "Please enter city field");
      return false;
    }
    if (stateController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, "Please enter state field");
      return false;
    }
    if (countryController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, "Please enter country field");
      return false;
    }
    if (pincodesController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, "Please enter pincode field");
      return false;
    }
    return true;
  }

  bool validatePersonalFields() {
    if (firstNameController.text.isEmpty) {
      Get.snackbar('Validation Error', 'First name cannot be empty');
      return false;
    }
    if (lastNameController.text.isEmpty) {
      Get.snackbar('Validation Error', 'First name cannot be empty');
      return false;
    }
    if (emailController.text.isEmpty) {
      Get.snackbar('Validation Error', 'Email cannot be empty');
      return false;
    }
    if (dobController.text.isEmpty) {
      Get.snackbar('Validation Error', 'DOB cannot be empty');
      return false;
    }

    if (phController.text.isEmpty) {
      Get.snackbar('Validation Error', 'Phone no cannot be empty');
      return false;
    }

    if (pincodeController.text.isEmpty) {
      Get.snackbar('Validation Error', 'Pincode cannot be empty');
      return false;
    }

    if (selectedIDProof.value.isEmpty && idProofController.text.isEmpty) {
      Get.snackbar('Validation Error', 'Please select the Id proof');
      return false;
    }

    // Add more validation as needed
    return true;
  }

  void storePersonalInfo() {
    if (validatePersonalFields()) {
      print("moving to persojnla info");

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
    }
  }

  void storeAddressInfo(BuildContext context) {
    if (validateAddressInfo(context)) {
      addressInfo.value = {
        "door_no": address1Controller.text,
        "street": address2Controller.text,
        "city": cityController.text,
        "state": stateController.text,
        "country": countryController.text,
        "pincode": pincodesController.text,
        "phone_number": phController.text,
      };
      tabController.animateTo(2);
    }
  }

  // Validation method
  bool validateFields(BuildContext context) {
    validationMessages.clear();

    if (highestQualification.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
          context, "Please select a highest qualification.");
      return false;
    }
    if (teachingSkills.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
          context, 'Please select a teaching skill set.');
      return false;
    }
    if (workingTech.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
          context, 'Please select a working technology.');
      return false;
    }
    if (teachingExperience.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
          context, 'Please select teaching experience.');
      return false;
    }
    if (additionalInfo.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
          context, 'Please provide additional info.');
      return false;
    }
    if (resumePath.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Please upload a resume.');
      return false;
    }
    if (educationCertPath.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
          context, 'Please upload an education certificate.');
      return false;
    }
    if (experienceCertPath.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
          context, 'Please upload an experience certificate.');
      return false;
    }
    return true;
  }

  void storeEducationInfo(
      BuildContext context, String roleId, String roleTypeId) {
    if (validateFields(context)) {
      educationInfo.value = {
        "highest_qualification": highestQualification.value,
        "teaching_skill_set": teachingSkills.value,
        "working_tech": workingTech.value,
        "teaching_experience": teachingExperience.value,
        "additional_info": additionalInfo.value,
      };
      submitAccountSetup(roleId, roleTypeId);
    }
  }

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

  Future<void> submitAccountSetup(String roleId, String roleTypeId) async {
    final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    final token = box.read('Token') ?? '';

    isLoading.value = true;
    try {
      // Call the API using the WebService
      http.StreamedResponse response = await webService.submitAccountSetup(
        token: token, // Add the actual token here
        personalInfo: personalInfo.value,
        addressInfo: addressInfo.value,
        educationInfo: educationInfo.value,
        resumePath: resumePath.value,
        educationCertPath: educationCertPath.value,
        experienceCertPath: experienceCertPath.value, roleId: roleId,
        roleTypeId: roleTypeId,
      );

      // Handle the response
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print(responseBody);
        Get.offAll(()=>TutorHome());
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
}
