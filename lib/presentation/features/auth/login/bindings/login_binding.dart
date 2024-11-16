import 'package:get/get.dart';

import '../../../all.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut(() => ForgotPasswordController(), fenix: true);
  }
}
