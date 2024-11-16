import 'package:get/get.dart';

import '../../features/edc_zoom/edc_zoom_controller.dart';

class EDCZoomBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<EDCZoomController>(EDCZoomController());
  }
}
