import 'package:get/get.dart';

import '../controllers/auth_option_controller.dart';

class AuthOptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthOptionController>(() => AuthOptionController());
  }
}
