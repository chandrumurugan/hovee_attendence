import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hovee_attendence/constants/colors_constants.dart';
import 'package:hovee_attendence/controllers/hostel_punchin_controller.dart';
import 'package:hovee_attendence/utils/customAppBar.dart';
import 'package:hovee_attendence/view/dashboard_screen.dart';
import 'package:hovee_attendence/widget/addres_indicator.dart';
import 'package:hovee_attendence/widget/button_splash.dart';
import 'package:hovee_attendence/widget/custom_texts.dart';
import 'package:hovee_attendence/widget/space.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HostelPunchView extends StatelessWidget {
  final String hostelName;
  final String hostelId;
  final String hostelObjId;
  final String hostelStartTime;
  final String hostelEndTime;
  final String wowId,hostelType,room;
    final RxString  type;
    final String firstname, lastname,wowid;
    final HostelPunchinController _controller;
   HostelPunchView({super.key, required this.hostelName, required this.hostelId, required this.hostelObjId, required this.hostelStartTime, required this.hostelEndTime, required this.wowId, required this.hostelType, required this.room, required this.type,required this.firstname,required this.lastname,required this.wowid}): _controller = Get.put(HostelPunchinController());
   
  @override
  Widget build(BuildContext context) {
   //final HostelPunchinController _controller = Get.put(HostelPunchinController(),permanent: true);
     _controller.onInit();
    return Scaffold(
      appBar: AppBarHeader(
        needGoBack: true,
        navigateTo: () {
          
        Get.offAll(DashboardScreen(
            rolename: type.value,
            firstname: firstname ?? '',
            lastname: lastname ?? '',
            wowid: wowid ?? '',
          ));
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
                      hostelName,
                      DateFormat('ha, dd MMM yyyy').format(
                        DateTime.now(),
                      ),
                    
                    ),
                    space(h: 12),
                  ],
                ),
              )
            ],
          ),
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
          context, hostelId, hostelObjId, hostelStartTime, hostelEndTime,hostelName);
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
          text: _controller.punchedIn.value ? 'Punch In' : 'Punch Out',
          fontSize: 12,
          color: Colors.white,
        )
      : Icon(
          Icons.qr_code_scanner,
          size: 40,
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
                regularText(text: hostelName),
                subText(
                  text: "${hostelType} - ${room}",
                ),
                   subText(
                  text: "${hostelStartTime} - ${hostelEndTime}",
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
        appBar: AppBar(title: Text('QR Code Scanner')),
         body: AiBarcodeScanner(
          extendBodyBehindAppBar: false,
          hideGalleryButton: true,
          hideGalleryIcon: true,
          controller: MobileScannerController(facing: CameraFacing.back,),
          onDetect: (po) {
            _onBarcodeScanned(po.barcodes.first.rawValue);
          },
        ),
      );
    },
  );
}


void _onBarcodeScanned(String? scannedData) async {
  final HostelPunchinController _controller = Get.put(HostelPunchinController());
  if (scannedData == null) return;

  // Extract wowId, latitude, and longitude
  final wowIdFromCode = _extractWowId(scannedData);
  final latitude = _extractCoordinate(scannedData, 'latitude');
  final longitude = _extractCoordinate(scannedData, 'longitude');

  if (wowIdFromCode == null) {
     Get.snackbar(
         'Invalid QR Code',
  icon: const Icon(Icons.info, color: Colors.white, size: 40),
  colorText: Colors.white,
  backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
  shouldIconPulse: false,
  // messageText:    SizedBox(
  //   height: 30, // Set desired height here
  //   child: Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 5.0),
  //     child: Text(
  //       'Invalid QR Code',
  //     textAlign: TextAlign.start,
  //       style: TextStyle(color: Colors.white, fontSize: 16),
  //     ),
  //   ),
  // ),
);
    return;
  }

  // Validate wowId
  if (wowIdFromCode == wowId) {
    if (latitude != null && longitude != null) {
      // Store in SharedPreferences
      await _saveCoordinatesToPreferences(latitude, longitude);
      _controller.hasScanned.value = true;
    } else {
       Get.snackbar(
          'Invalid QR Code',
          icon: const Icon(Icons.info, color: Colors.white, size: 40),
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
          shouldIconPulse: false,
  //         messageText:    SizedBox(
  //   height: 30, // Set desired height here
  //   child: Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 5.0),
  //     child: Text(
  //       'Invalid QR Code',
  //     textAlign: TextAlign.start,
  //       style: TextStyle(color: Colors.white, fontSize: 16),
  //     ),
  //   ),
  // ),
        );
    }
  } else {
   Get.snackbar(
          'Invalid QR Code',
          icon: const Icon(Icons.info, color: Colors.white, size: 40),
          colorText: Colors.white,
          backgroundColor: const Color.fromRGBO(186, 1, 97, 1),
          shouldIconPulse: false,
  //          messageText:    SizedBox(
  //   height: 30, // Set desired height here
  //   child: Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 5.0),
  //     child: Text(
  //       'Invalid QR Code',
  //     textAlign: TextAlign.start,
  //       style: TextStyle(color: Colors.white, fontSize: 16),
  //     ),
  //   ),
  // ),
        );
  }

  // Ensure that Get.back is called after setting hasScanned value
  if (_controller.hasScanned.value) {
    Get.back(result: _controller.hasScanned.value);
  }
}


String? _extractWowId(String code) {
  final regex = RegExp(r'/([\w\d]+)$');
  final match = regex.firstMatch(code);
  if (match != null) {
    Logger().i("${match} message}");
    return match.group(1);
  }
  return null;
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