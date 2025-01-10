import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:hovee_attendence/controllers/auth_controllers.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/modals/appConfigModal.dart';
import 'package:hovee_attendence/modals/loginModal.dart';
import 'package:hovee_attendence/modals/login_data_model.dart';
import 'package:hovee_attendence/modals/phonenumberVerfication_model.dart';
import 'package:hovee_attendence/services/liveLocationService.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/view/home_screen/tutee_home_screen.dart';
import 'package:hovee_attendence/view/home_screen/tutor_home_screen.dart';
import 'package:hovee_attendence/view/loginSignup/otp_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';

class AccountSetupController extends GetxController
    with GetTickerProviderStateMixin {
   final  authControllers = Get.find<AuthControllers>();

  //late AuthControllers authControllers;
  late TabController tabController;
  var currentTabIndex = 0.obs;
  RxBool isLoading = false.obs;

  //address map
  var latitudeL = 0.0.obs;
  var longitudeL = 0.0.obs;
  var marker = Rxn<Marker>();
  late GoogleMapController mapController;
  var focusNode = FocusNode();
  var isMapInteracting = false.obs;
  var mapHeight = 250.0.obs;
  final TextEditingController autoCompleteController = TextEditingController();

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
  final tutionController = TextEditingController();

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
   var boardController = ''.obs;
    var classController = ''.obs;
      var subjectController = ''.obs;
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

  List<String> qualifications = [];
  //List<String> skills = ['Primary(1st-5th)','Secondary(6th-10th)','Higher Secondary(11th-12th)'];
  List<String> techs = [];
  List<String> techsExperience = [];
  List<String> tuteeQualifications = [];
  List<String> tuteeSpeciallizationClass = [];
  List<String> skills = [];
  final box = GetStorage();
  double? latitude, longitude;
  String? selectedRole;
  String? parentId;
  final parentController = Get.find<ParentController>();
  LoginData? loginData;
  List<String> board = [];
   RxList<String> classList = <String>[].obs;
   RxList<String> subject = <String>[].obs;
   var appConfig = AppConfig().obs;
    List<String> batchName = [];

    var isFirstTime = true.obs;
    var isLocationSearched = false.obs;

  bool? isGoogleSignIn;
  RxBool accountVerified = false.obs;

  AccountSetupController({this.isGoogleSignIn});
   PhnData? loginResponse;

    var isPhoneNumberVerified = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final args = Get.arguments;

  if (args != null && args is Map) {
    parentId = args['parentId'] ?? '';
    isGoogleSignIn = args['isGoogleSignIn'] ?? false;

    print("Parent ID: $parentId");
    print("isGoogleSignIn: $isGoogleSignIn");
  } else {
    print("No arguments passed or arguments format is invalid.");
  }
   final authControllers = Get.put(AuthControllers());
    tabController =
        TabController(length: selectedRole == 'Parent' ? 2 : 3, vsync: this);
    print(parentId);
    if ((parentId == null)) {
      _populateFieldsFromAuth();
    }
    if(isGoogleSignIn==false){
       _populateFieldsFromAuth();
    }
    if ((parentId != "")) {
      phController.text = parentController.otpResponse.value != null
          ? parentController.otpResponse.value.inviteNumber ?? ''
          : '';
    } else {
      print("object");
    }

 fetchAppConfig();
    // _populateAddressFromLocation();
   // getCurrentLocation();
    //loadAppConfigData();
    qualifications = getQualifications();
    techs = getTechs();
    techsExperience = getTechsExperiencechs();
    tuteeQualifications = getTuteeQualifications();
    skills = getSkills();
    tuteeSpeciallizationClass = getSkills();
       //getCurrentLocation();
  }

  //addresslocation map

    void getCurrentLocation() async {
        if (!isFirstTime.value) return;
    isLoading.value = true; // Show loader
    try {
      // Position position = await Geolocator.getCurrentPosition(
      //   desiredAccuracy: LocationAccuracy.high,
      // );

      LatLng? position =await LocationService.getCurrentLocation() ?? const LatLng(0, 0);
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

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    getCurrentLocation();
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

  void zoomIn() {
    mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void zoomOut() {
    mapController.animateCamera(CameraUpdate.zoomOut());
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
  //

  void tap() {
    if (selectedRole == 'Parent') {
      tabController =
          TabController(length: selectedRole == 'Parent' ? 2 : 3, vsync: this);
    }
    tabController = TabController(length: 3, vsync: this);
  }

  void _populateAddressFromLocation() async {
    final prefs = await SharedPreferences.getInstance();
    Get.log("Latitude: $latitude, Longitude: $longitude");
    latitude = prefs.getDouble('latitude');
    longitude = prefs.getDouble('longitude');
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
  }

  void _populateFieldsFromAuth() {
    // Logger().i(
    //     "getting idprrof value==>${authControllers.otpResponse.value.data!.idProof ?? ''}");
    if(authControllers.otpResponse.value.data != null){
       phController.text =
        authControllers.otpResponse.value.data!.phoneNumber ?? '';
    firstNameController.text =
        authControllers.otpResponse.value.data!.firstName ?? '';
    lastNameController.text =
        authControllers.otpResponse.value.data!.lastName ?? '';
    emailController.text = authControllers.otpResponse.value.data!.email ?? '';
    dobController.text = authControllers.otpResponse.value.data!.dob!;
    pincodeController.text =
        authControllers.otpResponse.value.data!.pincode!.toString();
    selectedIDProof.value =
        authControllers.otpResponse.value.data!.idProof ?? '';
    idProofController.text =
        authControllers.otpResponse.value.data!.idProof ?? '';  
    }
 
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

  //  void loadAppConfigData() {
  //   // Retrieve the data from GetStorage
  //   var storedConfig = box.read('appConfigData');
  //   if (storedConfig != null) {
  //     // You can access the data and map it to the lists as needed
  //     // Example of parsing the stored config
  //     qualifications = List<String>.from(storedConfig['qualifications'] ?? []);
  //     techs = List<String>.from(storedConfig['techs'] ?? []);
  //     techsExperience = List<String>.from(storedConfig['techsExperience'] ?? []);
  //     tuteeQualifications =
  //         List<String>.from(storedConfig['tuteeQualifications'] ?? []);
  //     tuteeSpeciallizationClass =
  //         List<String>.from(storedConfig['tuteeSpeciallizationClass'] ?? []);
  //     skills = List<String>.from(storedConfig['skills'] ?? []);
  //   }
  // }

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

  Future<void> storePersonalInfo(
      BuildContext context, String roleId, String roleTypeId) async {
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
        'rolesId': roleId,
        'rolesTypeId': roleTypeId,
      };
      tabController.animateTo(1);
      Logger().i(personalInfo.value);
    }
  }

  // void storeAddressInfo(BuildContext context, String selectedRoleTypeName,
  //     String roleId, String roleTypeId,selectedRole) {
  //   if (validateAddressInfo(context)) {
  //     String address = "${address1Controller.text}, "
  //         "${address2Controller.text}, "
  //         "${cityController.text}, "
  //         "${stateController.text}, "
  //         "${countryController.text} - "
  //         "${pincodesController.text}";
  //     addressInfo.value = {
  //       "door_no": address1Controller.text,
  //       "street": address2Controller.text,
  //       "city": cityController.text,
  //       "state": stateController.text,
  //       "country": countryController.text,
  //       "pincode": pincodesController.text,
  //       "phone_number": phController.text,
  //       "address": address,
  //     };
  //    // Check for 'I Run an Institute' condition
  //   if (selectedRoleTypeName == 'I Run an Institute') {
  //     submitAccountSetup(roleId, roleTypeId,selectedRole,context);
  //   }

  //   // Check for 'Parent' condition and call submitAccountSetup
  //   if (selectedRole == 'Parent') {
  //     submitAccountSetup(roleId, roleTypeId,selectedRole, context,);
  //   }

  //   // If the role is not 'I Run an Institute', navigate to tab 2
  //   if (selectedRoleTypeName != 'I Run an Institute') {
  //     tabController.animateTo(2);
  //   }
  //   }
  // }

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
      if (selectedRole == 'Parent') {
        submitAccountSetup(roleId, roleTypeId, selectedRole, context);
      }else if(selectedRoleTypeName== 'Institute' && selectedRole == 'Tutor'){
        submitAccountSetup(roleId, roleTypeId, selectedRole, context);
      }
       else {
        selectedRoleTypeName == 'I Run an Institute'
            ? submitAccountSetup(roleId, roleTypeId, selectedRole, context)
            : Container();
        selectedRoleTypeName != 'I Run an Institute'
            ? tabController.animateTo(2)
            : Container();
      }
    }
  }

  // Validation method
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
        "Please enter the tution name.",
      );
      return false;
    }
    return true;
  }

  bool validateTuteEducationInfo(BuildContext context) {
    if (tuteeHighestQualification.value.isEmpty) {
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

  void storeEducationInfo(
      BuildContext context, String roleId, String roleTypeId, selectedRole) {
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
        submitAccountSetup(
          roleId,
          roleTypeId,
          selectedRole,
          context,
        );
      }
    }
  }

  void storeTuteeeducationInfo(
      BuildContext context, String roleId, String roleTypeId) {
    if (!validateAllTabs1(context)) {
    } else {
      if (validateTuteEducationInfo(context)) {
        tuteEducationInfo.value = {
          "highest_qualification": tuteeHighestQualification.value,
          "select_class": classController.value,
          "select_board": boardController.value,
           "select_subject": subjectController.value,
          "organization_name": tuteorganizationController.text
        };
        submitTuteeAccountSetup(roleId, parentId, context);
      }
    }
  }

  Future<void> submitTuteeAccountSetup(
      String roleId, parentId, BuildContext context) async {
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
      http.StreamedResponse response = await WebService.submitTuteeAccountSetup(
        token: token, // Add the actual token here
        personalInfo: personalInfo.value,
        addressInfo: addressInfo.value,
        educationInfo: tuteEducationInfo.value,
        latitude: latitude.toString(),
        longitude: longitude.toString(),
        parentId: parentId,
      );
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print(responseBody);
        final jsonResponse = jsonDecode(responseBody);
        final parentToken = jsonResponse['tuteeToken'];

        // Store the parentToken in SharedPreferences
        parentId != "" ? await prefs.setString('Token', parentToken ?? '') : '';
        //  prefs.setString('Token', responseBody. ?? "");
        SnackBarUtils.showSuccessSnackBar(
            context, "Account setup successfully completed.");
        // Extract firstName and lastName from personalInfo
        final firstName = personalInfo.value['first_name'] ?? '';
        final lastName = personalInfo.value['last_name'] ?? '';

        String? wowId = prefs.getString("WowId") ?? "";

        loginData = LoginData(
          firstName: firstName,
          lastName: lastName,
          wowId: wowId,
        );
        await prefs.setString('userData', jsonEncode(loginData!.toJson()));
        print('Wow ID: ${loginData!.toJson().toString()}');
// Print or use the `wowId`
        print('Wow ID: $wowId');
        Get.offAll(() => DashboardScreen(
            rolename: 'Tutee',
            firstname: firstName,
            lastname: lastName,
            wowid: wowId));
        //Get.offAll(() => TutorHome());
        // Handle success (e.g., show a success message)
      } else {
        print(response.statusCode);
        // Handle failure (e.g., show an error message)
      }
    } catch (e) {
      Logger().e(e);
      print(e);
    } finally {
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

  Future<void> submitAccountSetup(String roleId, String roleTypeId,
      String selectedRole, BuildContext context) async {
    final box = GetStorage(); // Get an instance of GetStorage
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('Token') ?? "";
    print(token);

    // Retrieve latitude and longitude
    latitude = prefs.getDouble('latitude');
    longitude = prefs.getDouble('longitude');
    Get.log("Latitude: $latitude, Longitude: $longitude");

    isLoading.value = true;

    try {
      // Call the API using the WebService
      http.StreamedResponse response = await WebService.submitAccountSetup(
        token: token, // Add the actual token here
        personalInfo: personalInfo.value,
        addressInfo: addressInfo.value,
        educationInfo: educationInfo.value,
        resumePath: '',
        educationCertPath: '',
        experienceCertPath: '',
        latitude: latitude.toString(),
        longitude: longitude.toString(), parentId: '',
      );

      // Handle the response
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print(responseBody);
        // String responseBody = await response.stream.bytesToString();
        print(responseBody);
        final jsonResponse = jsonDecode(responseBody);
        var parentToken = jsonResponse["userDetails"]['token'];

        // Extract firstName and lastName from personalInfo
        final firstName = personalInfo.value['first_name'] ?? '';
        final lastName = personalInfo.value['last_name'] ?? '';

        String? wowId;

        String? userData = prefs.getString('userData');
        if (userData != null) {
          // Decode the JSON string into a map
          Map<String, dynamic> userDataMap = jsonDecode(userData);

          // Access the `wowId`
          wowId = userDataMap['wowId'];
        }

// Print or use the `wowId`
        // print('Wow ID: $wowId');

        // Navigate based on selectedRole
        if (selectedRole == 'Parent') {
          prefs.setString("PrentToken", parentToken);

          Get.off(() => DashboardScreen(
              rolename: 'Parent',
              firstname: firstName,
              lastname: lastName,
              wowid: wowId));
        } else {
          prefs.setString("PrentToken", "");
          Get.offAll(() => DashboardScreen(
              rolename: 'Tutor',
              firstname: firstName,
              lastname: lastName,
              wowid: wowId));
        }
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
        board = response.data?.studentCategory
            ?.expand((category) => category.label?.labelData ?? [])
            .map((labelData) => labelData.board ?? '')
            .where((board) => board.isNotEmpty)
            .toSet() // Removes duplicates
            .cast<String>() // Ensures all items are strings
            .toList() ?? [];
        SharedPreferences prefs = await SharedPreferences.getInstance();
           

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

  void phoneNumberVerified(String identifiers, BuildContext context) async {
    if (validateLogin(context)) {
      isLoading.value = true;
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var response = await WebService.phoneNumberVerified(identifiers, context);
        if (response != null) {
          loginResponse = response.data;
        await prefs.setString("OTP", response.data!.otp!);
        await prefs.setString("AccountVerificationToken", response.data!.accountVerificationToken!);
          isPhoneNumberVerified.value = true;
          isLoading.value = false;
          phController.clear();
       final result=  await Get.to(() => OtpScreen(phnNumber: identifiers,),arguments: isGoogleSignIn,);
        if (result != null) {
    phController.text = result['phnNumber']; // Update phone number
  accountVerified.value = result['accountVerified'];
  }
        } else {
          Logger().e('Failed to load AppConfig');
          isLoading.value = false;
          isPhoneNumberVerified.value = false;
        }
      } catch (e) {
        isPhoneNumberVerified.value = false;
        Logger().e(e);
      }
    }
  }

  bool validateLogin(BuildContext context) {
    String input = phController.text.trim();

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
}
