import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hovee_attendence/view/punch_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRScannerScreen extends StatefulWidget {
    final String className;
  final String courseId;
  final String batchId;
  final String batchStartTime;
  final String batchEndTime;
  final String subjectName;
  final String courseCode;

  const QRScannerScreen({super.key, required this.className, required this.courseId, required this.batchId, required this.batchStartTime, required this.batchEndTime, required this.subjectName, required this.courseCode});
  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController qrController) {
    setState(() {
      controller = qrController;
    });
    controller?.scannedDataStream.listen((scanData) async {
      controller?.pauseCamera();
      final code = scanData.code;
      
      // Extract latitude and longitude
      final latitude = _extractCoordinate(code!, 'latitude');
      final longitude = _extractCoordinate(code!, 'longitude');

      // Store in SharedPreferences
      if (latitude != null && longitude != null) {
        await _saveCoordinatesToPreferences(latitude, longitude);
      }

      Get.off(() =>PunchView(className: widget.className, courseId: widget.courseId, batchId: widget.batchId, batchStartTime: widget.batchStartTime, batchEndTime: widget.batchEndTime, subjectName: widget.subjectName, courseCode: widget.courseCode,));// Return the scanned data
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code Scanner')),
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }
}
