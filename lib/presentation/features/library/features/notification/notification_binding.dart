import 'package:get/get.dart';

import '../../features/notification/notification_controller.dart';

class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<NotificationController>(NotificationController());
  }
}
