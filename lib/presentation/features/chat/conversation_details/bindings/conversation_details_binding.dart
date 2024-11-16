import 'package:get/get.dart';

import '../controllers/conversation_details_controller.dart';

class ConversationDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConversationDetailsController>(
      () => ConversationDetailsController(),
    );
  }
}
