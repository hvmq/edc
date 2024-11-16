import 'package:get/get.dart';

import '../../features/mybook/mybook_controller.dart';

class MyBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MybookController>(MybookController());
  }
}
