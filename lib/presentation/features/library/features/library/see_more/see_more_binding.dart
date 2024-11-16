import 'package:get/get.dart';

import '../../../features/library/see_more/see_more_controller.dart';

class SeeMoreBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SeeMoreController>(SeeMoreController());
  }
}
