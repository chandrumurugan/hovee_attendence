import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovee_attendence/constants/common_function.dart';
import 'package:hovee_attendence/modals/getAttendancePunchIn_model.dart';
import 'package:hovee_attendence/services/liveLocationService.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/Hosteller/hostel_attendance_screen.dart';
import 'package:hovee_attendence/view/punch_view.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class HostelPunchinController extends GetxController {
  GoogleMapController? _mapController;
  var currentLocation = Rxn<LatLng>();
  var currentAddress = Rxn<String>();
  var markers = <Marker>{}.obs;
  GoogleMapController? get mapController => _mapController;
  final punchedIn = false.obs;
  double punchable_distance_in_meters = 500;
  final LocationService locationService = LocationService();

  var isLoading = true.obs;
  var buttonLoader = false.obs;
  void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  var targetLocation = Rxn<LatLng>();
  double? targetLat;
  double? targetLong;

  final icon = BitmapDescriptor.asset(
    const ImageConfiguration(devicePixelRatio: 1.0),
    "assets/appbar/placeholder (1).png",
  );

  final icon1 = BitmapDescriptor.asset(
    const ImageConfiguration(devicePixelRatio: 1.0),
    "assets/appbarlocation-mark (1).png",
  );

  var hasScanned = false.obs;
  String? name;
  var draggablePosition = Rx<Offset>(Offset(50, 50));

  @override
  void onInit() {
    super.onInit();
    targetLocation.value = LatLng(targetLat ?? 0.0, targetLong ?? 0.0);
    setInatlizeLocation();
    getCurrentLocation();
    loadPunchState();
  }

  Future<void> setInatlizeLocation() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("target_lat", 0.0);
    await prefs.setDouble("target_long", 0.0);
  }

  Future<void> getCurrentLocation() async {
    try {
      print("object");
      final prefs = await SharedPreferences.getInstance();
      final storage = GetStorage();
      currentLocation.value = await LocationService.getCurrentLocation();

      // Get.log("Latitude: $latitude, Longitude: $longitude");
      Logger().i('-=: ${currentLocation.value}');

      targetLat = prefs.getDouble('target_lat') ?? 0.0;
      targetLong = prefs.getDouble('target_long') ?? 0.0;

      targetLocation.value = LatLng(targetLat!, targetLong!);

      Get.log("currentLocation.value ${currentLocation.value}");
      Get.log("targetLocation.value ${targetLocation.value}");

      name = storage.read('firstName');
      markers.add(Marker(
        markerId: const MarkerId("currentLocation"),
        position: currentLocation.value!,
        // icon: await  icon,
        //fromAssetImage( const ImageConfiguration(devicePixelRatio: 1.0,), "assets/appbar/placeholder (1).png",),
        icon: await const MarkerWidget(
          imagePath: 'assets/appbar/Tutee_location_marker_v3.svg',
        ).toBitmapDescriptor(
          logicalSize: const Size(150, 150),
          imageSize: const Size(400, 400),
        ),
        infoWindow: const InfoWindow(title: "Current Location"),
      ));
      markers.add(Marker(
        markerId: const MarkerId("targetLocation"),
        position: targetLocation.value!,
        // icon:await BitmapDescriptor.fromAssetImage( const ImageConfiguration(devicePixelRatio: 1.0,size: Size.square(10.0)), "assets/appbar/location-mark (1).png"),
        icon: await const MarkerWidget(
                rotationAngle: 60 * (3.14159 / 120),
                imagePath: 'assets/appbar/Tutor_location_marker_v2.svg')
            .toBitmapDescriptor(
          logicalSize: const Size(150, 150),
          imageSize: const Size(400, 400),
        ),
        infoWindow: const InfoWindow(title: "Target Location"),
      ));
      // _mapController
      //     ?.animateCamera(CameraUpdate.newLatLng(currentLocation.value!));

      await _fetchAddress();
    } catch (e) {
      print('Error fetching location: $e');
      Logger().i('Error fetching location: $e');
      // Handle error fetching location
    }
  }

  Future<void> _fetchAddress() async {
    try {
      if (currentLocation.value != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
            currentLocation.value!.latitude, currentLocation.value!.longitude);
        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          currentAddress.value =
              "${placemark.street},${placemark.thoroughfare},${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
          // You can access other address details like postal code, sub locality, etc. from placemark
        }
      }
    } catch (e) {
      print('Error fetching address: $e');
      // Handle error fetching address
    }
  }

  Future<void> checkDistanceFromSpecificLocation(
      BuildContext context,
      String hostelId,
      String hostelObjId,
      String batchTimingStart,
      String batchTimingEnd,
      String hostelName) async {
    buttonLoader(true);

    print("getingbv  vakluyeuwkgqie====>");
    // Calculate distance between current location and specific location
    double distanceInMeters = await Geolocator.distanceBetween(
      currentLocation.value!.latitude,
      currentLocation.value!.longitude,
      targetLat!,
      targetLong!,
    );

    // Define threshold distance
    double thresholdInMeters = punchable_distance_in_meters;

    // Get current time
    DateTime now = DateTime.now();
    DateTime batchStartTime = _parseBatchTime(batchTimingStart);
    DateTime batchEndTime = _parseBatchTime(batchTimingEnd);
    print('hi rahul $batchStartTime');
    print('hi ragul$batchEndTime');

    // Check if distance is within the threshold
    if (distanceInMeters <= thresholdInMeters) {
      Logger().i("User is within 500 meters of the specific location.");

      // Check if the current time is within the punchable window
      //  if (isWithinPunchInWindow) {
      if (!punchedIn.value) {
        Logger().i("punch can done");
        // Within punchable range, call the API to punch in

        final getAttendancePunchInModel? response =
            await WebService.getHostelAttendancePunchIn(
                hostelId, hostelObjId, context);
        Logger().i(response);

        if (response != null && response.success == true) {
          // API call was successful, update state and show success message
          punchedIn.value = true;
          await savePunchState(punchedIn.value);
          buttonLoader(false);
          hasScanned.value = false;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setDouble('target_lat', 0.0);
          await prefs.setDouble('target_long', 0.0);
           targetLat =  0.0;
      targetLong =  0.0;
          getCurrentLocation();
          showAnimatedDialog('Punched out successfully!',
              "assets/images/success_punching.png", context);
          //SnackBarUtils.showSuccessSnackBar(context, 'Attendance successfully marked');
        } else {
          // Show error if the API call failed
          punchedIn.value = false;
          buttonLoader(false);
          SnackBarUtils.showSuccessSnackBar(
            context,
            response!.message ?? '',
          );
        }
      } else {
        final getAttendancePunchInModel? response =
            await WebService.getHostelAttendancePunchOut(
                context, hostelId, hostelObjId);

        if (response != null && response.success == true) {
          // API call was successful, update state and show success message
          hasScanned.value = false;
          punchedIn.value = false;
          await savePunchState(punchedIn.value);
          buttonLoader(false);
          final prefs = await SharedPreferences.getInstance();
          await prefs.setDouble('target_lat', 0.0);
          await prefs.setDouble('target_long', 0.0);
           getCurrentLocation();
          showAnimatedDialog('Punched in successfully!',
              "assets/images/success_punching.png", context);

          // After the dialog is dismissed, navigate to the next page
          Future.delayed(const Duration(milliseconds: 1500), () {
            Get.to(
                () => HostelAttendanceScreen(
                    type: 'Hosteller'.obs, batchname: hostelName),
                arguments: hostelId);
          });
        } else {
          // Show error if the API call failed
          buttonLoader(false);
          SnackBarUtils.showSuccessSnackBar(
            context,
            response!.message!,
          );
        }
      }
    } else {
      print("User is outside 500 meters of the specific location.");
      buttonLoader(false);
      Logger().e("User is within 500 meters of the specific location.");
      showAnimatedDialog('You are away from the hostel',
          "assets/images/error_punching.png", context);
    }
  }

  DateTime _parseBatchTime(String batchTime) {
    // Ensure the input is in the correct format
    batchTime = batchTime.trim(); // Trim any whitespace
    batchTime = batchTime.replaceAll(
        RegExp(r'\s+'), ' '); // Replace multiple spaces with a single space

    // Get the current date
    DateTime now = DateTime.now();
    // Create a DateFormat for parsing time
    DateFormat dateFormat =
        DateFormat("h:mm a"); // Ensure the format is correct
    // Parse the time while combining it with the current date
    DateTime parsedTime = dateFormat.parse(batchTime.toUpperCase());
    // Return the DateTime object with the current date and parsed time
    return DateTime(
        now.year, now.month, now.day, parsedTime.hour, parsedTime.minute);
  }

  void updateDraggablePosition(Offset delta) {
    draggablePosition.value += delta;
  }

  Future<void> loadPunchState() async {
    final prefs = await SharedPreferences.getInstance();
    final storedState = prefs.getBool('punchedIn') ?? false; // Default to false
    punchedIn.value = storedState;
  }

  Future<void> savePunchState(bool state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('punchedIn', state);
  }
}
