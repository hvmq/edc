import 'package:get/get.dart';

import '../all.dart';

class EDCPremiumBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EDCPremiumController>(() => EDCPremiumController());
  }
}
