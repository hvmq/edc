import 'package:get/get.dart';

import '../all.dart';
import 'call_gateway_controller.dart';
import 'call_history/call_history_controller.dart';
import 'contact/all.dart';

class CallGatewayBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CallGatewayController>(CallGatewayController());
    Get.put<CallHistoryController>(CallHistoryController());

    Get.lazyPut<ChatDashboardController>(() => ChatDashboardController());

    Get.lazyPut<ContactController>(() => ContactController());

    // Get.put<HomeController>(HomeController());
    // Get.lazyPut(() => ChatDashboardController());
    // Get.lazyPut<PostsController>(() => PostsController());
    // Get.lazyPut<CommentsController>(() => CommentsController());
    // Get.lazyPut<PersonalPageController>(() => PersonalPageController());
    // Get.lazyPut<SharePostController>(() => SharePostController());

    HomeBinding().dependencies();
  }
}
