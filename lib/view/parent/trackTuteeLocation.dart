import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/track_tutee_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';

class TrackTuteeLocation extends StatelessWidget {
  TrackTuteeLocation({super.key});

  final controller = Get.put(TrackTuteeLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          Get.back();
        },
      ),
      body: Obx(() {
        if (controller.tuteeLocation.value == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: controller.tuteeLocation.value!,
                zoom: 15,
              ),
              trafficEnabled: true,
              mapType: MapType.hybrid,
              markers: controller.markers.value,
              polylines: {
                Polyline(
                  polylineId: const PolylineId("road_route"),
                  color: AppConstants.primaryColor,
                  width: 5,
                  points: controller.polylineCoordinates,
                  jointType: JointType.mitered
                ),
              },
              circles: {
                Circle(
                  circleId: const CircleId("target_radius"),
                  center: controller.targetLocation.value,
                  radius: 200, // Radius in meters
                  fillColor: Colors.blue.withOpacity(0.2),
                  strokeColor: Colors.blue,
                  strokeWidth: 2,
                ),
              },
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Card(
                color: Colors.white,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Distance to target: ${controller.distance.value.toStringAsFixed(2)} km",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
