import 'package:get/get.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/network/network_controller.dart';

mixin class NetworkManager {
  Future<bool> hasConnectNetwork() async {
    final networkController = Get.find<NetworkController>();
    if (networkController.connectionStatus.value != WIFI_NETWORK &&
        networkController.connectionStatus.value != MOBILE_NETWORK &&
        networkController.connectionStatus.value != INSTANCE_NETWORK) {
      return false;
    } else {
      return true;
    }
  }
}
