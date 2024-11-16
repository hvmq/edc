import 'package:get/get.dart';

import 'add_contact_controller.dart';

class AddContactNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddContactNumberController>(() => AddContactNumberController());
  }
}
