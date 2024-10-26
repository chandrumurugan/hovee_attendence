import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hovee_attendence/constants/common_function.dart';
import 'package:hovee_attendence/widget/widget_to_icon.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class PunchController extends GetxController {
  GoogleMapController? _mapController;
  var currentLocation = Rxn<LatLng>();
  var currentAddress = Rxn<String>();
  var markers = <Marker>{}.obs;
  GoogleMapController? get mapController => _mapController;
  final punchedIn = false.obs;
  double punchable_distance_in_meters = 500;
double targetLat = 13.046720258037634;
double targetLong = 80.21353338187131;

  void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  void onInit() {
    super.onInit();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      var result = await Permission.location.request();
      if (result.isGranted) {
        _getCurrentLocation();
      } else {
        // Handle the case when the user denies the permission
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentLocation.value = LatLng(position.latitude, position.longitude);
      Get.log("currentLocation.value ${currentLocation.value}");
      markers.add(Marker(
        markerId: const MarkerId("currentLocation"),
        position: currentLocation.value!,
        icon: await const WidgetToIcon().toBitmapDescriptor(
          logicalSize: const Size(150, 150),
          imageSize: const Size(400, 400),
        ),
        infoWindow: const InfoWindow(title: "Current Location"),
      ));
      _mapController
          ?.animateCamera(CameraUpdate.newLatLng(currentLocation.value!));

      await _fetchAddress();
    } catch (e) {
      print('Error fetching location: $e');
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
              "${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}";
          // You can access other address details like postal code, sub locality, etc. from placemark
        }
      }
    } catch (e) {
      print('Error fetching address: $e');
      // Handle error fetching address
    }
  }

  Future<void> checkDistanceFromSpecificLocation() async {
    // Get user's current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Calculate distance between current location and specific location
    double distanceInMeters = await Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      targetLat,
      targetLong,
    );

    // Define threshold distance
    double thresholdInMeters = punchable_distance_in_meters;

    // Check if distance is within the threshold

    if (distanceInMeters <= thresholdInMeters) {
      print("User is within 500 meters of the specific location.");

      punchedIn.value = !punchedIn.value;

      if (punchedIn.value) {
        showAnimatedDialog(
            'You have successfully punched In', "assets/images/success_punching.png");
      } else {
        showAnimatedDialog(
            'You have punched out now', "assets/images/success_punching.png");
      }
    } else {
      print("User is outside 500 meters of the specific location.");

      showAnimatedDialog(
          'You are away from the office', "assets/images/error_punching.png");
    }
  }
}
