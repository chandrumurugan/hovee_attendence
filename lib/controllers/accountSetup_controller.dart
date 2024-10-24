import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/home_screen/tutee_home_screen.dart';
import 'package:hovee_attendence/view/home_screen/tutor_home_screen.dart';
import 'package:hovee_attendence/view/loginSignup/loginSingup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

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
  final additionalInfoController = TextEditingController();

  //tutee
    final tuteQualificationController = TextEditingController();
      final tuteclassController = TextEditingController();
        final tuteeboardController = TextEditingController();
          final tuteorganizationController = TextEditingController();


  //education info
  // Dropdown values
  var highestQualification = ''.obs;
  var teachingSkills = ''.obs;
  var workingTech = ''.obs;
  var teachingExperience = ''.obs;
   var teachingSkills1 = ''.obs;
 //education info
  // Dropdown values tutee
  var tuteeHighestQualification = ''.obs;
  var tuteeSpeciallization = ''.obs;

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

  var tuteEducationInfo = {}.obs;
  final WebService webService = Get.put(WebService());

   List<String> qualifications = ['Post graduate','Under graduate'];
   //List<String> skills = ['Primary(1st-5th)','Secondary(6th-10th)','Higher Secondary(11th-12th)'];
   List<String> techs = ['Full Time','Part Time'];
   List<String> techsExperience = ['1-3 years','3-5 years','5-10 years','10+ years'];
   List<String> tuteeQualifications = ['School','College','Others'];
   List<String> tuteeSpeciallizationClass = ['Pre-school','Primary','Seconday','Higher secondary','Engineering','Arts','Medical'];
   List<String> skills = ['Pre-school ','Primary ','Seconday','College ','University'];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    authControllers = Get.find<AuthControllers>();
    tabController = TabController(length: 3, vsync: this);
    _populateFieldsFromAuth();
     //_loadDropdownData();
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
  
  void _loadDropdownData() {
  // Load data from GetStorage into lists
 qualifications = GetStorage().read<List<String>>('qualifications') ?? [];
 skills = GetStorage().read<List<String>>('skills') ?? [];
 techs = GetStorage().read<List<String>>('techs') ?? [];
 techsExperience = GetStorage().read<List<String>>('techsExperience') ?? [];

  }

  bool validateAddressInfo(BuildContext context) {
    if (address1Controller.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, "Please enter the door no");
      return false;
    }
    if (address2Controller.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, "Please enter the street & area");
      return false;
    }
    if (cityController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, "Please enter the city");
      return false;
    }
    if (stateController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, "Please enter the state");
      return false;
    }
    if (countryController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, "Please enter the country");
      return false;
    }
    if (pincodesController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, "Please enter the pincode");
      return false;
    }

    if (pincodesController.text.length != 6) {
    SnackBarUtils.showErrorSnackBar(context,'Invalid pincode.');
    return false;
  }
    return true;
  }

  bool validatePersonalFields(BuildContext context) {
    if (firstNameController.text.isEmpty) {
     SnackBarUtils.showErrorSnackBar(context,'Please enter the first name.');
      return false;
    }
    if (lastNameController.text.isEmpty) {
        SnackBarUtils.showErrorSnackBar(context,'Please enter the last name.');
      return false;
    }
    if (emailController.text.isEmpty) {
       SnackBarUtils.showErrorSnackBar(context,'Please enter the email.');
      return false;
    }
    // Email format validation
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
      SnackBarUtils.showErrorSnackBar(context,'Invalid email format');
      return false;
    }
    if (dobController.text.isEmpty) {
       SnackBarUtils.showErrorSnackBar(context,'Please select the DOB.');
      return false;
    }

    if (phController.text.isEmpty) {
       SnackBarUtils.showErrorSnackBar(context,'Please enter the mobile number.');
      return false;
    }
     if (!RegExp(r'^[0-9]{10}$').hasMatch(phController.text)) {
       SnackBarUtils.showErrorSnackBar(context,'Invalid mobile number');
      return false;
    }

    if (pincodeController.text.isEmpty) {
       SnackBarUtils.showErrorSnackBar(context,'Please enter the pincode.');
      return false;
    }

     if (pincodeController.text.length != 6) {
    SnackBarUtils.showErrorSnackBar(context,'Invalid pincode.');
    return false;
  }

    if (selectedIDProof.value.isEmpty && idProofController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context,'Please select the Id proof');
      return false;
    }

    // Add more validation as needed
    return true;
  }

  void storePersonalInfo( BuildContext context, String roleId, String roleTypeId) {
    if (validatePersonalFields(context)) {
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
        'rolesId':roleId,
        'rolesTypeId':roleTypeId,
      };
      tabController.animateTo(1);
      Logger().i(personalInfo.value);
      
    }
  }

  void storeAddressInfo(BuildContext context,String selectedRoleTypeName,String roleId, String roleTypeId) {
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
       selectedRoleTypeName=='I Run an Institute'?
      submitAccountSetup(roleId, roleTypeId,context):Container();
     selectedRoleTypeName!='I Run an Institute'? tabController.animateTo(2):Container();
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
          context, 'Please select a work type.');
      return false;
    }
    if (teachingExperience.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
          context, 'Please select your teaching experience.');
      return false;
    }
    if (resumePath.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Please attach  a resume.');
      return false;
    }
    if (experienceCertPath.value.isEmpty) {
      SnackBarUtils.showErrorSnackBar(
          context, 'Please attach a experience certificate.');
      return false;
    }
    return true;
  }
  bool validateTuteEducationInfo(BuildContext context){
    if(tuteeHighestQualification.value.isEmpty){
       SnackBarUtils.showErrorSnackBar(
          context, "Please select highest qualification.");
          return false;

    }
    if(tuteeSpeciallization.value.isEmpty){
       SnackBarUtils.showErrorSnackBar(
          context, "Please select class/specialization.");
          return false;

    }
    // if(tuteeboardController.text.isEmpty){
    //     SnackBarUtils.showErrorSnackBar(
    //       context, "Please enter board.");
    //       return false;

    // }
    if(tuteorganizationController.text.isEmpty){
        SnackBarUtils.showErrorSnackBar(
          context, "Please enter the school/college/other.");
          return false;
    }
    return true;
  }

  void storeEducationInfo(
      BuildContext context, String roleId, String roleTypeId) {
        if (!validateAllTabs(context)) {
          
        }else{
      if (validateFields(context)) {
      educationInfo.value = {
        "highest_qualification": highestQualification.value,
        "teaching_skill_set": teachingSkills.value,
        "working_tech": workingTech.value,
        "teaching_experience": teachingExperience.value,
        "additional_info": additionalInfoController.text,
      };
      submitAccountSetup(roleId, roleTypeId,context);
    }
        }
  }

  void storeTuteeeducationInfo(BuildContext context, String roleId, String roleTypeId){
     if (!validateAllTabs1(context)) {
          
        }else{
    if(validateTuteEducationInfo(context)){
      tuteEducationInfo.value = { "highest_qualification": tuteeHighestQualification.value, 
    "select_class": tuteeSpeciallization.value,
    // "select_board": tuteeboardController.text, 
    "organization_name": tuteorganizationController.text
};
submitTuteeAccountSetup(roleId,context);
    }
        }
  }

  Future<void> submitTuteeAccountSetup(String roleId,BuildContext context)async{
     final box = GetStorage(); // Get an instance of GetStorage
    // Retrieve the token from storage
    final token = box.read('Token') ?? '';
    Logger().i(personalInfo.value);

    isLoading.value = true;
    try {
      http.StreamedResponse response =  await webService.submitTuteeAccountSetup(
        token: token, // Add the actual token here
        personalInfo: personalInfo.value,
        addressInfo: addressInfo.value,
        educationInfo: tuteEducationInfo.value,
        // resumePath: '',
        // educationCertPath: '',
        // experienceCertPath: '',
        // roleId:roleId ,
        // roleTypeId: roleTypeId
      );
            if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print(responseBody);
         SnackBarUtils.showSuccessSnackBar(context, "Account setup successfully completed.");
        Get.offAll(()=>const TuteeHome());
        // Handle success (e.g., show a success message)
      } else {
        print(response.statusCode);
        // Handle failure (e.g., show an error message)
      }
       
    } catch (e) {
      print(e); 
    }
    finally {
      isLoading.value = false;
    }

  }



  void setHighestQualification(String value) =>
      highestQualification.value = value;
  void setTeachingSkills(String value) => teachingSkills.value = value;
  void setWorkingTech(String value) => workingTech.value = value;
  void setTeachingExperience(String value) => teachingExperience.value = value;
  void setAdditionalInfo(String value) => additionalInfo.value = value;
  void setTuteeHighestQualification(String value) =>
      tuteeHighestQualification.value = value;
 void setTuteeSpeciallization(String value) =>
      tuteeSpeciallization.value = value;
      

  Future<void> pickFile(String type) async {
  final ImagePicker picker = ImagePicker();
  final XFile? file = await picker.pickImage(source: ImageSource.gallery);
  if (file != null) {
    Logger().i(file.path);

    // Extracting filename and extension
    String filename = path.basename(file.path); // e.g., "1000000018.jpg"
    String fileExtension = path.extension(file.path); // e.g., ".jpg"
    
    Logger().i("Filename: $filename");
    Logger().i("File Extension: $fileExtension");

    if (type == 'resume') {
      resumePath.value = file.path;
    } else if (type == 'education') {
      educationCertPath.value = file.path;
    } else if (type == 'experience') {
      experienceCertPath.value = file.path;
    }
  }
}


  Future<void> submitAccountSetup(String roleId, String roleTypeId,BuildContext context) async {
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
        resumePath: '',
        educationCertPath: '',
        experienceCertPath: '',
        // roleId:roleId ,
        // roleTypeId: roleTypeId
      );

      // Handle the response
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print(responseBody);
        SnackBarUtils.showSuccessSnackBar(context, "Account setup successfully completed.");
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

}
