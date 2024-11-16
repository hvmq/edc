import 'package:get/get.dart';

import '../../features/account/account_controller.dart';

class AccountBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AccountController>(AccountController());
  }
}
