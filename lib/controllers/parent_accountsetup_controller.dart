import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:hovee_attendence/controllers/parent_controller.dart';
import 'package:hovee_attendence/controllers/parent_dashboard_controller.dart';
import 'package:hovee_attendence/modals/Regsisterparent_model.dart';
import 'package:hovee_attendence/modals/login_data_model.dart';
import 'package:hovee_attendence/modals/regiasterModal.dart';
import 'package:hovee_attendence/modals/update_parent_status_model.dart';
import 'package:hovee_attendence/services/liveLocationService.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/view/home_screen/guest_home_screen.dart';
import 'package:hovee_attendence/view/home_screen/tutor_home_screen.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParentAccountSetupController extends GetxController
    with GetTickerProviderStateMixin {
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

  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final pincodesController = TextEditingController();
  final additionalInfoController = TextEditingController();
  double? latitude, longitude;

  var acceptedTerms = false.obs;
  var isTickedWhatsApp = false.obs;

  late TabController tabController;
  var currentTabIndex = 0.obs;
  RxBool isChecked = false.obs;
  // final ParentDashboardController parentControllerDas = Get.put(ParentDashboardController());

  var registerResponse = RegisterParentModel().obs;
   //final ParentController parentController1 = Get.put(ParentController());
  //  LoginData? loginData;
   String? firstname,lastname,wowId;
   final parentController = Get.find<ParentController>();//ParentDashboardController
    // final parentDController = Get.find<ParentDashboardController>();
   
    LoginData? loginData;
     ParentData? parentdata;

       //address map
  var latitudeL = 0.0.obs;
  var longitudeL = 0.0.obs;
  var marker = Rxn<Marker>();
  late GoogleMapController mapController;
  var focusNode = FocusNode();
  var isMapInteracting = false.obs;
  var mapHeight = 250.0.obs;
  final TextEditingController autoCompleteController = TextEditingController();
  @override 

  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _populateFieldsFromAuth();
     _populateAddressFromLocation();
    // getUserData();
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

    //addresslocation map

    void getCurrentLocation() async {
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
    marker.value = Marker(
      markerId: const MarkerId('selected-location'),
      position: position,
      draggable: true,
      onDragEnd: onMarkerDragEnd,
    );
    updateLocationDetails(position.latitude, position.longitude);
  }

  void zoomIn() {
    mapController.animateCamera(CameraUpdate.zoomIn());
  }

  void zoomOut() {
    mapController.animateCamera(CameraUpdate.zoomOut());
  }

  void handleAutoCompleteSelection(Prediction prediction) async {
    latitudeL.value = double.parse(prediction.lat!);
    longitudeL.value = double.parse(prediction.lng!);
    mapController.animateCamera(
      CameraUpdate.newLatLng(LatLng(latitudeL.value, longitudeL.value)),
    );
    setMarker(LatLng(latitudeL.value, longitudeL.value));
  }
  


  void _populateFieldsFromAuth() {
    phController.text =parentController.otpResponse.value.userDetail!=null?
        parentController.otpResponse.value.userDetail!.parentPhoneNumber ?? '':'';
  }

  bool validateFields(BuildContext context) {
    if (firstNameController.text.isEmpty) {
      SnackBarUtils.showErrorSnackBar(context, 'Please enter the first name.');
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
        'Please enter the phone number.',
      );
      return false;
    }
    // Phone number format validation (10 digits)
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

    // if (pincodeController.text.length <10) {
    //    SnackBarUtils.showSuccessSnackBar(context,'Invalid pincode.',);
    //   return false;
    // }

    // if (!acceptedTerms.value) {
    //   SnackBarUtils.showErrorSnackBar(context,'Please accept the checkbox to proceed',);
    //   return false;
    // }

    // if (selectedIDProof.value.isEmpty && idProofController.text.isEmpty) {
    //    SnackBarUtils.showErrorSnackBar(context,'Please select the Id proof',);
    //   return false;
    // }
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
    // if (pincodesController.text.isEmpty) {
    //   SnackBarUtils.showErrorSnackBar(
    //     context,
    //     "Please enter the pincode",
    //   );
    //   return false;
    // }

    // if (pincodesController.text.length != 6) {
    //    SnackBarUtils.showSuccessSnackBar(context,'Invalid pincode.',);
    //   return false;
    // }
    return true;
  }

  void signIn(BuildContext context) async {
    if (validateAddressInfo(context)) {
      isLoading.value = true;
      try {
        final prefs = await SharedPreferences.getInstance();
        double? latitude = prefs.getDouble('latitude');
        double? longitude = prefs.getDouble('longitude');
        var response = await WebService.RegisterParent(
            context: context,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            email: emailController.text,
            dob: dobController.text,
            phNo: phController.text,
            pincode: pincodeController.text,
            latitude: latitude.toString(),
            longitude: longitude.toString(),
            country: countryController.text,
            state: stateController.text,
            city: cityController.text,
            street: address2Controller.text,
            doorNo: address1Controller.text);

        if (response != null) {
          registerResponse.value = response;
         var validateTokendata = response.data!;
            await prefs.setString('PrentToken',response.data!.token ?? "") ;
            Logger().i("fafgnkanfgaklj${prefs.getString('PrentToken')?? ''}");
            //if(response.parentData=='true'){
          isLoading.value = false;
          Get.dialog(
  AlertDialog(
    title: Text('Tutee Preview'),
    content: Column(
      mainAxisSize: MainAxisSize.min, // To avoid stretching the dialog unnecessarily
      children: [
        _buildRow(
          'Tutee name',
          '${parentController.userDetail!.firstName} ${parentController.userDetail!.lastName}',
        ),
        _buildRow('ID', parentController.userDetail!.wowId!),
        _buildRow('Email', parentController.userDetail!.email!),
        _buildRow(
          'Phone number',
          '${parentController.userDetail!.phoneNumber}',
        ),
        _buildRow('DOB', parentController.userDetail!.dob!),
      ],
    ),
    actions: [
      TextButton(
        onPressed: ()  {
          updateEnrollment(
            Get.context!, // Using Get.context for context
            response.data!.sId!,
            parentController.userID.value,
          );
          Get.back(); // Close the dialog
        },
        child: Text('Accept'),
      ),
      TextButton(
        onPressed: () {
         print(
                                                                      "object");
                                                                  Get.off(() =>
                                                                      const GuestHomeScreen());
        },
        child: Text('Reject'),
      ),
    ],
  ),
  barrierDismissible: false, // Ensures the dialog is not dismissed by tapping outside
);

        } else {
          Logger().e('Failed to load AppConfig');
          isLoading.value = false;
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  void updateEnrollment(
    BuildContext context,
    String parentId,
    String userId,
  ) async {
    isLoading.value = true;
    try {
      var batchData = {"parentId": parentId, "userId": userId};
        SharedPreferences prefs = await SharedPreferences.getInstance();
      final UpdateParentStausModel? response =
          await WebService.updateParentStatus(batchData);

      if (response != null && response.statusCode == 200) {
         parentdata =response.data;
         parentController.getUserTokenList(parentId);
        //  parentDController.fetchHomeDashboardTuteeList();
        
         loginData = LoginData(
            firstName: parentdata!.firstName,
            lastName: parentdata!.lastName,
            wowId: parentdata!.wowId,
            id: parentdata!.sId
          );
      
          prefs.setString('userData', jsonEncode(loginData!.toJson()));
       await getUserData();
        // Get.snackbar(
        //   icon: const Icon(
        //     Icons.check_circle,
        //     color: Colors.white,
        //     size: 40,
        //   ),
        //   response.message!,
        //   colorText: Colors.white,
        //   backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
        // );
                Get.snackbar(
       response.message!,
  icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  messageText:   SizedBox(
    height: 40, // Set desired height here
    child: Center(
      child: Text(
       response.message!,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
);
        Get.off(() => DashboardScreen(rolename: 'Parent',firstname:parentdata!.firstName,lastname: parentdata!.lastName,wowid: parentdata!.wowId,));
      } else {
        // Get.snackbar(
        //   icon: const Icon(
        //     Icons.check_circle,
        //     color: Colors.white,
        //     size: 40,
        //   ),
        //   response!.message!,
        //   colorText: Colors.white,
        //   backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
        // );
                Get.snackbar(
       response!.message!,
  icon: const Icon(Icons.check_circle, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  messageText:   SizedBox(
    height: 40, // Set desired height here
    child: Center(
      child: Text(
       response!.message!,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  ),
);
      }
    } catch (e) {
      //SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getUserData() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
 // To retrieve the data later:
String? jsonString = prefs.getString('userData');
if (jsonString != null) {
  try {
     loginData = LoginData.fromJson(jsonDecode(jsonString));
    print("Hello ${loginData!.firstName}, ${loginData!.lastName}");
    //  getUserTokenList(loginData!.id!);
  } catch (e) {
    print("Error decoding JSON: $e");
  }


  }
}

}
