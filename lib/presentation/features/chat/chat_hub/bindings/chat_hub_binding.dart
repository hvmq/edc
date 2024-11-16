import 'package:get/get.dart';

import '../controllers/chat_hub_controller.dart';
import '../controllers/chat_input_controller.dart';

class ChatHubBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatHubController>(() => ChatHubController(), fenix: true);
    Get.lazyPut<ChatInputController>(
      () => ChatInputController(),
      fenix: true,
    );
  }
}
