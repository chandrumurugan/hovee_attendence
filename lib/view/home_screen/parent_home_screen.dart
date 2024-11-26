import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovee_attendence/services/firestoreService.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';

class ParentView extends StatefulWidget {
  String userId;
 
   ParentView({super.key, required this.userId});

  @override
  _ParentViewState createState() => _ParentViewState();
}

class _ParentViewState extends State<ParentView> {
  final FirestoreService _locationService = FirestoreService();
  LatLng? _studentLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(needGoBack: true, navigateTo: (){
        Get.back();
      }),
      body: StreamBuilder<Map<String, dynamic>>(
        stream: _locationService.getStudentLiveLocation(userId: widget.userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data?['location'] == null) {
            return const Center(child: Text("Location not available"));
          }

          final location = snapshot.data!['location'];
          _studentLocation = LatLng(location['lat'], location['lng']);

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _studentLocation!,
              zoom: 15,
            ),
            markers: _studentLocation != null
                ? {
                    Marker(
                      markerId: const MarkerId("student"),
                      position: _studentLocation!,
                      infoWindow: const InfoWindow(title: "Student Location"),
                    ),
                  }
                : {},
          );
        },
      ),
    );
  }
}
