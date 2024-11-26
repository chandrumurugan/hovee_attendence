import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovee_attendence/services/firestoreService.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TrackTuteeLocationController extends GetxController {
  final FirestoreService _locationService = FirestoreService();
  dynamic argumentData = Get.arguments;

  var tuteeLocation = Rxn<LatLng>();
  var targetLocation = const LatLng(12.971598, 77.594566).obs;

  var distance = 0.0.obs;
  var polyline = <Polyline>[].obs;
    var polylineCoordinates = <LatLng>[].obs;
  var markers = <Marker>{}.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Logger().i("getting valiues fro argumets==>${argumentData[0]['userId']}");

    getTuteeLocation();

  }

  Stream<Map<String, dynamic>> getTuteeLiveLocation(String userId) {
    return _locationService.getStudentLiveLocation(userId: userId);
  }

  void getTuteeLocation() async {
    try {
         getTuteeLiveLocation("${argumentData[0]['userId']}").listen((data) async {
      if (data['location'] != null) {
        LatLng location =
            LatLng(data['location']['lat'], data['location']['lng']);
        tuteeLocation.value = location;

        updateMarkers();
          await fetchRoadRoute();
        updateDistance();
      }
    }); 
    } catch (e) {
      print(e); 
    }
 
  }

  void updateMarkers() {
    if (tuteeLocation.value != null) {
      markers.value = {
        Marker(
          markerId: const MarkerId("student"),
          position: tuteeLocation.value!,
          infoWindow: const InfoWindow(title: "Tutee Location"),
          
        ),
        Marker(
          markerId: const MarkerId("target"),
          position: targetLocation.value,
          infoWindow: const InfoWindow(title: "Tution Location"),
        ),
      };
    }
  }

  void updateDistance() {
    if (tuteeLocation.value != null) {
      distance.value = Geolocator.distanceBetween(
            tuteeLocation.value!.latitude,
            tuteeLocation.value!.longitude,
            targetLocation.value.latitude,
            targetLocation.value.longitude,
          ) /
          1000; // Convert to kilometers
      updatePolyline();
    }
  }

  void updatePolyline() {
    if (tuteeLocation.value != null) {
      polyline.value = [
        Polyline(
          polylineId: const PolylineId("route"),
          points: [tuteeLocation.value!, targetLocation.value],
          color: Colors.blue,
          width: 5,
        ),
      ];
    }
  }

    Future<void> fetchRoadRoute() async {
    try {
      const apiKey = "AIzaSyCe2-5wVLxW2xSeQpqVzVCEt9n3ppUAwXA"; // Replace with your API key
      final origin =
          "${tuteeLocation.value!.latitude},${tuteeLocation.value!.longitude}";
      final destination =
          "${targetLocation.value.latitude},${targetLocation.value.longitude}";
      final url =
          "https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$apiKey";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data["routes"].isNotEmpty) {
          final route = data["routes"][0];
          final polyline = route["overview_polyline"]["points"];
          polylineCoordinates.value = decodePolyline(polyline);
        }
      } else {
        // Logger().i("gett")
        print("Failed to fetch directions: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error fetching directions: $e");
    }
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int b;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return polyline;
  }
}
