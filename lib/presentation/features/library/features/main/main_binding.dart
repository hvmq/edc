import 'package:get/get.dart';

import '../../features/main/main_controller.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());
  }
}
