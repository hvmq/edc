import 'package:get/get.dart';

import '../../features/educhain/educhain_controller.dart';

class EduchainBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<EduchainController>(EduchainController());
  }
}
