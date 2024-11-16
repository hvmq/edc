import 'package:get/get.dart';

import '../../core/utils/network/network_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}
