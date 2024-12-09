import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationService {

    Future<LatLng?> getCurrentLocation() async {
    try {
      Position position = await determinePosition();
            final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('latitude', position.latitude);
      await prefs.setDouble('longitude', position.longitude);
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      Logger  ().e(e);
      // print("Error fetching location: $e");
      return null;
    }
  }
  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool locationServiceRequest = await Geolocator.openLocationSettings();
      if (!locationServiceRequest) {
        throw 'Location services are disabled.';
      }
      // Wait for the user to enable location services
      await Future.delayed(Duration(seconds: 1));
      // throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
