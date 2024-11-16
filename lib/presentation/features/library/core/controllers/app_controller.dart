import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/network/network_controller.dart';
import '../../core/utils/network/network_manager.dart';
import '../../core/utils/show_noti.dart';

class AppController extends GetxController with NetworkManager {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _networkController = Get.find<NetworkController>();
  var _hasNetwork = true;
  StreamSubscription? _connectivitySubscription;
  RxString chooseAddress = ''.obs;
  final Connectivity _connectivity = Connectivity();

  @override
  Future<void> onInit() async {
    super.onInit();
    await checkConnectNetwork();
  }

  Future<void> checkConnectNetwork() async {
    // Check Network
    if (_networkController.connectionStatus.value == 0) {
      _hasNetwork = false;
      await callDialogErrorNetwork();
    }
    _networkController.connectionStatus.listen((status) {
      if (status == 0) {
        _hasNetwork = false;
        callDialogErrorNetwork();
      } else {
        _hasNetwork = true;
      }
    });
  }

  Future<void> callDialogErrorNetwork() async {
    showError('network_error'.tr);
  }
}
