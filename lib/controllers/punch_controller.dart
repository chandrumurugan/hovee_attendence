// ignore_for_file: deprecated_member_use

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hovee_attendence/constants/common_function.dart';
import 'package:hovee_attendence/modals/getAttendancePunchIn_model.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/utils/snackbar_utils.dart';
import 'package:hovee_attendence/view/Tutee/tuteeAttendanceList.dart';
import 'package:hovee_attendence/view/punch_view.dart';
import 'package:hovee_attendence/widget/widget_to_icon.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class PunchController extends GetxController {
  GoogleMapController? _mapController;
  var currentLocation = Rxn<LatLng>();
  var currentAddress = Rxn<String>();
  var markers = <Marker>{}.obs;
  GoogleMapController? get mapController => _mapController;
  final punchedIn = false.obs;
  double punchable_distance_in_meters = 500;

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

  @override
  void onInit() {
    super.onInit();
     targetLocation.value = LatLng(targetLat ?? 0.0, targetLong ?? 0.0);
      setInatlizeLocation();
    getCurrentLocation();
    // targetLocation.value!.latitude!=0.0;
    // targetLocation.value!.longitude!=0.0;
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

// Retrieve latitude and longitude, providing default values if null
      double latitude = prefs.getDouble('latitude') ?? 0.0;
      double longitude = prefs.getDouble('longitude') ?? 0.0;

// Update the current location with non-nullable values
      currentLocation.value = LatLng(latitude, longitude);

      Get.log("Latitude: $latitude, Longitude: $longitude");

      targetLat = prefs.getDouble('target_lat') ?? 0.0;
      targetLong = prefs.getDouble('target_long') ?? 0.0;

      targetLocation.value = LatLng(targetLat!, targetLong!);

      Get.log("currentLocation.value ${currentLocation.value}");
      Get.log("targetLocation.value ${targetLocation.value}");
      markers.add(Marker(
        markerId: const MarkerId("currentLocation"),
        position: currentLocation.value!,
        // icon: await  icon,
        //fromAssetImage( const ImageConfiguration(devicePixelRatio: 1.0,), "assets/appbar/placeholder (1).png",),
        icon: await const MarkerWidget(
          imagePath: 'assets/appbar/Tutee Location Icon (1) (1).svg',
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
                imagePath: 'assets/appbar/Tutor Location Icon (2).svg')
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

  // Future<void> _getCurrentLocation() async {
  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     currentLocation.value = LatLng(position.latitude, position.longitude);

  //     // Add custom marker for the current location
  //     BitmapDescriptor currentLocationIcon = await _getCustomMarker(
  //       Icons.person_pin_circle,
  //       Colors.blue,
  //     );

  //     markers.add(Marker(
  //       markerId: const MarkerId("currentLocation"),
  //       position: currentLocation.value!,
  //       icon: currentLocationIcon,
  //       infoWindow: const InfoWindow(title: "Current Location"),
  //     ));

  //     // Add custom marker for target location
  //     BitmapDescriptor targetLocationIcon = await _getCustomMarker(
  //       Icons.location_on,
  //       Colors.red,
  //     );

  //     markers.add(Marker(
  //       markerId: const MarkerId("targetLocation"),
  //       position: LatLng(targetLat, targetLong),
  //       icon: targetLocationIcon,
  //       infoWindow: const InfoWindow(title: "Target Location"),
  //     ));

  //     _mapController?.animateCamera(CameraUpdate.newLatLng(currentLocation.value!));

  //     await _fetchAddress();
  //   } catch (e) {
  //     print('Error fetching location: $e');
  //     // Handle error fetching location
  //   }
  // }

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

  // Future<void> checkDistanceFromSpecificLocation(BuildContext context,String courseId, String batchId) async {
  //   // Get user's current location
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );

  //   // Calculate distance between current location and specific location
  //   double distanceInMeters = await Geolocator.distanceBetween(
  //     position.latitude,
  //     position.longitude,
  //     targetLat,
  //     targetLong,
  //   );

  //   // Define threshold distance
  //   double thresholdInMeters = punchable_distance_in_meters;

  //   // Check if distance is within the threshold

  //   if (distanceInMeters <= thresholdInMeters) {
  //     print("User is within 500 meters of the specific location.");

  //     //punchedIn.value = !punchedIn.value;

  //     if (!punchedIn.value) {
  //      // Within punchable range, call the API to punch in
  //       final getAttendancePunchInModel? response =
  //           await WebService.getAttendancePunchIn(courseId, batchId);

  //       if (response != null && response.success == true) {
  //         // API call was successful, update state and show success message
  //         punchedIn.value = true;
  //         showAnimatedDialog(
  //             'You have successfully punched In', "assets/images/success_punching.png");
  //         SnackBarUtils.showSuccessSnackBar(context, response.message ?? '');
  //       } else {
  //         // Show error if the API call failed
  //         punchedIn.value = false;
  //         SnackBarUtils.showErrorSnackBar(context, response?.message ?? 'Failed to punch in');
  //       }
  //     } else {
  //       showAnimatedDialog(
  //           'You have punched out now', "assets/images/success_punching.png");
  //     }
  //   } else {
  //     print("User is outside 500 meters of the specific location.");

  //     showAnimatedDialog(
  //         'You are away from the office', "assets/images/error_punching.png");
  //   }
  // }

  Future<void> checkDistanceFromSpecificLocation(
      BuildContext context,
      String courseId,
      String batchId,
      String batchTimingStart,
      String batchTimingEnd) async {
    buttonLoader(true);

    print("getingbv  vakluyeuwkgqie====>");
    // Get user's current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Calculate distance between current location and specific location
    double distanceInMeters = await Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
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
    // Check if current time is within 30 minutes before the batch start time
    bool isWithinPunchInWindow =
        now.isAfter(batchStartTime.subtract(const Duration(minutes: 30))) &&
            now.isBefore(batchEndTime);

    // Check if distance is within the threshold
    if (distanceInMeters <= thresholdInMeters) {
      if (isWithinPunchInWindow) {
        if (!punchedIn.value) {
          // Within punchable range, call the API to punch in

          final getAttendancePunchInModel? response =
              await WebService.getAttendancePunchIn(courseId, batchId, context);

          if (response != null && response.success == true) {
            // API call was successful, update state and show success message
            punchedIn.value = true;
            buttonLoader(false);
            showAnimatedDialog('You have successfully punched In',
                "assets/images/success_punching.png");
            SnackBarUtils.showSuccessSnackBar(context, response.message ?? '');
          } else {
            // Show error if the API call failed
            punchedIn.value = false;
            buttonLoader(false);
            SnackBarUtils.showErrorSnackBar(
                context, response!.message!);
          }
        } else {
          final getAttendancePunchInModel? response =
              await WebService.getAttendancePunchOut(context);

          if (response != null && response.success == true) {
            // API call was successful, update state and show success message
            punchedIn.value = false;
            buttonLoader(false);
            showAnimatedDialog('You have successfully punched Out',
                "assets/images/success_punching.png",);
                
           // SnackBarUtils.showSuccessSnackBar(context, response.message ?? '');
            
             Get.to(()=> TuteeAttendanceList());
          } else {
            // Show error if the API call failed
            buttonLoader(false);
            SnackBarUtils.showErrorSnackBar(
                context, response!.message!);
          }
        }
      } else {
        buttonLoader(false);
        SnackBarUtils.showErrorSnackBar(context,
            'You can only punch in within 30 minutes of the batch start time: ${batchTimingStart}.');
      }
    } else {
      print("User is outside 500 meters of the specific location.");
      buttonLoader(false);
      showAnimatedDialog(
          'You are away from the office', "assets/images/error_punching.png");
    }
  }

// Helper function to parse the batch time
// Helper function to parse the batch time
// Helper function to parse the batch time
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

  void addPunchIn(BuildContext context, String courseId, String batchId) async {
    isLoading.value = true;
    try {
      final getAttendancePunchInModel? response =
          await WebService.getAttendancePunchIn(courseId, batchId, context);

      if (response != null && response.success == true) {
        // Show success dialog when API response is successful
        showAnimatedDialog('You have successfully punched In',
            "assets/images/success_punching.png");

        // Change the punchedIn value to true
        punchedIn.value = false;

        SnackBarUtils.showSuccessSnackBar(context, response.message ?? '');
        Get.back();
        onInit(); // Refresh data
      } else {
        SnackBarUtils.showErrorSnackBar(
            context, response!.message!);
      }
    } catch (e) {
      SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void addPunchOut(
      BuildContext context, String courseId, String batchId) async {
    isLoading.value = true;
    try {
      final getAttendancePunchInModel? response =
          await WebService.getAttendancePunchIn(courseId, batchId, context);

      if (response != null && response.success == true) {
        SnackBarUtils.showSuccessSnackBar(context, 'Batch added successfully');
        Get.back();
        onInit();
      } else {
        SnackBarUtils.showErrorSnackBar(
            context, response?.message ?? 'Failed to add batch');
      }
    } catch (e) {
      SnackBarUtils.showErrorSnackBar(context, 'Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
