import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByBatch_model.dart';
import 'package:hovee_attendence/services/firestoreService.dart';
import 'package:hovee_attendence/services/webServices.dart';
import 'package:hovee_attendence/view/punch_view.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:widget_to_marker/widget_to_marker.dart';

class TrackTuteeLocationController extends GetxController {
  final FirestoreService _locationService = FirestoreService();
  dynamic argumentData = Get.arguments;
  late GoogleMapController _mapController;

  var tuteeLocation = Rxn<LatLng>();
  var targetLocation = Rxn<LatLng>();
   var previousLocation = Rxn<LatLng>();
  //var targetLocation = const LatLng(13.039422387848779,80.22285977520232).obs;

  var distance = 0.0.obs;
  var polyline = <Polyline>[].obs;
  var polylineCoordinates = <LatLng>[].obs;
  var markers = <Marker>{}.obs;
  var name;

  var selectedBatchIN = Rxn<Data1>();

  var isBatchSelected = false.obs;

  var batchList = <Data1>[].obs;

  var isLoading = true.obs;
  var target = Rxn<LatLng>();

  var fetchingRoute = false.obs;
   Timer? markerAnimationTimer;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //Logger().i("getting valiues fro argumets==>${argumentData[0]['userId']}");
   
    fetchGroupedEnrollmentByBatchListItem();
    getTuteeLocation();
  }
    void setMapController(GoogleMapController controller) {
    _mapController = controller;
  }

  Stream<Map<String, dynamic>> getTuteeLiveLocation(String userId) {
    return _locationService.getStudentLiveLocation(userId: userId);
  }

  void getTuteeLocation() async {
    try {
        var userId = argumentData[0]['userId'].toString();
      getTuteeLiveLocation(userId).listen((data) async {
        if (data['location'] != null) {
          LatLng location = 
          //const LatLng(13.043303, 80.213260);
               LatLng(data['location']['lat'], data['location']['long']);
          tuteeLocation.value = location;
          
          name = data['name'];
          updateMarkers(name);
          await fetchRoadRoute();
          updateDistance();
          _checkRouteDeviation();
           // Smooth Animation
          animateMarker(previousLocation.value, tuteeLocation.value!);
        }
      });
    } catch (e) {
      print(e);
    }
  }
    void animateMarker(LatLng? from, LatLng to) {
    if (from == null) return;
    const int steps = 50;
    int step = 0;
    markerAnimationTimer?.cancel();

    markerAnimationTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      double latitude = from.latitude + ((to.latitude - from.latitude) / steps) * step;
      double longitude = from.longitude + ((to.longitude - from.longitude) / steps) * step;
      tuteeLocation.value = LatLng(latitude, longitude);

      updateMarkers(name);
      step++;

      if (step >= steps) {
        timer.cancel();
      }
    });
  }

  void _checkRouteDeviation() {
    if (tuteeLocation.value != null && polylineCoordinates.isNotEmpty) {
      final distanceFromRoute = Geolocator.distanceBetween(
        tuteeLocation.value!.latitude,
        tuteeLocation.value!.longitude,
        polylineCoordinates.first.latitude,
        polylineCoordinates.first.longitude,
      );

      if (distanceFromRoute > 50) {
        fetchRoadRoute(); // Fetch a new route if deviation exceeds 50 meters
      }
    }
  }

  Future<void> updateMarkers(String name) async {
    if (tuteeLocation.value != null) {
      markers.value = {
        Marker(
          markerId: const MarkerId("student"),
          icon: await const MarkerWidget(
            imagePath: 'assets/appbar/Tutee_location_marker_v3.svg',
          ).toBitmapDescriptor(
            logicalSize: const Size(150, 150),
            imageSize: const Size(400, 400),
          ),
          position: tuteeLocation.value!,
          infoWindow: InfoWindow(title: name),
        ),
        Marker(
          markerId: const MarkerId("target"),
          icon: await const MarkerWidget(
                  rotationAngle: 60 * (3.14159 / 120),
                  imagePath: 'assets/appbar/Tutor_location_marker_v2.svg')
              .toBitmapDescriptor(
            logicalSize: const Size(150, 150),
            imageSize: const Size(400, 400),
          ),
          position: targetLocation.value!,
          infoWindow: const InfoWindow(title: "Tution Location"),
        ),
      };
    }
  }
   
     void handleCameraPositionChange(CameraPosition position) {
    if (tuteeLocation.value != null) {
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: tuteeLocation.value!,
            zoom: 15, // Adjust the zoom level as needed
          ),
        ),
      );
    }
  }
  void updateDistance() {
    if (tuteeLocation.value != null) {
      distance.value = Geolocator.distanceBetween(
            tuteeLocation.value!.latitude,
            tuteeLocation.value!.longitude,
            targetLocation.value!.latitude,
            targetLocation.value!.longitude,
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
          points: [tuteeLocation.value!, targetLocation.value!],
          color: Colors.blue,
          width: 5,
        ),
      ];
    }
  }

  Future<void> fetchRoadRoute() async {
    if (fetchingRoute.value) return;

    fetchingRoute.value = true;
    try {
      const apiKey =
          "AIzaSyCe2-5wVLxW2xSeQpqVzVCEt9n3ppUAwXA"; // Replace with your API key
      final origin =
          "${tuteeLocation.value!.latitude},${tuteeLocation.value!.longitude}";
      final destination =
          "${targetLocation.value!.latitude},${targetLocation.value!.longitude}";
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
    } finally {}
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

  void selectBatch(Data1 batch) {
    selectedBatchIN.value = batch;
  }

  void fetchGroupedEnrollmentByBatchListItem() async {
    isLoading(true);
    try {
      // Call your API to fetch the data
      var response = await WebService.fetchGroupedEnrollmentByBatch();
      Logger().i(response);
      if (response != null && response.data != null) {
        batchList.clear();
        batchList.addAll(response.data!);
        // isLoading(false); // Add batches to the observable list
        if (batchList.isNotEmpty) {
          selectedBatchIN.value = batchList.first;
          fetchBatchLocationList(selectedBatchIN.value!.batchId!);
          isBatchSelected.value = true;
          print(selectedBatchIN.value);
        }
      }
    } catch (e) {
      // Handle any errors
      isLoading(false);
      print('Error fetching batches: $e');
    } finally {
      isLoading(false);
    }
  }

  void fetchBatchLocationList(String batchId) async {
    try {
      isLoading(true);

      var batchLocationResponse = await WebService.fetchBatchLocation(batchId);

      if (batchLocationResponse?.data != null) {
        // Access location and coordinates
        var location = batchLocationResponse!.data!.location;
        if (location != null && location.coordinates != null) {
          double latitude = location.coordinates![1];
          double longitude = location.coordinates![0];
          Logger().i("Latitude: $latitude, Longitude: $longitude");
          target.value = LatLng(latitude, longitude);
          targetLocation.value = target.value!;
        } else {
          Logger().w("Location or coordinates are null");
        }
      } else {
        Logger().w("Batch location response data is null");
      }
    } catch (e) {
      Logger().e("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
