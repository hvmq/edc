import 'package:get/get.dart';

import '../../features/history/history_controller.dart';

class HistoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<HistoryController>(HistoryController());
  }
}
