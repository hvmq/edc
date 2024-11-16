import 'package:get/get.dart';

import '../../features/publicbook/public_book_controller.dart';

class PublicBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PublicBookController>(PublicBookController());
  }
}
