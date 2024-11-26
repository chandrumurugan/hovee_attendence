import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovee_attendence/modals/firebase_userData_modal.dart';
import 'package:hovee_attendence/services/liveLocationService.dart';
import 'package:logger/logger.dart';

class FirestoreService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> updateUserLocation(
      {required String userId,
      // required LatLng location,
      required String username}) async {
    bool serviceEnabled;

    try {
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

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      Geolocator.getPositionStream(
          locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      )).listen((Position position) async {
        await _firestore.collection("users").doc(userId).set(
          {
            "name": username,
            'location': {'lat': position.latitude, 'lng': position.longitude},
            'timeStamp': FieldValue.serverTimestamp()
          },
          SetOptions(merge: true),
        );
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<Map<String, dynamic>> getStudentLiveLocation(
      {required String userId}) {
    return _firestore.collection("users").doc(userId).snapshots().map(
        (DocumentSnapshot snapshot) => snapshot.data() as Map<String, dynamic>);
  }
}
