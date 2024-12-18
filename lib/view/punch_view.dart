import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/punch_controller.dart';
import 'package:hovee_attendence/modals/getAttendanceCourseList_model.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/view/qrscanner_screen.dart';
import 'package:hovee_attendence/widget/addres_indicator.dart';
import 'package:hovee_attendence/widget/button_splash.dart';
import 'package:hovee_attendence/widget/custom_texts.dart';
import 'package:hovee_attendence/widget/space.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PunchView extends StatelessWidget {
  PunchView(
      {super.key,
      required this.className,
      required this.courseId,
      required this.batchId,
      required this.batchStartTime,
      required this.batchEndTime, required this.subjectName, required this.courseCode});
  final PunchController _controller = Get.put(PunchController());
  final String className;
  final String courseId;
  final String batchId;
  final String batchStartTime;
  final String batchEndTime;
  final String subjectName;
  final String courseCode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          Get.back();
          print("object");
        },
      ),
      body: Stack(
        children: [
          Column(
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
                Future.delayed(const Duration(milliseconds: 200), () async {
                  try {
                    await _controller.mapController?.animateCamera(
                      CameraUpdate.newLatLng(_controller.currentLocation.value!),
                    );
                  } catch (e) {
                    print('Error animating camera: $e');
                    Logger().i('Error animating camera: $e');
                  }
                });
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
                    _controller.targetLat!,
                    _controller.targetLong!,
                  ),
                  radius: _controller.punchable_distance_in_meters,
                  fillColor: Colors.blue.withOpacity(0.5),
                  strokeColor: Colors.blue,
                  strokeWidth: 2,
                ),
              },
            ),
            _controller.currentAddress.value.toString().trim() == ""
                ? SizedBox()
                :    Obx(
            () => Positioned(
              top: _controller.draggablePosition.value.dy,
              left: _controller.draggablePosition.value.dx,
              child: GestureDetector(
                onPanUpdate: (details) {
                  _controller.updateDraggablePosition(details.delta);
                },
                child: AddressIndicator(
                  name: _controller.name ?? '',
                  address: _controller.currentAddress.value ?? "",
                ),
              ),
            ),
          ),
          ],
        ),
),
                ),
              ),
              Container(
                height: 120,
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
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
          Obx(() => _controller.buttonLoader.value
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black.withOpacity(0.3),
                  child: Center(
                    child: Container(
                 
                      decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(12)

                      ),
                      height: 200,
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_controller.buttonLoader.value)
                            CircularProgressIndicator(
                              color: AppConstants.primaryColor,
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Submitting attendance",
                            style: GoogleFonts.nunito(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink())
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 120),
        child: ButtonSplashEffect(
          borderRadius: 50,
         onTapped: () async {
  if (_controller.hasScanned.value) {
    // Punch in/out action
    Future.delayed(const Duration(milliseconds: 200), () {
      _controller.checkDistanceFromSpecificLocation(
          context, courseId, batchId, batchStartTime, batchEndTime);
    });
  } else {
    // Call the QR scanner function and await result
    await showQRScannerScreen(context);

    // Check if the scan was successful
    if (_controller.hasScanned.value) {
      Logger().i("Scan successful");
      print("hi rahul: Scan successful");
      _controller.getCurrentLocation();
    } else {
      Logger().i("Scan not completed");
      print("hi rahul: Scan not completed");
    }
  }
},

          widget: Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45),
              color: AppConstants.primaryColor.withOpacity(0.3),
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
                    child: _controller.hasScanned.value
                        
                          ? regularText(
                      text: _controller.punchedIn.value
                          ? 'Punch Out'
                          : 'Punch In',
                      fontSize: 12,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.qr_code_scanner,
                      size: 40,
                      color: Colors.white,
                    ), // 
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

  bottomInfo(String title, String value,) {
    return Row(
      children: [
        Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xfff0f0f0),
          ),
          child: Container(
            // color: Colors.amber,
            //     height: 40,width: 40,
            margin: EdgeInsets.symmetric(vertical: 1,horizontal: 1),
            child:  Image.asset(
                'assets/tuteeHomeImg/image 193.png',
              ),
          ),
        ),
        Expanded(
          child: Container(
            // height: 45,
            padding: const EdgeInsets.only(left: 12,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text("${courseId}"),
                regularText(text: courseCode),
                subText(
                  text: "${className} - ${subjectName}",
                ),
                   subText(
                  text: "${batchStartTime} - ${batchEndTime}",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> showQRScannerScreen(BuildContext context) async {
  await showDialog(
    context: context,
    builder: (context) {
      return Scaffold(
        // appBar: AppBar(title: Text('QR Code Scanner')),
        body: AiBarcodeScanner(
          hideGalleryButton: true,
          controller: MobileScannerController(),
          onDetect: (po) {
            _onBarcodeScanned(po.barcodes.first.rawValue);
          },
        ),
      );
    },
  );
}

void _onBarcodeScanned(String? scannedData) async {
  if (scannedData == null) return;

  // Extract latitude and longitude
  final latitude = _extractCoordinate(scannedData, 'latitude');
  final longitude = _extractCoordinate(scannedData, 'longitude');

  // Store in SharedPreferences
  if (latitude != null && longitude != null) {
    await _saveCoordinatesToPreferences(latitude, longitude);
  }

  _controller.hasScanned.value = true;
  Get.back(result: _controller.hasScanned.value);
}

double? _extractCoordinate(String code, String type) {
  final regex = RegExp('$type=([0-9.]+)');
  final match = regex.firstMatch(code);
  if (match != null) {
    return double.tryParse(match.group(1)!);
  }
  return null;
}

Future<void> _saveCoordinatesToPreferences(double latitude, double longitude) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('target_lat', latitude);
  await prefs.setDouble('target_long', longitude);
  print('Latitude and Longitude saved: $latitude, $longitude');
}
}


class MarkerWidget extends StatelessWidget {
  final String imagePath;
  final double rotationAngle; // Rotation angle in radians

  const MarkerWidget({
    Key? key,
    required this.imagePath,
    this.rotationAngle = 0, // Default rotation is 0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationAngle, // Apply the rotation here
      child: SvgPicture.asset(
        imagePath,
        height: 110,
        width: 110,
      ),
    );
  }
}


