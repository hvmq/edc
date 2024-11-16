import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/utils/constants.dart';

class NetworkController extends GetxController {
  RxInt connectionStatus = INSTANCE_NETWORK.obs; // Current connection status
  final Connectivity _connectivity = Connectivity(); // Connectivity instance
  late StreamSubscription<ConnectivityResult>
      _connectivitySubscription; // Subscription for connectivity changes

  @override
  Future<void> onInit() async {
    super.onInit();
    await initConnectivity(); // Check initial connectivity
    // Listen for changes in connectivity
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _updateConnectionStatus(result); // Update connection status on change
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      // Check current connectivity status
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Error checking connectivity: ${e.toString()}');
      }
      result = ConnectivityResult.none; // Default to no connection on error
    }
    // Update the status based on the result
    _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    print(
        'Check status network: $result'); // Log the current connectivity status
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = WIFI_NETWORK; // Update to WiFi status
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = MOBILE_NETWORK; // Update to Mobile status
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 0; // No connection
        break;
      default:
        break; // Handle any other unexpected cases
    }
  }

  @override
  void onClose() {
    _connectivitySubscription
        .cancel(); // Cancel the subscription when the controller is closed
    super.onClose();
  }
}
