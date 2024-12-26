import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  var isConnected = true.obs;
  late OverlayEntry _overlayEntry;

  @override
  void onInit() {
    super.onInit();
    _setupNetworkMonitor();
  }

  void _setupNetworkMonitor() {
    _overlayEntry = _createOverlayEntry();

    // Listen for changes in connectivity
    Connectivity().onConnectivityChanged.listen((result) {
      bool currentStatus = result != ConnectivityResult.none;
      if (currentStatus != isConnected.value) {
        isConnected.value = currentStatus;
        _handleOverlay();
      }
    });
  }

  void _handleOverlay() {
    final overlayContext = Get.overlayContext;

    if (isConnected.value) {
      // Remove the overlay when connected
      _removeOverlay();
    } else if (overlayContext != null) {
      // Show the overlay when disconnected
      Overlay.of(overlayContext)?.insert(_overlayEntry);
    }
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned.fill(
        child: Container(
          color: Colors.black.withOpacity(0.6),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'No Internet Connection',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: retryConnection,
                  child: const Text('Retry'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Open network settings
                    // Get.to(() => const SettingsPage());
                  },
                  child: const Text('Open Settings'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _removeOverlay() {
    if (_overlayEntry.mounted) {
      _overlayEntry.remove();
    }
  }

  void retryConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    isConnected.value = connectivityResult != ConnectivityResult.none;
  }
}
