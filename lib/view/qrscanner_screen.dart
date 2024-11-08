import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/controllers/punch_controller.dart';
import 'package:hovee_attendence/view/punch_view.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QRScannerScreen extends StatefulWidget {


  const QRScannerScreen({
    super.key, 
  });

  @override
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final PunchController _controller = Get.put(PunchController());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code Scanner')),
      body: AiBarcodeScanner(
        onDetect: (po){
           _onBarcodeScanned(po.barcodes.first.rawValue!);
        },
      ),
    );
  }
}
