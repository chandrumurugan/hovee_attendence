import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/track_tutee_controller.dart';
import 'package:hovee_attendence/modals/getGroupedEnrollmentByBatch_model.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';

class TrackTuteeLocation extends StatelessWidget {
    final String type;
      final String? firstname,lastname,wowid;
  TrackTuteeLocation({super.key, required this.type, this.firstname, this.lastname, this.wowid});

  final controller = Get.put(TrackTuteeLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          Get.offAll(DashboardScreen(rolename: type,firstname: firstname??'',lastname: lastname??'',wowid: wowid??'',));
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
              onMapCreated: controller.setMapController,
              initialCameraPosition: CameraPosition(
                target: controller.tuteeLocation.value!,
                zoom: 10,
              ),
              trafficEnabled: true,
              mapType: MapType.terrain,
              markers: controller.markers.value,
               onCameraMove: controller.handleCameraPositionChange,
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
                  center:  controller.targetLocation.value ?? LatLng(0.0, 0.0),
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
            // DropdownButton<Data1>(
            //             value: controller.selectedBatchIN.value,
            //             hint:  Text('Select'),
            //             icon: const Icon(Icons.arrow_drop_down),
            //             iconSize: 24,
            //             elevation: 16,
            //             style: const TextStyle(
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w500,
            //                 color: Colors.black),
            //             underline: Container(
            //               height: 0,
            //               color: Colors.transparent,
            //             ),
            //             onChanged: (newBatch) {
            //               if (newBatch != null) {
            //                 controller.selectBatch(newBatch);
            //                 controller.isBatchSelected.value = true;
            //                 controller.fetchBatchLocationList(
            //                   newBatch.batchId!,
            //                 );
            //               }
            //             },
            //             items: controller.batchList.map((Data1 batch) {
            //               return DropdownMenuItem<Data1>(
            //                 value: batch,
            //                 child: Text(batch.batchName!),
            //               );
            //             }).toList(),
            //           )
          ],
        );
      }),
    );
  }
}
