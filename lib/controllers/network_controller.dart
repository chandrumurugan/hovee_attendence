import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hovee_attendence/widget/noInternetConnection.dart';

class NetworkController extends GetxController {
final Connectivity _connectivity = Connectivity();
  bool _isConnected = true; // Track connection status

  @override
  void onInit() {
    super.onInit();
    print("InternetController initialized");
    _checkInitialConnection();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // Check initial connection status
  Future<void> _checkInitialConnection() async {
    print("Checking initial connection");
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    print("Initial connection status: $result");
    _updateConnectionStatus(result);
  }

  // Method to manually check connection
  Future<void> checkConnection() async {
    print("Manually checking connection");
    List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  // Update connection status based on connectivity result
  void _updateConnectionStatus(List<ConnectivityResult> results) {
    print("Network status changed: $results");

    // Check if any of the results indicate a connection
    bool isConnected = results.any((result) =>
        result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile);

    if (isConnected != _isConnected) {
      _isConnected = isConnected;
      if (!_isConnected) {
        print("No internet connection - attempting to show snackbar");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          print("Post frame callback - showing snackbar");
          Get.rawSnackbar(
            titleText: SizedBox(
              width: double.infinity,
              height: Get.size.height / 1.1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: NoInternetConnection(),
              )),
            messageText: Container(),
            backgroundColor: Colors.transparent,
            isDismissible: false,
            duration: const Duration(days: 1),
          );
        });
      } else {
        if (Get.isSnackbarOpen) {
          print("Closing snackbar");
          Get.closeCurrentSnackbar();
        }
      }
    }
  }
}
