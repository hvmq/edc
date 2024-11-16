import 'package:get/get.dart';

import '../../features/chat/chat_controller.dart';

class ChatBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<ChatController>(ChatController());
  }
}
