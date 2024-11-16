import 'package:get/get.dart';

import '../../features/reading_book/reading_controller.dart';

class ReadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ReadingController>(ReadingController());
  }
}
