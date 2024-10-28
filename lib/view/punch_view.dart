import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/punch_controller.dart';
import 'package:hovee_attendence/modals/getAttendanceCourseList_model.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/widget/addres_indicator.dart';
import 'package:hovee_attendence/widget/button_splash.dart';
import 'package:hovee_attendence/widget/custom_texts.dart';
import 'package:hovee_attendence/widget/space.dart';
import 'package:intl/intl.dart';

class PunchView extends StatelessWidget {
  PunchView({super.key, required this.className, required this.courseId, required this.batchId, required this.batchStartTime, required this.batchEndTime});
  final PunchController _controller = Get.put(PunchController());
  final String className;
 final String courseId;final String batchId;
 final String batchStartTime;
 final String batchEndTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          Get.back();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: SizedBox(
              child: Obx(
                () => _controller.currentLocation.value == null
                    ? const Center(child: CircularProgressIndicator())
                    : Stack(
                        children: [
                          GoogleMap(
                            onMapCreated: (controller) {
                              _controller.setMapController(controller);
                            },
                            initialCameraPosition: CameraPosition(
                              target: _controller.currentLocation.value!,
                              zoom: 14.0,
                            ),
                            markers: _controller.markers.value,
                            myLocationEnabled: false,
                            myLocationButtonEnabled: true,
                            circles: {
                              Circle(
                                circleId: const CircleId("circle_1"),
                                center: LatLng(
                                    _controller.targetLat,
                                    _controller
                                        .targetLong), // Specific location
                                radius:
                                    _controller.punchable_distance_in_meters,
                                fillColor: Colors.blue.withOpacity(0.5),
                                strokeColor: Colors.blue,
                                strokeWidth: 2,
                              ),
                            },
                          ),
                          _controller.currentAddress.value.toString().trim() ==
                                  ""
                              ? SizedBox()
                              : AddressIndicator(
                                  address:
                                      _controller.currentAddress.value ?? "",
                                ),
                        ],
                      ),
              ),
            ),
          ),
          Container(
            height: 180,
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bottomInfo(
                  className,
                  DateFormat('ha, dd MMM yyyy').format(
                    DateTime.now(),
                  ),
                ),
                space(h: 12),
                // bottomInfo(
                //   'Hostal Name & Room Number',
                //   "Test | 001",
                // ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: ButtonSplashEffect(
          borderRadius: 50,
          onTapped: () {
            Future.delayed(const Duration(milliseconds: 200), () {
              _controller.checkDistanceFromSpecificLocation(context, courseId, batchId,batchStartTime,batchEndTime);
              // Call addPunchIn or addPunchOut based on the punch state
              // if (_controller.punchedIn.value) {
              //   // User is punched in, call addPunchOut
              //   _controller.addPunchOut(context, courseId, batchId);
              // } else {
              //   // User is not punched in, call addPunchIn
              //  _controller.addPunchIn(context, courseId, batchId);
              // }
            });
          },
          widget: Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: AppConstants.secondaryColor,
            ),
            child: Center(
              child: Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(38),
                  color: AppConstants.primaryColor,
                ),
                child: Obx(
                  () => Center(
                    child: regularText(
                      text: _controller.punchedIn.value
                          ? 'Punch Out'
                          : 'Punch In',
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  bottomInfo(String title, String value) {
    return Row(
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xfff0f0f0),
          ),
        ),
        Expanded(
          child: Container(
            height: 45,
            padding: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                regularText(text: title),
                subText(
                  text: value,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
